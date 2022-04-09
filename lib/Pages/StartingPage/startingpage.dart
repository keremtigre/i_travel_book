import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:i_travel_book/Helper/shared_preferences.dart';
import 'package:i_travel_book/Pages/HomePage/home.dart';
import 'package:i_travel_book/Pages/LogInPage/login.dart';
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
    super.initState();
    Future.delayed(
      Duration(milliseconds: 3000),
      () => Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (builder) => LogIn()), (route) => false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Lottie.asset("assets/json/loading_an2.json", fit: BoxFit.cover),
      ),
    );
  }
}
