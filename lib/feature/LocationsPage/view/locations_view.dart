library locations_view.dart;

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:i_travel_book/core/Widgets/locationPageContainerItem.dart';
import 'package:i_travel_book/core/color/appcolor..dart';
import 'package:i_travel_book/feature/HomePage/view/home_view.dart';
import 'package:i_travel_book/feature/LocationsPage/viewmodel/cubit/locations_cubit.dart';
import 'package:kartal/kartal.dart';
part 'locations_body.dart';
part 'parts/build_googlemap.dart';

class LocationsPage extends StatelessWidget {
  const LocationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
          onWillPop: () async {
            await Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (builder) => HomePage()),
                (route) => false);
            return true;
          },
          child: LocationsPageBody()),
    );
  }
}
