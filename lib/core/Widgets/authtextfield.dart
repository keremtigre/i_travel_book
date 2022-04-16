import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_travel_book/feature/LogInPage/viewmodel/cubit/cubit/login_cubit.dart';
import 'package:i_travel_book/feature/SignUpPage/viewmodel/cubit/cubit/signup_cubit.dart';
import 'package:i_travel_book/core/color/appcolor..dart';
import 'package:kartal/kartal.dart';

class AuthTextField extends StatelessWidget {
  String? Function(String?)? validator;
  final String hinntext;
  final bool isPasswordText;
  final bool isVerifyPassword;
  final TextEditingController controller;
  final bool isLoginCubit;
  AuthTextField(
      {Key? key,
      required this.validator,
      required this.hinntext,
      required this.controller,
      required this.isLoginCubit,
      this.isVerifyPassword = false,
      this.isPasswordText = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        obscureText: isPasswordText == true
            ? PasswordVisibility(isLoginCubit, isVerifyPassword, context)
            : false,
        controller: controller,
        validator: validator,
        keyboardType: isPasswordText == true
            ? TextInputType.text
            : TextInputType.emailAddress,
        decoration: isPasswordText == true
            ? PasswordDecoration(context)
            : MailDecoration());
  }

  InputDecoration MailDecoration() => InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              width: 2,
              color: AppColor().appColor,
            )),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              width: 2,
              color: AppColor().appColor,
            )),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              width: 2,
              color: Colors.red,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              width: 2,
              color: AppColor().appColor,
            )),
        prefixIcon: Icon(Icons.email, color: AppColor().appColor),
        hintText: hinntext,
        prefixText: ' ',
      );

  InputDecoration PasswordDecoration(BuildContext context) => InputDecoration(
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
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              width: 2,
              color: AppColor().appColor,
            )),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              width: 2,
              color: Colors.red,
            )),
        suffixIcon: InkWell(
            onTap: () {
              if (isLoginCubit == true) {
                context.read<LoginCubit>().changePasswordVisibility();
              } else {
                isVerifyPassword == true
                    ? context.read<SignupCubit>().changePasswordVisibilty2()
                    : context.read<SignupCubit>().changePasswordVisibilty();
              }
            },
            child: IconChange(isLoginCubit, context, isVerifyPassword)),
        prefixIcon: Icon(Icons.vpn_key, color: AppColor().appColor),
        hintText: hinntext,
        prefixText: ' ',
      );
}

Icon IconChange(
    bool isLoginCubit, BuildContext context, bool isVerifyPassword) {
  if (isLoginCubit) {
    return context.watch<LoginCubit>().passwordVisibility == true
        ? Icon(Icons.visibility, color: AppColor().appColor)
        : Icon(Icons.visibility_off, color: AppColor().appColor);
  } else {
    if (isVerifyPassword) {
      return context.watch<SignupCubit>().passwordVisibility2 == true
          ? Icon(Icons.visibility, color: AppColor().appColor)
          : Icon(Icons.visibility_off, color: AppColor().appColor);
    } else {
      return context.watch<SignupCubit>().passwordVisibility == true
          ? Icon(Icons.visibility, color: AppColor().appColor)
          : Icon(Icons.visibility_off, color: AppColor().appColor);
    }
  }
}

bool PasswordVisibility(
    bool isLoginCubit, bool isVeifyPassword, BuildContext context) {
  if (isLoginCubit == true) {
    return context.read<LoginCubit>().passwordVisibility;
  } else {
    return isVeifyPassword == true
        ? context.read<SignupCubit>().passwordVisibility2
        : context.read<SignupCubit>().passwordVisibility;
  }
}
