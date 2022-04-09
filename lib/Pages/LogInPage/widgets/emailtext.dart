import 'package:flutter/material.dart';
import 'package:i_travel_book/Pages/LogInPage/cubit/cubit/login_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_travel_book/core/color/appcolor..dart';

class EmailTextLogIn extends StatelessWidget {
  const EmailTextLogIn({Key? key}) : super(key: key);
  bool _isValidEmail(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: context.read<LoginCubit>().emailController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Lütfen e-mail adresinizi giriniz";
        }
        if (!_isValidEmail(value)) {
          return "Geçersiz e-mail";
        } else {
          return null;
        }
      },
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              width: 2,
              color: AppColor().appColor,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              width: 2,
              color: AppColor().appColor,
            )),
        prefixIcon: Icon(Icons.email, color: AppColor().appColor),
        hintText: "e-posta adresinizi giriniz",
        prefixText: ' ',
      ),
    );
  }
}
