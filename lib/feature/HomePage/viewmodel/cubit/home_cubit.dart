import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:i_travel_book/admob/admob_helper.dart';
import 'package:i_travel_book/core/Helper/shared_preferences.dart';
import 'package:i_travel_book/core/color/appcolor..dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  String FirebaseuserName = "";
  String FirebaseimageUrl = "";

  bool isdarkmode = false;
  bool isdarkmode2 = false;
  bool changePasswordVisibility = true;
  bool changePasswordVisibility2 = true;
  changeDarkMode() {
    isdarkmode2 = !isdarkmode2;
    emit(HomeLoaded());
  }

  changePasswordVisibilty() {
    if (changePasswordVisibility) {
      changePasswordVisibility = false;
    } else {
      changePasswordVisibility = true;
    }
    emit(HomeLoaded());
  }

  changePasswordVisibilty2() {
    if (changePasswordVisibility) {
      changePasswordVisibility = false;
    } else {
      changePasswordVisibility = true;
    }
    emit(HomeLoaded());
  }

  homeInitState() async {
    await AddmobService.initialize();
    await Geolocator.requestPermission();
    isdarkmode = await getDarkmode();
    emit(HomeLoaded());
  }

  void isDarkModeSelected(bool value) async {
    value == true ? putBool("darkmode", false) : putBool("darkmode", true);
    isdarkmode = !value;
    emit(HomeLoaded());
  }

  Future<bool> getDarkmode() async {
    return await getBool("darkmode");
  }

  Future<ThemeData> getThemeMode() async {
    if (await getBool("darkmode") == true) {
      return darkTheme;
    } else {
      return lightTheme;
    }
  }

  ThemeData lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
        backgroundColor: AppColor().appColor,
      ),
    scaffoldBackgroundColor: Colors.white,
    iconTheme: IconThemeData(color: AppColor().appColor),
    colorScheme: ColorScheme.light(),
  );

  ThemeData darkTheme = ThemeData(
      scaffoldBackgroundColor: AppColor().darkModeBackgroundColor,
      colorScheme: ColorScheme.dark(),
      iconTheme: IconThemeData(color: Colors.white),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColor().darkModeBackgroundColor,
      ));
}
