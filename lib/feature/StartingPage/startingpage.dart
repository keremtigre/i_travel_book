import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:i_travel_book/feature/HomePage/view/home_view.dart';
import 'package:i_travel_book/feature/LogInPage/view/login_view.dart';
import 'package:i_travel_book/core/Helper/shared_preferences.dart';
import 'package:lottie/lottie.dart';
import 'package:i_travel_book/services/authentication.dart';
import 'package:provider/provider.dart';

class StartingPage extends StatefulWidget {
  const StartingPage({Key? key}) : super(key: key);

  @override
  State<StartingPage> createState() => _StartingPageState();
}

class _StartingPageState extends State<StartingPage> {
  Future _isLogged() async {
    bool _kontrol = await getBool("hatirla");
    print("shared email : " + await getString("email"));
    print("shared password : " + await getString("password"));
    print("shared hatirla : " + _kontrol.toString());
    if (_kontrol == true) {
      String _emailLogged = await getString("email");
      String _passwordLogged = await getString("password");
      AuthenticationHelper()
          .signIn(email: _emailLogged, password: _passwordLogged)
          .then((value) {
        if (value == null) {
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
            nextScreen: LoginPage(),
            splash: Expanded(
                child: Image.asset(
              "assets/images/logo.png",
            ))),
      ),
    );
  }
}
