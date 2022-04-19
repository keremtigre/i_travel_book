import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_travel_book/core/Helper/shared_preferences.dart';
import 'package:i_travel_book/core/color/appcolor..dart';
import 'package:i_travel_book/feature/HomePage/viewmodel/cubit/home_cubit.dart';
import 'package:kartal/kartal.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    this.margin = EdgeInsets.zero,
    required this.containerTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: getBool("darkmode"),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final isdarkmode = snapshot.data!;
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
                  child: Text(
                    containerTitle,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
