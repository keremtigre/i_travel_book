import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:i_travel_book/feature/LogInPage/viewmodel/cubit/cubit/login_cubit.dart';
part 'locations_state.dart';

class LocationsCubit extends Cubit<LocationsState> {
  LocationsCubit() : super(LocationsInitial());
  Map<MarkerId, Marker> markers = {};
  var pageViewController = PageController();
  double originLatitude = 37.7660;
  double originLongitude = 29.0383;
  bool isFirstItem = false;
  int pageViewCounter = 1;
  int pageViewTotalCount = 0;
  late CameraPosition cameraPosition =
      CameraPosition(target: LatLng(originLatitude, originLongitude));
  //initial error hatası için
  Completer<GoogleMapController> controller = Completer();

//seçilen karttaki konumu getirir ve yakınlaştırır.
  getMarker(int value, double lat, double lng) async {
    final marker = Marker(
        position: LatLng(lat, lng),
        markerId: MarkerId(
          value.toString(),
        ));
    markers[MarkerId(value.toString())] = marker;
    final GoogleMapController controller = await this.controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(
          lat,
          lng,
        ),
        zoom: 17)));
    emit(LocationsInitial());
    emit(LocationsLoaded());
  }

  setIsFirstItem(bool value) {
    isFirstItem = value;
    emit(LocationsInitial());
    emit(LocationsLoaded());
  }
  incrementPageViewCounter(int value) {
    pageViewCounter = value + 1;
    emit(LocationsInitial());
    emit(LocationsLoaded());
  }

  markerClear() {
    markers.clear();
    emit(LocationsInitial());
    emit(LocationsLoaded());
  }

  IsFirstItemChanged() {
    markers.clear();
    isFirstItem = false;
    emit(LocationsInitial());
    emit(LocationsLoaded());
  }
}
