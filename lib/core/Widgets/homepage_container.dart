import 'package:flutter/material.dart';
import 'package:i_travel_book/core/Helper/shared_preferences.dart';
import 'package:i_travel_book/core/color/appcolor..dart';

import 'package:auto_size_text/auto_size_text.dart';

class HomePageContainer extends StatelessWidget {
  String assetname;
  double height;
  final bool isdarkmode;
  double width;
  String containerTitle;
  EdgeInsetsGeometry margin;
  HomePageContainer({
    Key? key,
    required this.isdarkmode,
    required this.assetname,
    required this.height,
    required this.width,
    this.margin = EdgeInsets.zero,
    required this.containerTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
            Color settingDrawerColor =
                !isdarkmode ? AppColor().appColor : Colors.white;
            return Column(
              children: [
                Container(
                  height: height,
                  width: width,
                  margin: margin,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        width: 2,
                        color:
                            isdarkmode == false ? Colors.black : Colors.white),
                    image: DecorationImage(
                        image: AssetImage(assetname), fit: BoxFit.cover),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: AutoSizeText(
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
