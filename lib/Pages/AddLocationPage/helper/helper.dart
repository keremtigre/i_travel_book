
  import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:i_travel_book/Pages/AddLocationPage/helper/showerDialog.dart';

Future<void> checkLocation(BuildContext context) async {
    LocationPermission _permission;
    _permission = await Geolocator.checkPermission();
    if (!await Geolocator.isLocationServiceEnabled()) {
      await Geolocator.openLocationSettings();
    }
    if (_permission == LocationPermission.denied) {
      ShowDialogForPermission(context);
    }
    if (_permission == LocationPermission.deniedForever) {
      ShowDialogForPermission(context);
    }
  }
