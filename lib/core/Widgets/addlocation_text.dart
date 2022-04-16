import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_travel_book/feature/SignUpPage/viewmodel/cubit/cubit/signup_cubit.dart';
import 'package:i_travel_book/core/color/appcolor..dart';
import 'package:kartal/kartal.dart';

class AddLocationText extends StatelessWidget {
  String? Function(String?)? validator;
  final String hinntext;
  final TextEditingController controller;
  int maxLength;
  int maxLines;
  AddLocationText({
    Key? key,
    required this.validator,
    required this.hinntext,
    required this.controller,
    required this.maxLength,
    this.maxLines = 1,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        maxLength: maxLength,
        maxLines: maxLines,
        controller: controller,
        validator: validator,
        decoration: DefaultDecoration());
  }

  InputDecoration DefaultDecoration() => InputDecoration(
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
        hintText: hinntext,
        prefixText: ' ',
      );
}
