library signup_view.dart;

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:i_travel_book/feature/LogInPage/view/login_view.dart';
import 'package:i_travel_book/feature/SignUpPage/viewmodel/cubit/cubit/signup_cubit.dart';
import 'package:i_travel_book/feature/VerifyPage/verify_page.dart';
import 'package:i_travel_book/core/Helper/shared_preferences.dart';
import 'package:i_travel_book/core/Helper/showcircularprogress.dart';
import 'package:i_travel_book/core/Strings/signupPage_strings.dart';
import 'package:i_travel_book/core/Widgets/authtextfield.dart';
import 'package:i_travel_book/core/color/appcolor..dart';
import 'package:i_travel_book/services/authentication.dart';
import 'package:i_travel_book/services/cloud_firestore.dart';

part 'parts/build_form.dart';
part 'signup_body.dart';
part 'parts/build_signupButton.dart';
part 'parts/build_userphoto.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("ITravelBook"),
        backgroundColor: AppColor().appColor,
      ),
      body: SignupBody(),
    );
  }
}
