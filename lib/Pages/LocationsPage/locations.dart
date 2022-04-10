import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:i_travel_book/Helper/shared_preferences.dart';
import 'package:i_travel_book/Pages/HomePage/home.dart';
import 'package:i_travel_book/Pages/LocationsPage/Widgets/detailPage.dart';
import 'package:i_travel_book/core/color/appcolor..dart';
import 'package:i_travel_book/services/cloud_firestore.dart';

class Locations extends StatefulWidget {
  const Locations({Key? key}) : super(key: key);

  @override
  _LocationsState createState() => _LocationsState();
}

class _LocationsState extends State<Locations> {
  Map<MarkerId, Marker> markers = {};
  var _pageViewController = PageController();
  double _originLatitude = 37.7660;
  double _originLongitude = 29.0383;
  bool isFirstItem = false;
  int _pageViewCounter = 1;
  int _pageViewTotalCount = 0;
  late CameraPosition _cameraPosition =
      CameraPosition(target: LatLng(_originLatitude, _originLongitude));
  //initial error hatası için
  Completer<GoogleMapController> _controller = Completer();
  //Sayfa ilk kez açıldığında, ilk elemanın konumunu ekranda göstermek için kontrol

  //seçilen karttaki konumu getirir ve yakınlaştırır.
  getMarker(int value, double lat, double lng) async {
    final marker = Marker(
        position: LatLng(lat, lng),
        markerId: MarkerId(
          value.toString(),
        ));
    markers[MarkerId(value.toString())] = marker;
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(
          lat,
          lng,
        ),
        zoom: 17)));
  }

  //izinleri kontrol eden fonksion
  Future<void> checkLocation() async {
    LocationPermission _permission;
    _permission = await Geolocator.checkPermission();
    if (!await Geolocator.isLocationServiceEnabled()) {
      await Geolocator.openLocationSettings();
    }
    if (_permission == LocationPermission.denied) {
      showDialog(
          context: context,
          builder: (builder) => AlertDialog(
                title: Text("Uyarı"),
                content: Text(
                    "Konum izni olmadan bu özelliği kullanamazsınız. Uygulama ayarlarından konuma izin verin"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (builder) => HomePage()),
                            (route) => false);
                      },
                      child: Text("Geri Dön")),
                  TextButton(
                      onPressed: () async {
                        await Geolocator.openAppSettings();
                      },
                      child: Text("Ayarlara Git"))
                ],
              ));
    }
    if (_permission == LocationPermission.deniedForever) {
      showDialog(
          context: context,
          builder: (builder) => AlertDialog(
                title: Text("Uyarı"),
                content: Text(
                    "Konum izni olmadan bu özelliği kullanamazsınız. Uygulama ayarlarından konuma izin verin"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (builder) => HomePage()),
                            (route) => false);
                      },
                      child: Text("Geri Dön")),
                  TextButton(
                      onPressed: () async {
                        await Geolocator.openAppSettings();
                      },
                      child: Text("Ayarlara Git"))
                ],
              ));
    }
  }

  late bool darkmode;
  @override
  void initState() {
    // TODO: implement initState
    checkLocation();
    GetDarkMode();
    super.initState();
  }

  Future<void> GetDarkMode() async {
    darkmode = await getBool("darkmode");
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("value: " + isFirstItem.toString());
    var size = MediaQuery.of(context).size;
    checkLocation();
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection(
                        FirebaseAuth.instance.currentUser!.email.toString())
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    _pageViewTotalCount = snapshot.data!.size;

                    //eğer ilk eleman ise onu çağırır (sadece sayfanın ilk kez Açılışında gerekiyor)
                    if (isFirstItem && snapshot.data!.size != 0) {
                      double _lng =
                          double.parse(snapshot.data!.docs[0].get("lng"));
                      double _lat =
                          double.parse(snapshot.data!.docs[0].get("lat"));
                      getMarker(0, _lat, _lng);
                    } else if (snapshot.data!.size == 0) {
                      markers.clear();
                      isFirstItem = false;

                      debugPrint("value2: " + isFirstItem.toString());
                    }
                  }
                  return Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.white,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: <Widget>[
                        SizedBox(
                          height: double.infinity,
                          width: double.infinity,
                          child: GoogleMap(
                            padding: EdgeInsets.only(bottom: size.height / 2),
                            markers: markers.values.toSet(),
                            myLocationEnabled: true,
                            zoomControlsEnabled: true,
                            myLocationButtonEnabled: true,
                            mapType: MapType.normal,
                            tiltGesturesEnabled: true,
                            compassEnabled: true,
                            scrollGesturesEnabled: true,
                            zoomGesturesEnabled: true,
                            onMapCreated:
                                (GoogleMapController controller) async {
                              var _permision =
                                  await Geolocator.checkPermission();
                              debugPrint("izin: " + _permision.toString());
                              if (await Geolocator.isLocationServiceEnabled()) {
                                setState(() {
                                  //markerın üstüne basıldığında padding işleminin yapılması için
                                });
                                _controller.complete(controller);
                              } else {
                                Geolocator.openLocationSettings();
                              }
                            },
                            initialCameraPosition: _cameraPosition,
                          ),
                        ),
                        Align(
                            alignment: FractionalOffset.bottomCenter,
                            child: SizedBox(
                              height: size.height * .35,
                              width: double.infinity,
                              child: snapshot.hasData
                                  ? snapshot.data!.size != 0
                                      ? PageView.builder(
                                          controller: _pageViewController,
                                          itemCount: _pageViewTotalCount,
                                          padEnds: true,
                                          onPageChanged: (value) {
                                            markers.clear();
                                            final _lng = double.parse(snapshot
                                                .data!.docs[value]
                                                .get("lng"));
                                            final _lat = double.parse(snapshot
                                                .data!.docs[value]
                                                .get("lat"));
                                            getMarker(value, _lat, _lng);
                                            if (value != 0) {
                                              isFirstItem = false;
                                            }
                                            if (value == 0) {
                                              isFirstItem = true;
                                            }
                                            _pageViewCounter = value + 1;

                                            setState(() {});
                                          },
                                          itemBuilder: (context, index) {
                                            if (snapshot.data!.size != 0 &&
                                                index == 0) {
                                              isFirstItem = true;
                                            } else if (snapshot.data!.size !=
                                                    0 &&
                                                index != 0) {
                                              isFirstItem = false;
                                            }
                                            String _url = snapshot
                                                .data!.docs[index]
                                                .get("downloadUrl");

                                            return Container(
                                              margin: EdgeInsets.all(20),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 5,
                                                    child: !_url.isEmpty
                                                        ? ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            child:
                                                                Image.network(
                                                              _url,
                                                              height:
                                                                  size.height,
                                                              width: size.width,
                                                              fit: BoxFit.cover,
                                                              filterQuality:
                                                                  FilterQuality
                                                                      .high,
                                                            ),
                                                          )
                                                        : ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            child: Container(
                                                              color: darkmode ==
                                                                      true
                                                                  ? AppColor()
                                                                      .darkModeBackgroundColor
                                                                  : Colors
                                                                      .white,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              width: double
                                                                  .infinity,
                                                              height: double
                                                                  .infinity,
                                                              child:
                                                                  Image.asset(
                                                                "assets/images/signup.png",
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        IconButton(
                                                            onPressed: () {
                                                              final String
                                                                  _baslik =
                                                                  snapshot
                                                                      .data!
                                                                      .docs[
                                                                          index]
                                                                      .get(
                                                                          "title")
                                                                      .toString();
                                                              final String
                                                                  _aciklama =
                                                                  snapshot
                                                                      .data!
                                                                      .docs[
                                                                          index]
                                                                      .get(
                                                                          "action")
                                                                      .toString();

                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) =>
                                                                          DetailPage(
                                                                            size:
                                                                                size,
                                                                            image_url:
                                                                                _url,
                                                                            aciklama:
                                                                                _aciklama,
                                                                            baslik:
                                                                                _baslik,
                                                                          ));
                                                            },
                                                            icon: Icon(
                                                              Icons
                                                                  .info_outline,
                                                              color: AppColor()
                                                                  .appColor,
                                                              size: 30,
                                                            )),
                                                        Text(_pageViewCounter
                                                                .toString() +
                                                            "/" +
                                                            _pageViewTotalCount
                                                                .toString()),
                                                        IconButton(
                                                            onPressed:
                                                                () async {
                                                              var collection = FirebaseFirestore
                                                                  .instance
                                                                  .collection(FirebaseAuth
                                                                      .instance
                                                                      .currentUser!
                                                                      .email
                                                                      .toString());
                                                              await collection
                                                                  .where('id',
                                                                      isEqualTo: snapshot
                                                                          .data!
                                                                          .docs[
                                                                              index]
                                                                          .get(
                                                                              "id"))
                                                                  .get()
                                                                  .then(
                                                                      (value) {
                                                                if (value !=
                                                                    null) {
                                                                  value
                                                                      .docs
                                                                      .first
                                                                      .reference
                                                                      .delete();
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(SnackBar(
                                                                          content:
                                                                              Text("Seçilen Konum Başarıyla Silindi")));
                                                                }
                                                              });
                                                              await CloudHelper()
                                                                  .deleteImage(
                                                                      _url);
                                                              _pageViewController
                                                                  .jumpToPage(
                                                                      0);
                                                            },
                                                            icon: Icon(
                                                              Icons.delete,
                                                              color: Colors.red,
                                                              size: 30,
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              decoration: BoxDecoration(
                                                color: darkmode == false
                                                    ? Colors.grey.shade100
                                                    : AppColor()
                                                        .darkModeBackgroundColor,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)),
                                              ),
                                            );
                                          })
                                      : AlertDialog(
                                          title: Text("Konum Ekleyin"),
                                          content: Text(
                                              "Eklediğiniz konumlar burada listelenecektir."),
                                        )
                                  : Center(
                                      child: CircularProgressIndicator(),
                                    ),
                            )),
                      ],
                    ),
                  );
                }),
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: AppColor().appColor,
                  size: size.width / 10,
                )),
          ],
        ),
      ),
    );
  }
}
