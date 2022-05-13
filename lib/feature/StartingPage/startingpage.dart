import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:i_travel_book/core/Helper/shared_preferences.dart';
import 'package:i_travel_book/core/color/appcolor..dart';
import 'package:i_travel_book/feature/LogInPage/view/login_view.dart';
import 'package:i_travel_book/feature/SplashScreen/startingpage.dart';
import 'package:i_travel_book/main.dart';
import 'package:kartal/kartal.dart';

class StartingPage extends StatefulWidget {
  const StartingPage({Key? key}) : super(key: key);

  @override
  State<StartingPage> createState() => _StartingPageState();
}

class _StartingPageState extends State<StartingPage> {
  String dropDownValue = "TR";
  int pageValue = 0;
  bool groupValue = false;
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: getBool("isfirstrun"),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (!snapshot.data!) {
              return Scaffold(
                body: Container(
                  child: Column(
                    children: [
                      Expanded(
                        flex: 4,
                        child: PageView(
                          controller: pageController,
                          onPageChanged: (value) {
                            setState(() {});
                            pageValue = value;
                            print(pageValue);
                          },
                          children: [
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("assets/images/logo.png"),
                                  Text(dropDownValue != "TR"
                                      ? "Please Select Language"
                                      : "Lütfen uygulama dilini seçiniz"),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: context.height / 50),
                                    alignment: Alignment.center,
                                    width: context.width / 3,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            color: AppColor().appColor,
                                            width: 3)),
                                    child: DropdownButton<String>(
                                        elevation: 5,
                                        alignment: Alignment.center,
                                        borderRadius: BorderRadius.circular(20),
                                        focusNode: FocusNode(),
                                        value: dropDownValue,
                                        items: [
                                          DropdownMenuItem(
                                            value: "TR",
                                            child: Text("Türkçe"),
                                          ),
                                          DropdownMenuItem(
                                            value: "EN",
                                            child: Text("English"),
                                          )
                                        ],
                                        onChanged: (value) {
                                          setState(() {});
                                          dropDownValue = value!;
                                        }),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("assets/images/addlocation.png"),
                                  AutoSizeText(
                                    dropDownValue == "TR"
                                        ? "Sevdiğiniz Konumları eklemenize sadece bir adım kaldı"
                                        : "Just one step away from adding your Favorite locations",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 17),
                                  ),
                                  Divider(
                                    thickness: 4,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: AutoSizeText(
                                      dropDownValue == "TR"
                                          ? "Karanlık mod:"
                                          : "Darkmode:",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 17),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: context.height / 30),
                                    child: Row(
                                      children: [
                                        Flexible(
                                          child: Column(
                                            children: [
                                              Container(
                                                height: context.height / 8,
                                                width: context.width / 2.5,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    border: Border.all()),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.all(
                                                          context.width / 50),
                                                      child: AutoSizeText(
                                                        "Title",
                                                      ),
                                                    ),
                                                    Padding(
                                                        padding: EdgeInsets.all(
                                                            context.width / 50),
                                                        child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: AppColor()
                                                                .appColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                          ),
                                                          height:
                                                              context.height /
                                                                  30,
                                                          width:
                                                              context.width / 3,
                                                          child: AutoSizeText(
                                                            "Buton",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ))
                                                  ],
                                                ),
                                              ),
                                              RadioListTile<bool>(
                                                  title: Text(
                                                      dropDownValue == "TR"
                                                          ? "Kapalı"
                                                          : "Off"),
                                                  value: false,
                                                  groupValue: groupValue,
                                                  onChanged: (value) {
                                                    setState(() {});

                                                    groupValue = value!;
                                                  }),
                                            ],
                                          ),
                                        ),
                                        Flexible(
                                          child: Column(
                                            children: [
                                              Container(
                                                height: context.height / 8,
                                                width: context.width / 2.5,
                                                decoration: BoxDecoration(
                                                    color: AppColor()
                                                        .darkModeBackgroundColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    border: Border.all()),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.all(
                                                          context.width / 50),
                                                      child: AutoSizeText(
                                                        "Title",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                    Padding(
                                                        padding: EdgeInsets.all(
                                                            context.width / 50),
                                                        child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: AppColor()
                                                                .appColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                          ),
                                                          height:
                                                              context.height /
                                                                  30,
                                                          width:
                                                              context.width / 3,
                                                          child: AutoSizeText(
                                                            "Buton",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ))
                                                  ],
                                                ),
                                              ),
                                              RadioListTile<bool>(
                                                  title: Text(
                                                      dropDownValue == "TR"
                                                          ? "Açık"
                                                          : "On"),
                                                  value: true,
                                                  groupValue: groupValue,
                                                  onChanged: (value) {
                                                    setState(() {});
                                                    groupValue = value!;
                                                  }),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.only(top: context.height / 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColor().appColor),
                                        color: pageValue == 0
                                            ? AppColor().appColor
                                            : Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    height: 15,
                                    width: 15,
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: pageValue == 1
                                            ? AppColor().appColor
                                            : Colors.white,
                                        border: Border.all(
                                          color: AppColor().appColor,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    height: 15,
                                    width: 15,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: context.width / 30,
                                  right: context.width / 50),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  pageValue == 0
                                      ? Container()
                                      : InkWell(
                                          onTap: () {
                                            pageController.jumpToPage(0);
                                          },
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.arrow_back,
                                                size: 30,
                                              ),
                                              AutoSizeText(
                                                dropDownValue == "TR"
                                                    ? "Geri"
                                                    : "Back",
                                                style: TextStyle(fontSize: 19),
                                              ),
                                            ],
                                          ),
                                        ),
                                  pageValue != 1
                                      ? InkWell(
                                          onTap: () {
                                            pageController.jumpToPage(1);
                                          },
                                          child: Row(
                                            children: [
                                              AutoSizeText(
                                                dropDownValue == "TR"
                                                    ? "İleri"
                                                    : "Next",
                                                style: TextStyle(fontSize: 19),
                                              ),
                                              Icon(
                                                Icons.arrow_forward,
                                                size: 30,
                                              ),
                                            ],
                                          ),
                                        )
                                      : FloatingActionButton.extended(
                                          backgroundColor: AppColor().appColor,
                                          label: Text(
                                            dropDownValue == "TR"
                                                ? "Başla"
                                                : "Get Started",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          onPressed: () async {
                                            putBool("isfirstrun", true);
                                            await putBool(
                                                "darkmode", groupValue);
                                            await putString(
                                                "language", dropDownValue);
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (builder) =>
                                                        MyApp()),
                                                (route) => false);
                                          },
                                        )
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            } else {
              Future.delayed(
                Duration(milliseconds: 100),
                () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (builder) => LoginPage()),
                      (route) => false);
                },
              );
              return Center(child: CircularProgressIndicator());
            }
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
