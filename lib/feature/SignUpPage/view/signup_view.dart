library signup_view.dart;

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_travel_book/feature/SignUpPage/viewmodel/cubit/cubit/signup_cubit.dart';
import 'package:i_travel_book/core/Helper/shared_preferences.dart';
import 'package:i_travel_book/core/Strings/signupPage_strings.dart';
import 'package:i_travel_book/core/Widgets/authtextfield.dart';
import 'package:i_travel_book/core/color/appcolor..dart';

import 'package:auto_size_text/auto_size_text.dart';
part 'parts/build_form.dart';
part 'signup_body.dart';
part 'parts/build_signupButton.dart';
part 'parts/build_userphoto.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: getBool("darkmode"),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                centerTitle: true,
                title: AutoSizeText("ITravelBook"),
                backgroundColor: !snapshot.data!
                    ? AppColor().appColor
                    : AppColor().darkModeBackgroundColor,
              ),
              body: FutureBuilder<String>(
                  future: getString("language"),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return SignupBody(
                        language: snapshot.data,
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
