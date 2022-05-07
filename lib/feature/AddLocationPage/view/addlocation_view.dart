library addlocation_view.dart;

import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:i_travel_book/core/Helper/showcircularprogress.dart';
import 'package:i_travel_book/core/Strings/addlocation_strings.dart';
import 'package:i_travel_book/core/Widgets/addlocation_text.dart';
import 'package:i_travel_book/core/color/appcolor..dart';
import 'package:i_travel_book/core/services/cloud_firestore.dart';
import 'package:i_travel_book/feature/AddLocationPage/helper/addphotoanimation.dart';
import 'package:i_travel_book/feature/AddLocationPage/helper/helper.dart';
import 'package:i_travel_book/feature/AddLocationPage/helper/showerDialog.dart';
import 'package:i_travel_book/feature/AddLocationPage/viewmodel/cubit/addlocation_cubit.dart';
import 'package:i_travel_book/feature/HomePage/view/home_view.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:i_travel_book/feature/LogInPage/viewmodel/cubit/login_cubit.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:kartal/kartal.dart';
part 'parts/build_googlemap.dart';
part 'addlocation_body.dart';
part 'parts/build_addphoto.dart';
part 'parts/build_infotext.dart';
part 'parts/build_savelocation.dart';

class AddLocationPage extends StatelessWidget {
  final bool isdarkmode;
  const AddLocationPage({Key? key,required this.isdarkmode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AddLocationPageBody(isdarkmode: isdarkmode,),
      floatingActionButton: SaveLocationButton(),
    );
  }
}
