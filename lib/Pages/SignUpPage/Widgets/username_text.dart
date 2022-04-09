import 'package:flutter/material.dart';
import 'package:i_travel_book/Pages/SignUpPage/cubit/cubit/signup_cubit.dart';
import 'package:i_travel_book/core/color/appcolor..dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class UserNameText extends StatefulWidget {
  UserNameText({Key? key}) : super(key: key);
  @override
  _UserNameTextState createState() => _UserNameTextState();
}

class _UserNameTextState extends State<UserNameText> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Kullanıcı Adınızı Giriniz';
        } else {
          null;
        }
      },
      controller: BlocProvider.of<SignupCubit>(context, listen: false)
          .userNameController,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
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
              color: Color.fromARGB(255, 190, 22, 148),
            )),
        prefixIcon: Icon(
          Icons.person,
          color: AppColor().appColor,
        ),
        hintText: "İsminiz",
        prefixText: ' ',
      ),
    );
  }
}
