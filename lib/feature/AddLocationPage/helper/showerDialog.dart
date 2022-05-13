import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:i_travel_book/feature/HomePage/view/home_view.dart';

import 'package:auto_size_text/auto_size_text.dart';

void ShowDialogForAddLocationPage(BuildContext context, String message) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: Text("Uyarı"),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(message),
                TextButton(
                  onPressed: (() => Navigator.pop(context)),
                  child: Text("Tamam"),
                )
              ],
            ));
      });
}

ShowDialogForPermission(BuildContext context) {
  showDialog(
      context: context,
      builder: (builder) => AlertDialog(
            title: Text("Uyarı"),
            content: Text(
                "Konum izni olmadan bu özelliği kullanamazsınız. Uygulama ayarlarından konuma izin verin"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (builder) => HomePage()),
                        (route) => false);
                  },
                  child: Text("Geri Dön")),
              TextButton(
                  onPressed: () async {
                    await Geolocator.openAppSettings();
                  },
                  child: Text("Ayarlara Git"))
            ],
          ));
}
