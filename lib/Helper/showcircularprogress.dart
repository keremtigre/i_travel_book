import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

ShowLoaderDialog(BuildContext context, text) {
  AlertDialog alert = AlertDialog(
    content: Lottie.asset(
      "assets/json/loading_an.json",
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


