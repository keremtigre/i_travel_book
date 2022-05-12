library login_view.dart;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:i_travel_book/core/Helper/shared_preferences.dart';
import 'package:i_travel_book/feature/HomePage/view/home_view.dart';
import 'package:i_travel_book/feature/LogInPage/viewmodel/cubit/login_cubit.dart';
import 'package:i_travel_book/feature/SignUpPage/view/signup_view.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:i_travel_book/core/Strings/loginpage_strings.dart';
import 'package:i_travel_book/core/Widgets/authtextfield.dart';
import 'package:i_travel_book/core/color/appcolor..dart';
import 'package:kartal/kartal.dart';
part 'login_body.dart';
part 'parts/build_form.dart';
part 'parts/build_LoginOrSignupButtons.dart';
part 'parts/build_googleSignInButton.dart';
part 'parts/build_checkbox.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: AutoSizeText("ITravelBook"),
      ),
      body: FutureBuilder<String>(
        future: getString("language"),
        builder: (context, snapshot) {
        if (snapshot.hasData) {
          return LoginPageBody(
            language: snapshot.data,
          );
        } else {
          return CircularProgressIndicator();
        }
      }),
    );
  }
}
