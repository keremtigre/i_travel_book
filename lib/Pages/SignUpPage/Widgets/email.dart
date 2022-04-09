import 'package:flutter/material.dart';
import 'package:i_travel_book/Pages/SignUpPage/cubit/cubit/signup_cubit.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_travel_book/core/color/appcolor..dart';

class EmailTextField extends StatefulWidget {
  EmailTextField({Key? key}) : super(key: key);

  @override
  _EmailTextFieldState createState() => _EmailTextFieldState();
}

class _EmailTextFieldState extends State<EmailTextField> {
  bool _isValidEmail(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'e-mail adresinizi giriniz';
        }
        if (!_isValidEmail(value)) {
          return 'Geçersiz e_mail';
        } else {
          null;
        }
      },
      textInputAction: TextInputAction.next,
      controller: context.watch<SignupCubit>().emailController,
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
            borderSide:
                BorderSide(width: 2, color: Color.fromARGB(255, 190, 22, 148))),
        prefixIcon: Icon(
          Icons.email,
          color: AppColor().appColor,
        ),
        hintText: "e-posta adresinizi giriniz",
        prefixText: ' ',
      ),
    );
  }
}
