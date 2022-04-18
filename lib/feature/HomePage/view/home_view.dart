library home_view.dart;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:i_travel_book/admob/admob_helper.dart';
import 'package:i_travel_book/core/Helper/shared_preferences.dart';
import 'package:i_travel_book/core/Widgets/homepage_container.dart';
import 'package:i_travel_book/core/color/appcolor..dart';
import 'package:i_travel_book/feature/AddLocationPage/view/addlocation_view.dart';
import 'package:i_travel_book/feature/HomePage/Widgets/settings_drawer.dart';
import 'package:i_travel_book/feature/HomePage/viewmodel/cubit/home_cubit.dart';
import 'package:i_travel_book/feature/LocationsPage/view/locations_view.dart';
import 'package:i_travel_book/services/authentication.dart';
import 'package:kartal/kartal.dart';
part 'home_body.dart';
part 'parts/build_scaffoldLeading.dart';
part 'parts/build_scaffoldAppBar.dart';
part 'parts/build_listview.dart';
part 'parts/build_admobBanner.dart';
part 'parts/build_appslogan.dart';
part 'parts/build_homepageImage.dart';
part 'parts/build_welcomeText.dart';
part 'parts/build_changepassword.dart';
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<HomeCubit>().getDarkmode();
    return Scaffold(
      drawer: SettingsDrawer(
        imageUrl: context.read<HomeCubit>().FirebaseimageUrl,
        width: context.width,
        height: context.height,
      ),
      appBar: _BuildScaffoldAppBar(),
      body: HomePageBody(),
    );
  }
}
