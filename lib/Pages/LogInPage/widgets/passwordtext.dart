import 'package:flutter/material.dart';
import 'package:i_travel_book/Pages/LogInPage/cubit/cubit/login_cubit.dart';
import 'package:i_travel_book/core/color/appcolor..dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordTextLogIn extends StatelessWidget {
  const PasswordTextLogIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: context.watch<LoginCubit>().passwordVisibility,
      controller: context.read<LoginCubit>().passwordController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Şifrenizi Giriniz";
        } else {
          return null;
        }
      },
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
        suffixIcon: InkWell(
          onTap: () {
            context.read<LoginCubit>().changePasswordVisibility();
          },
          child: context.watch<LoginCubit>().passwordVisibility == true
              ? Icon(Icons.visibility, color: AppColor().appColor)
              : Icon(Icons.visibility_off, color: AppColor().appColor),
        ),
        prefixIcon: Icon(Icons.vpn_key, color: AppColor().appColor),
        hintText: "Şifrenizi Giriniz",
        prefixText: ' ',
      ),
    );
  }
}
