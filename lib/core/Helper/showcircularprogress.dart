import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

ShowLoaderDialog(BuildContext context,String text,bool isAddLocationPage) {
  AlertDialog alert = AlertDialog(
    backgroundColor: Colors.white.withOpacity(0.9),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
       !isAddLocationPage ? Lottie.asset(
          "assets/json/loading_an.json",
        ) : Lottie.asset(
          "assets/json/addlocationloading.json",
        ) ,
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(text),
        )
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}


