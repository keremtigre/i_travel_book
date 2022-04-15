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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: size.height / 30),
                  child: Image.asset(
                    "assets/images/login2.png",
                    height: size.height / 5,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: size.height / 25),
                  child: Form(
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
                                    ShowLoaderDialog(
                                        context, "Giriş Yapılıyor");
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
                        Container(
                          height: size.height / 15,
                          width: size.width / 2,
                          margin: EdgeInsets.all(size.height / 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: AppColor().appColor),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextButton(
                            onPressed: () async {
                              await context
                                  .read<LoginCubit>()
                                  .signInwithGoogle();
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) => HomePage()),
                                  (route) => false);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  "assets/images/google.png",
                                  height: size.height / 25,
                                  fit: BoxFit.cover,
                                ),
                                Text(
                                  "Google ile Giriş Yap",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
