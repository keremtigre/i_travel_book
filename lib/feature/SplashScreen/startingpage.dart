import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:i_travel_book/feature/HomePage/view/home_view.dart';
import 'package:i_travel_book/feature/LogInPage/view/login_view.dart';
import 'package:i_travel_book/core/Helper/shared_preferences.dart';
import 'package:i_travel_book/feature/StartingPage/startingpage.dart';
import 'package:lottie/lottie.dart';
import 'package:i_travel_book/core/services/authentication.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future _isLogged() async {
    bool _kontrol = await getBool("hatirla");
    if (_kontrol == true) {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null) {
          print('User is currently signed out!');
        } else {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (builder) => HomePage()));
        }
      });
    }
  }

  @override
  void initState() {
    _isLogged();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: AnimatedSplashScreen(
            splashIconSize: 400,
            nextScreen: StartingPage(),
            splash: Image.asset(
              "assets/images/logo.png",
            )),
      ),
    );
  }
}
