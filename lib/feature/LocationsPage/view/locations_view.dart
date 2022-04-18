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
import 'package:i_travel_book/feature/HomePage/viewmodel/cubit/home_cubit.dart';
import 'package:i_travel_book/feature/LocationsPage/viewmodel/cubit/locations_cubit.dart';
import 'package:kartal/kartal.dart';
part 'locations_body.dart';
part 'parts/build_googlemap.dart';
part 'parts/build_detailpage.dart';

class LocationsPage extends StatelessWidget {
  const LocationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isdarkmode = context.read<HomeCubit>().isdarkmode2;
    Color settingDrawerColor = !isdarkmode ? AppColor().appColor : Colors.white;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: !isdarkmode ? AppColor().appColor : AppColor().darkModeBackgroundColor,
        elevation: 0,
        title: Text("Konumlarım"),
        centerTitle: true,
      ),
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
