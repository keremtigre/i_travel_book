import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_travel_book/core/Helper/shared_preferences.dart';
import 'package:i_travel_book/feature/HomePage/viewmodel/cubit/home_cubit.dart';
import 'package:i_travel_book/feature/SignUpPage/viewmodel/cubit/cubit/signup_cubit.dart';
import 'package:i_travel_book/core/color/appcolor..dart';
import 'package:kartal/kartal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddLocationText extends StatelessWidget {
  String? Function(String?)? validator;
  final String hinntext;
  final TextEditingController controller;
  final String title;
  int maxLength;
  int maxLines;
  AddLocationText({
    Key? key,
    required this.validator,
    required this.hinntext,
    required this.controller,
    required this.maxLength,
    required this.title,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: getBool("darkmode"),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final isdarkmode = snapshot.data;
            Color settingDrawerColor =
                isdarkmode! ? AppColor().appColor : Colors.white;
            return Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 2, color: AppColor().appColor)),
              margin: EdgeInsets.only(
                  top: context.height / 40,
                  right: context.width / 30,
                  left: context.width / 30),
              child: ExpansionTile(title: Text(title), children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: context.width / 50, right: context.width / 50),
                  child: TextFormField(
                      maxLength: maxLength,
                      maxLines: maxLines,
                      controller: controller,
                      validator: validator,
                      decoration: DefaultDecoration(isdarkmode)),
                ),
              ]),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  InputDecoration DefaultDecoration(bool isdarkmode) => InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 2,
              color: !isdarkmode ? AppColor().appColor : Colors.white,
            )),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 2,
              color: AppColor().appColor,
            )),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 2,
              color: Colors.red,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 2,
              color: AppColor().appColor,
            )),
        hintText: hinntext,
        prefixText: ' ',
      );
}
