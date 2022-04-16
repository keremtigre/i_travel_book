import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:i_travel_book/feature/AddLocationPage/helper/addphotoanimation.dart';
import 'package:i_travel_book/feature/AddLocationPage/helper/helper.dart';
import 'package:i_travel_book/feature/AddLocationPage/helper/showerDialog.dart';
import 'package:i_travel_book/core/Helper/showcircularprogress.dart';
import 'package:i_travel_book/core/color/appcolor..dart';
import 'package:i_travel_book/feature/HomePage/view/home_view.dart';
import 'package:i_travel_book/services/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class AddLocation extends StatefulWidget {
  const AddLocation({Key? key}) : super(key: key);

  @override
  _AddLocationState createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {
  InterstitialAd? _interstitialAd;
  double _originLatitude = 0;
  double _originLongitude = 0;
  File? image;
  Map<MarkerId, Marker> markers = {};
  late CameraPosition _cameraPosition =
      CameraPosition(target: LatLng(_originLatitude, _originLongitude));
  final _formKey = GlobalKey<FormState>();
  final _placeTitleTextController = TextEditingController();
  final _placeDetailTextController = TextEditingController();
  bool _photoIsSelected = false;
  bool _isInterstitialAdReady = false;
  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: "ca-app-pub-3940256099942544/1033173712",
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          this._interstitialAd = ad;
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
            },
          );
          _isInterstitialAdReady = true;
        },
        onAdFailedToLoad: (err) {
          print('Failed to load an interstitial ad: ${err.message}');
          _isInterstitialAdReady = false;
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    checkLocation(context);
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Form(
          key: _formKey,
          child: ListView(
            children: [
              Container(
                width: double.infinity,
                height: size.height / 3.5,
                child: Stack(
                  children: [
                    GoogleMap(
                      onLongPress: (argument) async {
                        if (await InternetConnectionChecker().hasConnection &&
                            await Geolocator.isLocationServiceEnabled()) {
                          setState(() {});
                          //eklenen markerları silmek için yaptım
                          markers.clear();
                          //MarkerId için addres geldi
                          String address = await GetAddressFromLatLong(
                              argument.latitude, argument.longitude);
                          //Konumu Kaydet Butonu için gereken atamalar yapıldı
                          _originLatitude = argument.latitude;
                          _originLongitude = argument.longitude;
                          //marker oluşturuluyor
                          final marker = Marker(
                              markerId: MarkerId(address), position: argument);
                          markers[MarkerId(address)] = marker;
                          debugPrint("lat: " +
                              _originLatitude.toString() +
                              " long: " +
                              _originLongitude.toString());
                        } else if (await InternetConnectionChecker()
                                    .hasConnection ==
                                false &&
                            await Geolocator.isLocationServiceEnabled() ==
                                false) {
                          ShowDialogForAddLocationPage(context,
                              "Internet ve Konum özelliğinizin açık olduğundan emin olun");
                        } else if (await InternetConnectionChecker()
                                .hasConnection ==
                            false) {
                          ShowDialogForAddLocationPage(
                              context, "Internet Bağlantınızı Kontrol Ediniz");
                        } else if (await Geolocator
                                .isLocationServiceEnabled() ==
                            false) {
                          ShowDialogForAddLocationPage(
                              context, "Konumunuzun açık olduğundan emin olun");
                        }
                      },
                      markers: markers.values.toSet(),
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                      zoomControlsEnabled: true,
                      mapType: MapType.normal,
                      tiltGesturesEnabled: true,
                      compassEnabled: true,
                      scrollGesturesEnabled: true,
                      zoomGesturesEnabled: true,
                      onMapCreated: (GoogleMapController controller) async {
                        var _permision = await Geolocator.checkPermission();
                        debugPrint("izin: " + _permision.toString());
                        if (await Geolocator.isLocationServiceEnabled() &&
                                _permision == LocationPermission.whileInUse ||
                            _permision == LocationPermission.always) {
                          var position = await Geolocator.getCurrentPosition(
                              desiredAccuracy: LocationAccuracy.high);
                          controller.animateCamera(
                              CameraUpdate.newCameraPosition(CameraPosition(
                                  target: LatLng(
                                    position.latitude,
                                    position.longitude,
                                  ),
                                  zoom: 17)));
                        } else {
                          checkLocation(context);
                        }
                      },
                      initialCameraPosition: _cameraPosition,
                    ),
                    Positioned(
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: AppColor().appColor,
                          size: size.width / 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height / 40,
              ),
              SizedBox(
                width: size.width,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                              image == null
                                  ? "Fotoğraf ekleyebilirsiniz"
                                  : "Fotoğraf Eklendi",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: size.height / 100,
                            ),
                            InkWell(
                                onTap: (() {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  pickImage(size);
                                  debugPrint(image.toString());
                                }),
                                child: image == null
                                    ? Container(
                                        width: size.width / 3,
                                        height: size.height / 6,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppColor().appColor,
                                              width: 5),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: AddPhotoAnimation())
                                    : Container(
                                        width: size.width / 3,
                                        height: size.height / 6,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Image.file(
                                            image!,
                                            fit: BoxFit.cover,
                                          ),
                                        ))),
                          ],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  width: 2, color: AppColor().appColor),
                              color: Colors.white.withOpacity(0.6),
                            ),
                            height: size.height / 10,
                            width: size.width / 2,
                            child: Text(
                              "Seçmek istediğiniz konumun üzerine birkaç saniye basılı tutunuz",
                              style: TextStyle(color: Colors.black),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: size.height / 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: TextFormField(
                        maxLength: 30,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Bu alan boş bırakılamaz";
                          } else {
                            return null;
                          }
                        },
                        textInputAction: TextInputAction.next,
                        controller: _placeTitleTextController,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  width: 2,
                                  color: AppColor().appColor,
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 190, 22, 148))),
                            hintText:
                                "Konumunuza Başlık Ekleyin (Örn. *Ev,Cafe...)"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: TextFormField(
                        maxLines: 2,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Bu alan boş bırakılamaz";
                          } else {
                            return null;
                          }
                        },
                        maxLength: 120,
                        textInputAction: TextInputAction.done,
                        controller: _placeDetailTextController,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  width: 2,
                                  color: AppColor().appColor,
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 190, 22, 148))),
                            hintText:
                                "Konumunuzla ilgili ayrıntı ekleyebilirsiniz"),
                      ),
                    ),
                    SizedBox(height: size.height / 20),
                  ],
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          elevation: 10,
          backgroundColor: AppColor().appColor,
          label: Text(
            "Kaydet",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () async {
            if (_formKey.currentState!.validate() &&
                await InternetConnectionChecker().hasConnection == false) {
              ShowDialogForAddLocationPage(
                  context, "Internet Bağlantınızı Kontrol Edin");
            }
            if (_formKey.currentState!.validate() && markers.isEmpty) {
              ShowDialogForAddLocationPage(
                  context, "lütfen Haritadan Konum Seçiniz");
            }
            if (_formKey.currentState!.validate() &&
                !markers.isEmpty &&
                await InternetConnectionChecker().hasConnection) {
              ShowLoaderDialog(context, "Konum kaydediliyor...");
              CloudHelper()
                  .addLocation(
                _placeTitleTextController.text,
                _placeDetailTextController.text,
                _originLatitude.toString(),
                _originLongitude.toString(),
                image != null ? image! : File(''),
              )
                  .then((value) {
                if (value == null) {
                  if (_isInterstitialAdReady) {
                    _interstitialAd?.show();
                  }
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (builder) => HomePage()),
                      (route) => false);

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      duration: Duration(milliseconds: 100),
                      backgroundColor: AppColor().appColor,
                      content: Text("Konum Eklendi")));
                } else if (value != null) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(value.toString())));
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (builder) => HomePage()),
                      (route) => false);
                }
              });
            }
          },
        ),
      ),
    );
  }

  // MarkerId için mevcut kordinatın cadde-sokak ve kapı numarasını aldım
  Future<String> GetAddressFromLatLong(double lat, double long) async {
    String _address;
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
    Placemark place = placemarks[0];
    return _address = '${place.thoroughfare}-${place.subThoroughfare}';
  }

  Future pickImage(Size size) async {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
              width: double.infinity,
              height: size.height / 3.5,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: Icon(Icons.camera),
                    title: Text("Kamera"),
                    onTap: () async {
                      try {
                        final image = await ImagePicker().pickImage(
                            source: ImageSource.camera,
                            imageQuality: 50,
                            maxHeight: 480,
                            maxWidth: 640);
                        if (image == null) return;
                        final imageTemporary = File(image.path);
                        setState(() {
                          this.image = imageTemporary;
                        });
                        Navigator.pop(context);
                      } on PlatformException catch (e) {
                        print("başarısız oldu " + e.message.toString());
                      }
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.collections),
                    title: Text("Galeri"),
                    onTap: () async {
                      try {
                        final image = await ImagePicker().pickImage(
                            source: ImageSource.gallery,
                            imageQuality: 50,
                            maxHeight: 480,
                            maxWidth: 640);
                        if (image == null) return;
                        final imageTemporary = File(image.path);
                        setState(() {
                          this.image = imageTemporary;
                        });
                        Navigator.pop(context);
                      } on PlatformException catch (e) {
                        print("başarısız oldu " + e.message.toString());
                      }
                    },
                  ),
                  ListTile(
                    onTap: () {
                      this.image = null;
                      Navigator.pop(context);
                      setState(() {});
                    },
                    leading: Icon(Icons.delete),
                    title: Text("Fotoğrafı Kaldır"),
                  )
                ],
              ));
        });
  }
}
