import 'package:flutter/material.dart';
import 'package:i_travel_book/Pages/SignUpPage/cubit/cubit/signup_cubit.dart';
import 'package:i_travel_book/core/color/appcolor..dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordText2 extends StatefulWidget {
  PasswordText2({Key? key}) : super(key: key);
  @override
  _PasswordText2State createState() => _PasswordText2State();
}

class _PasswordText2State extends State<PasswordText2> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Bu alan boş bırakılamaz';
        }
        if (value !=
            BlocProvider.of<SignupCubit>(context, listen: false)
                .passwordController
                .text) {
          return 'İki Şife Birbiri ile uyuşmuyor';
        } else {
          return null;
        }
      },
      obscureText: context.watch<SignupCubit>().passwordVisibility2,
      textInputAction: TextInputAction.done,
      controller: BlocProvider.of<SignupCubit>(context, listen: false)
          .passwordController2,
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
        suffixIcon: InkWell(
          onTap: () {
            context.read<SignupCubit>().changePasswordVisibilty2();
          },
          child: context.watch<SignupCubit>().passwordVisibility2 == true
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
