import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:i_travel_book/feature/LocationsPage/model/location.dart';
part 'locations_state.dart';

class LocationsCubit extends Cubit<LocationsState> {
  LocationsCubit() : super(LocationsInitial());
  Map<MarkerId, Marker> markers = {};
  List<LocationModel> locationModel = [];
  bool isdarkmode = true;
  TextEditingController searchController = TextEditingController();
  var pageViewController = PageController();
  double originLatitude = 0;
  double originLongitude = 0;
  int pageViewCounter = 1;
  int pageViewTotalCount = 0;
  GoogleMapController? googleMapController;
  late CameraPosition cameraPosition =
      CameraPosition(target: LatLng(originLatitude, originLongitude));
  //initial error hatası için
  LocationPageInit(AsyncSnapshot<QuerySnapshot<Object?>> snapshot) async {
    markers.clear();
    await Future.delayed(Duration(milliseconds: 25));
    getLocations(snapshot);
  }

  getLocations(AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
    if (snapshot.hasData) {
      locationModel = snapshot.data!.docs.map((doc) {
        return LocationModel(
            title: doc["title"],
            action: doc["action"],
            downloadUrl: doc["downloadUrl"],
            lat: doc["lat"],
            lng: doc["lng"]);
      }).toList();
      setPageViewTotalCount();
      emit(LocationsLoaded());
    } else {
      getLocations(snapshot);
    }
  }

  LocationPageDispose(
    BuildContext context,
  ) {
    searchController.clear();
    markers.clear();
    locationModel.clear();
    Navigator.pop(context);
    emit(LocationsInitial());
  }

  searchLocation(AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
    int isCompareCount = -1;
    int index = 0;
    locationModel.clear();
    if (!searchController.text.isEmpty) {
      if (locationModel.length == 0) {
        getLocations(snapshot);
      }
      print("text: " +
          searchController.text +
          ", length: " +
          locationModel.length.toString());
      locationModel = locationModel.where((s) {
        String title = s.title.toLowerCase();
        if (!title.contains(searchController.text.toLowerCase())) {
          markers.clear();
        } else if (title.contains(searchController.text.toLowerCase())) {
          isCompareCount++;
          print(s.title + "else çalıştı");
          return true;
        }

        return false;
      }).toList();
      setPageViewTotalCount();
      print("iscompare çalıştı: " + isCompareCount.toString());
      if (isCompareCount != -1) {
        markers.clear();
        final _lng = double.parse(locationModel[index].lng);
        final _lat = double.parse(locationModel[index].lat);
        getMarker(index, _lat, _lng, "on page changed");
        pageViewCounter = index + 1;
      }
    } else {
      getLocations(snapshot);
      emit(LocationsLoaded());
    }
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
    await Future.delayed(Duration(milliseconds: 5));
    await googleMapController
        ?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            target: LatLng(
              lat,
              lng,
            ),
            zoom: 17)));
  }

  setPageViewTotalCount() {
    pageViewTotalCount = locationModel.length;
  }

  PageViewOnChanged(List<LocationModel> locations, int value) async {
    markers.clear();
    final _lng = double.parse(locations[value].lng);
    final _lat = double.parse(locations[value].lat);
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
     
  

