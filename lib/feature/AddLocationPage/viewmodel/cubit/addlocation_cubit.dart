import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:i_travel_book/feature/AddLocationPage/helper/helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kartal/kartal.dart';

part 'addlocation_state.dart';

class AddlocationCubit extends Cubit<AddlocationState> {
  AddlocationCubit() : super(AddlocationInitial());
  InterstitialAd? interstitialAd;
  double originLatitude = 0;
  double originLongitude = 0;
  File? image;
  Map<MarkerId, Marker> markers = {};
  late CameraPosition cameraPosition =
      CameraPosition(target: LatLng(originLatitude, originLongitude));
  final GlobalKey<FormState> formKey =
      new GlobalKey<FormState>(debugLabel: 'addlocationkey');
  final placeTitleTextController = TextEditingController();
  final placeDetailTextController = TextEditingController();
  bool photoIsSelected = false;
  bool isInterstitialAdReady = false;

  //sayfa açıldığında yapılacaklar
  AddLocationInit(BuildContext context) async {
    loadInterstitialAd();
    checkLocation(context);
    print("add init çalıştı");
    await Future.delayed(Duration(milliseconds: 25));
    emit(AddLocationLoaded());
  }

  addLocationDispose(BuildContext context) async {
    markers.clear();
    placeDetailTextController.clear();
    placeTitleTextController.clear();
    image = null;
    print("add dispose çalıştı");
    emit(AddLocationLoaded());
  }

//markerr güncelle
  updateMarker(String address, Marker marker) {
    markers[MarkerId(address)] = marker;
    emit(AddLocationLoaded());
  }

  clearMarker() {
    markers.clear();
    emit(AddLocationLoaded());
  }

  updateLocation(LatLng argument) {
    originLatitude = argument.latitude;
    originLongitude = argument.longitude;
    emit(AddLocationLoaded());
  }

//Konum Ekledikten sonra reklam çıkması için
  void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: "ca-app-pub-3940256099942544/1033173712",
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          this.interstitialAd = ad;
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
            },
          );
          isInterstitialAdReady = true;
        },
        onAdFailedToLoad: (err) {
          print('Failed to load an interstitial ad: ${err.message}');
          isInterstitialAdReady = false;
        },
      ),
    );
    emit(AddLocationLoaded());
  }

//pick image
  Future pickImage(BuildContext context) async {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
              width: double.infinity,
              height: context.height / 3.5,
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

                        this.image = imageTemporary;

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

                        this.image = imageTemporary;

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
                    },
                    leading: Icon(Icons.delete),
                    title: Text("Fotoğrafı Kaldır"),
                  )
                ],
              ));
        });
  }
}
