import 'package:flutter/material.dart';
import 'package:i_travel_book/Helper/shared_preferences.dart';
import 'package:i_travel_book/Helper/showcircularprogress.dart';
import 'package:i_travel_book/Pages/HomePage/home.dart';
import 'package:i_travel_book/Pages/LogInPage/cubit/cubit/login_cubit.dart';
import 'package:i_travel_book/Pages/LogInPage/widgets/emailtext.dart';
import 'package:i_travel_book/Pages/LogInPage/widgets/passwordtext.dart';
import 'package:i_travel_book/Pages/SignUpPage/signup.dart';
import 'package:i_travel_book/core/color/appcolor..dart';
import 'package:i_travel_book/services/authentication.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogIn extends StatelessWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("ITravelBook"),
        ),
        body: Container(
          child: Center(
              child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Transform.rotate(
                        angle: 12,
                        child: Image.asset(
                          "assets/images/login.png",
                          height: size.height / 5,
                          width: size.width / 7,
                          fit: BoxFit.cover,
                        )),
                    Image.asset(
                      "assets/images/login2.png",
                      height: size.height / 5,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
                Form(
                  key: context.read<LoginCubit>().formKey,
                  child: Column(
                    children: [
                      Text(
                        "Giriş Yap",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: size.height / 30,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: size.width / 40, right: size.width / 40),
                        child: EmailTextLogIn(),
                      ),
                      SizedBox(
                        height: size.height / 60,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: size.width / 40, right: size.width / 40),
                        child: PasswordTextLogIn(),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: size.width * 0.05),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Checkbox(
                              activeColor: AppColor().appColor,
                              value: context.watch<LoginCubit>().beniHatirla,
                              onChanged: (bool? value) {
                                context
                                    .read<LoginCubit>()
                                    .changeBeniHatirla(value);
                              },
                            ),
                            Text("Beni Hatırla"),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height / 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: size.width / 4,
                            decoration: BoxDecoration(
                              color: AppColor().appColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextButton(
                              onPressed: () {
                                if (context
                                    .read<LoginCubit>()
                                    .formKey
                                    .currentState!
                                    .validate()) {
                                  ShowLoaderDialog(context, "Giriş Yapılıyor");
                                  AuthenticationHelper()
                                      .signIn(
                                    email: context
                                        .read<LoginCubit>()
                                        .emailController
                                        .text,
                                    password: context
                                        .read<LoginCubit>()
                                        .passwordController
                                        .text,
                                  )
                                      .then((value) {
                                    if (value == null) {
                                      putBool(
                                          "hatirla",
                                          context
                                              .read<LoginCubit>()
                                              .beniHatirla);
                                      if (context
                                              .read<LoginCubit>()
                                              .beniHatirla ==
                                          true) {
                                        putString(
                                            "email",
                                            context
                                                .read<LoginCubit>()
                                                .emailController
                                                .text);
                                        putString(
                                            "password",
                                            context
                                                .read<LoginCubit>()
                                                .passwordController
                                                .text);
                                      }
                                      context
                                          .read<LoginCubit>()
                                          .clearFiled(context);
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (builder) => HomePage()),
                                        (route) => false,
                                      );
                                    } else {
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                        value,
                                      )));
                                    }
                                  });
                                }
                              },
                              child: Text(
                                "Giriş Yap",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          Text("ya da"),
                          Container(
                            width: size.width / 4,
                            decoration: BoxDecoration(
                              color: AppColor().appColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUp()));
                              },
                              child: Text(
                                "Üye Ol",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
        ));
  }
}
