library locations_view.dart;

import 'package:flutter/services.dart' show rootBundle;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:i_travel_book/core/Helper/shared_preferences.dart';
import 'package:i_travel_book/core/Widgets/locationPageContainerItem.dart';
import 'package:i_travel_book/core/color/appcolor..dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:i_travel_book/feature/LocationsPage/viewmodel/cubit/locations_cubit.dart';
import 'package:kartal/kartal.dart';
part 'locations_body.dart';
part 'parts/build_googlemap.dart';
part 'parts/build_detailpage.dart';
part 'parts/build_searchText.dart';

class LocationsPage extends StatelessWidget {
  final bool isdarkmode;
  LocationsPage({Key? key, required this.isdarkmode, required this.language})
      : super(key: key);
  String language;
  @override
  Widget build(BuildContext context) {
    Color settingDrawerColor = !isdarkmode ? AppColor().appColor : Colors.white;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                context.read<LocationsCubit>().LocationPageDispose(context);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => LocationsPage(
                            language: language, isdarkmode: isdarkmode)),
                    (route) => false);
              },
              child: Text(
                language == "TR" ? "Sayfayı Yenile" : "Refresh Page",
                style: TextStyle(color: Colors.white),
              ))
        ],
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              context.read<LocationsCubit>().LocationPageDispose(context);
            }),
        backgroundColor: !isdarkmode
            ? AppColor().appColor
            : AppColor().darkModeBackgroundColor,
        elevation: 0,
        title: AutoSizeText(language == "TR" ? "Konumlarım" : "Locations"),
        centerTitle: true,
      ),
      body: WillPopScope(
          onWillPop: () async {
            context.read<LocationsCubit>().LocationPageDispose(
                  context,
                );
            return true;
          },
          child: LocationsPageBody(
            isdarkmode: isdarkmode,
          )),
    );
  }
}
