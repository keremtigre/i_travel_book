import 'package:flutter/material.dart';
import 'package:i_travel_book/core/color/appcolor..dart';
import 'package:kartal/kartal.dart';

class HomePageContainer extends StatelessWidget {
  String assetname;
  double height;
  double width;
  String containerTitle;
  EdgeInsetsGeometry margin;
  HomePageContainer({
    Key? key,
    required this.assetname,
    required this.height,
    required this.width,
    this.margin=EdgeInsets.zero,
    required this.containerTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: height,
          width: width,
          margin: margin,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 2, color: AppColor().appColor),
            image: DecorationImage(
                image: AssetImage(assetname), fit: BoxFit.cover),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            containerTitle,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }
}