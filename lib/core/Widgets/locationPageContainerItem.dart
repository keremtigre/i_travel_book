import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_travel_book/core/Helper/shared_preferences.dart';
import 'package:i_travel_book/core/color/appcolor..dart';
import 'package:i_travel_book/core/services/cloud_firestore.dart';
import 'package:i_travel_book/feature/LocationsPage/view/locations_view.dart';
import 'package:i_travel_book/feature/LocationsPage/viewmodel/cubit/locations_cubit.dart';
import 'package:kartal/kartal.dart';

import 'package:auto_size_text/auto_size_text.dart';

class LocationsContainer extends StatelessWidget {
  final int pageViewCount;
  final int pageViewTotalCount;
  final String url;
  final String title;
  final String detail;
  final int index;
  final language;
  final bool isdarkmode;
  final AsyncSnapshot<QuerySnapshot<Object?>> snapshot2;
  const LocationsContainer(
      {Key? key,
      required this.detail,
      required this.isdarkmode,
      required this.index,
      required this.language,
      required this.pageViewCount,
      required this.pageViewTotalCount,
      required this.title,
      required this.snapshot2,
      required this.url})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Color settingDrawerColor = !isdarkmode ? AppColor().appColor : Colors.white;
    return Container(
      margin: EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: !url.isEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      url,
                      height: context.height,
                      width: context.width,
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                        color: isdarkmode
                            ? AppColor().darkModeBackgroundColor
                            : Colors.white,
                        borderRadius: BorderRadius.circular(25)),
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: double.infinity,
                    child: Image.asset(
                      "assets/images/signup.png",
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      final String _baslik = title;
                      final String _aciklama = detail;

                      showDialog(
                          context: context,
                          builder: (context) => DetailPage(
                                language: language,
                                image_url: url,
                                aciklama: _aciklama,
                                baslik: _baslik,
                              ));
                    },
                    icon: Icon(
                      Icons.info_outline,
                      color: AppColor().appColor,
                      size: 30,
                    )),
                AutoSizeText(pageViewCount.toString() +
                    "/" +
                    pageViewTotalCount.toString()),
                IconButton(
                    onPressed: () async {
                      context
                          .read<LocationsCubit>()
                          .deleteLocation(snapshot2, index, context, url);
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 30,
                    )),
              ],
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: isdarkmode
            ? AppColor().darkModeBackgroundColor
            : Colors.grey.shade100,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
    );
  }
}
