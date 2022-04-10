import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:i_travel_book/Helper/shared_preferences.dart';
import 'package:i_travel_book/core/color/appcolor..dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  void isDarkModeSelected(bool value) async {
    value == true ? putBool("darkmode", false) : putBool("darkmode", true);
    emit(HomeInitial());
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
      scaffoldBackgroundColor: Colors.white,
      colorScheme: ColorScheme.light(),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColor().appColor,
      ));

  ThemeData darkTheme = ThemeData(
      scaffoldBackgroundColor: AppColor().darkModeBackgroundColor,
      colorScheme: ColorScheme.dark(),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColor().appColor,
      ));
}
