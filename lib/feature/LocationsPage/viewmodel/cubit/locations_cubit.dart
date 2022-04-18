import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
part 'locations_state.dart';

class LocationsCubit extends Cubit<LocationsState> {
  LocationsCubit() : super(LocationsInitial());
  Map<MarkerId, Marker> markers = {};
  var pageViewController = PageController();
  double originLatitude = 0;
  double originLongitude = 0;
  int pageViewCounter = 1;
  int pageViewTotalCount = 0;
  GoogleMapController? googleMapController;
  late CameraPosition cameraPosition =
      CameraPosition(target: LatLng(originLatitude, originLongitude));
  //initial error hatası için
  LocationPageInit() async {
    markers.clear();
    await Future.delayed(Duration(milliseconds: 100));
    emit(LocationsLoaded());
  }


  //seçilen karttaki konumu getirir ve yakınlaştırır.
  getMarker(int value, double lat, double lng, String nereden) async {
    print("getmarker çalıştı ==> " + nereden);
    final marker = Marker(
        position: LatLng(lat, lng),
        markerId: MarkerId(
          value.toString(),
        ));
    markers[MarkerId(value.toString())] = marker;
    await Future.delayed(Duration(milliseconds: 100));
    await googleMapController
        ?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            target: LatLng(
              lat,
              lng,
            ),
            zoom: 17)));

    emit(LocationsLoaded());
  }

  PageViewOnChanged(
      AsyncSnapshot<QuerySnapshot<Object?>> snapshot, int value) async {
    markers.clear();
    final _lng = double.parse(await snapshot.data!.docs[value].get("lng"));
    final _lat = double.parse(await snapshot.data!.docs[value].get("lat"));
    getMarker(value, _lat, _lng, "on page changed");
    pageViewCounter = value + 1;
    emit(LocationsLoaded());
  }

//func1
  func1() {
    markers.clear();
    emit(LocationsLoaded());
  }
}
//pageview değiştiğinde
     
  

