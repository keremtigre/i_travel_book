import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:i_travel_book/feature/HomePage/view/home_view.dart';

import 'package:auto_size_text/auto_size_text.dart';
void ShowDialogForAddLocationPage(BuildContext context, String message) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(actions: [
          TextButton(
            onPressed: (() => Navigator.pop(context)),
            child: AutoSizeText("Tamam"),
          )
        ], title: AutoSizeText("Uyarı"), content: AutoSizeText(message));
      });
}

ShowDialogForPermission(BuildContext context) {
  showDialog(
      context: context,
      builder: (builder) => AlertDialog(
            title: AutoSizeText("Uyarı"),
            content: AutoSizeText(
                "Konum izni olmadan bu özelliği kullanamazsınız. Uygulama ayarlarından konuma izin verin"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (builder) => HomePage()),
                        (route) => false);
                  },
                  child: AutoSizeText("Geri Dön")),
              TextButton(
                  onPressed: () async {
                    await Geolocator.openAppSettings();
                  },
                  child: AutoSizeText("Ayarlara Git"))
            ],
          ));
}
