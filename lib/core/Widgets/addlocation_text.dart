import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:i_travel_book/core/Helper/shared_preferences.dart';
import 'package:i_travel_book/core/color/appcolor..dart';
import 'package:kartal/kartal.dart';

class AddLocationText extends StatelessWidget {
  String? Function(String?)? validator;
  final String hinntext;
  final TextEditingController controller;
  final String title;
  int maxLength;
  int maxLines;
  final bool isdarkmode;
  AddLocationText({
    Key? key,
    required this.validator,
    required this.hinntext,
    required this.controller,
    required this.maxLength,
    required this.title,
    required this.isdarkmode,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color settingDrawerColor = isdarkmode ? AppColor().appColor : Colors.white;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 2, color: AppColor().appColor)),
      margin: EdgeInsets.only(
          top: context.height / 40,
          right: context.width / 30,
          left: context.width / 30),
      child: ExpansionTile(
        initiallyExpanded: true,
        title: AutoSizeText(title), children: [
        Padding(
          padding: EdgeInsets.only(
              left: context.width / 50, right: context.width / 50),
          child: TextFormField(
              maxLength: maxLength,
              maxLines: maxLines,
              controller: controller,
              validator: validator,
              decoration: DefaultDecoration(isdarkmode,hinntext)),
        ),
      ]),
    );
  }
}

InputDecoration DefaultDecoration(bool isdarkmode,String hinntext) => InputDecoration(
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
