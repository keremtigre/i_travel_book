import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:i_travel_book/core/color/appcolor..dart';
import 'package:i_travel_book/feature/HomePage/view/home_view.dart';
import 'package:i_travel_book/core/services/authentication.dart';

class VerifyPage extends StatefulWidget {
  const VerifyPage({Key? key}) : super(key: key);

  @override
  _VerifyPageState createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  Timer? timer;
  final auth = FirebaseAuth.instance;
  User? user;
  @override
  void initState() {
    user = auth.currentUser;
    user!.sendEmailVerification();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    final _auth = FirebaseAuth.instance;
    if (!_auth.currentUser!.emailVerified) {
      AuthenticationHelper().deleteUser(user: _auth.currentUser);
    }
    timer!.cancel();
    // TODO: implement dispose
    super.dispose();
  }

  Future<bool> _onWillPopScope() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const AutoSizeText('Emin misiniz ?'),
            content: const AutoSizeText(
                'Bu adımdan sonra uygulama kapatılacak ve tüm kayıt olma işlemi iptal olacak kabul ediyor musunuz ?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: AutoSizeText(
                  'Hayır',
                  style: TextStyle(color: AppColor().appColor),
                ),
              ),
              TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: AutoSizeText(
                    'Evet',
                    style: TextStyle(color: AppColor().appColor),
                  )),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: _onWillPopScope,
      child: Scaffold(
        backgroundColor: AppColor().appColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AutoSizeText(user!.email.toString(),
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              SizedBox(
                height: 20,
              ),
              Image(
                image: AssetImage("assets/images/email_verify.png"),
                width: size.width * .75,
                height: size.height * .35,
              ),
              AutoSizeText(
                "Devam etmek için lütfen size gönderilen linke tıklayıp mail adresinizi doğrulayınız.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> checkEmailVerified() async {
    user = auth.currentUser;
    await user!.reload();
    if (user!.emailVerified) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (builder) => HomePage()),
        (route) => false,
      );
    }
  }
}
