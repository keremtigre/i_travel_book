import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:i_travel_book/core/services/cloud_firestore.dart';
import 'package:i_travel_book/feature/HomePage/view/home_view.dart';
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
  bool newLocationAdded = false;
  int pageViewCounter = 1;
  int pageViewTotalCount = 0;
  Completer gMapCompleter = Completer();
  late CameraPosition cameraPosition =
      CameraPosition(target: LatLng(originLatitude, originLongitude));
  //initial error hatası için
  LocationPageInit(AsyncSnapshot<QuerySnapshot<Object?>> snapshot) async {
    markers.clear();
    await Future.delayed(Duration(milliseconds: 400));
    getLocations(snapshot);
  }

  initialGoogleMapController(GoogleMapController googleMapController) async {
    if (gMapCompleter.isCompleted) {
    } else {
      gMapCompleter.complete(googleMapController);

      emit(LocationsLoaded());
    }
  }

  deleteLocation(AsyncSnapshot<QuerySnapshot<Object?>> snapshot2, int index,
      BuildContext context, String url) async {
    var collection = FirebaseFirestore.instance
        .collection(FirebaseAuth.instance.currentUser!.email.toString());
    await collection
        .where('id', isEqualTo: snapshot2.data!.docs[index].get("id"))
        .get()
        .then((value) {
      if (value != null) {
        value.docs.first.reference.delete();
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: AutoSizeText("Seçilen Konum Başarıyla Silindi")));
      }
    });
    await CloudHelper().deleteImage(url);
    locationModel.removeAt(index);
    pageViewTotalCount--;
    pageViewController.jumpToPage(0);
    emit(LocationsLoaded());
  }

  getLocations(AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
    if (snapshot.hasData) {
      locationModel.clear();
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
    gMapCompleter = Completer();
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder) {
      emit(LocationsInitial());

      return HomePage();
    }), (route) => false);
  }

  searchLocations(AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
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
          print(s.title + " else çalıştı");
          return true;
        }

        return false;
      }).toList();
      setPageViewTotalCount();
      print("iscompare çalıştı: " + isCompareCount.toString());
      if (isCompareCount != -1) {
        markers.clear();
        locationModel.sort((a, b) => a.title.length.compareTo(b.title.length));
        final _lng = double.parse(locationModel[index].lng);
        final _lat = double.parse(locationModel[index].lat);
        getMarker(index, _lat, _lng, "on page changed");
        pageViewCounter = index + 1;
        emit(LocationsLoaded());
      }
    } else {
      getLocations(snapshot);
      emit(LocationsLoaded());
    }
  }

  setNewLocationAdded(bool value) {
    newLocationAdded = value;
    emit(LocationsLoaded());
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
        if (title == searchController.text.toLowerCase()) {
          isCompareCount++;
          print(s.title + " else else çalıştı");
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
        emit(LocationsLoaded());
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
    GoogleMapController googleMapController = await gMapCompleter.future;
    await googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
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
     
  

