import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:i_travel_book/feature/HomePage/home.dart';

void ShowDialogForAddLocationPage(BuildContext context, String message) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(actions: [
          TextButton(
            onPressed: (() => Navigator.pop(context)),
            child: Text("Tamam"),
          )
        ], title: Text("Uyarı"), content: Text(message));
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
