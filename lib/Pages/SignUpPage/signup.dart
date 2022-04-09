import 'dart:io';

import 'package:flutter/material.dart';
import 'package:i_travel_book/Helper/shared_preferences.dart';
import 'package:i_travel_book/Helper/showcircularprogress.dart';
import 'package:i_travel_book/Pages/LogInPage/login.dart';
import 'package:i_travel_book/Pages/SignUpPage/Widgets/email.dart';
import 'package:i_travel_book/Pages/SignUpPage/Widgets/password_text_2.dart';
import 'package:i_travel_book/Pages/SignUpPage/Widgets/password_text_1.dart';
import 'package:i_travel_book/Pages/SignUpPage/Widgets/user_photo.dart';
import 'package:i_travel_book/Pages/SignUpPage/Widgets/username_text.dart';
import 'package:i_travel_book/Pages/SignUpPage/cubit/cubit/signup_cubit.dart';
import 'package:i_travel_book/Pages/VerifyPage/verify_page.dart';
import 'package:i_travel_book/core/color/appcolor..dart';
import 'package:i_travel_book/services/authentication.dart';
import 'package:i_travel_book/services/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          title: Text("ITravelBook"),
          backgroundColor: AppColor().appColor,
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Row(
                children: [
                  Expanded(
                      child: Transform.rotate(
                          angle: 6,
                          child: Image.asset(
                            "assets/images/signup.png",
                          ))),
                  SizedBox(
                    width: size.width / 7,
                  ),
                  Expanded(
                      child: Transform.rotate(
                          angle: 6,
                          child: Image.asset(
                            "assets/images/signup2.png",
                          ))),
                ],
              ),
              Container(
                child: Form(
                  key: context.read<SignupCubit>().formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: size.height / 13,
                      ),
                      Text(
                        "Kayıt Ol",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: size.height / 30,
                      ),
                      UserPhoto(),
                      SizedBox(
                        height: size.height / 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: UserNameText(),
                      ),
                      SizedBox(
                        height: size.height / 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: EmailTextField(),
                      ),
                      SizedBox(
                        height: size.height / 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: PasswordText1(),
                      ),
                      SizedBox(
                        height: size.height / 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: PasswordText2(),
                      ),
                      SizedBox(
                        height: size.height / 50,
                      ),
                      Container(
                        width: size.width / 4,
                        decoration: BoxDecoration(
                          color: AppColor().appColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(
                          onPressed: () {
                            if (context
                                .read<SignupCubit>()
                                .formKey
                                .currentState!
                                .validate()) {
                              ShowLoaderDialog(context, "Lütfen Bekleyin...");
                              AuthenticationHelper()
                                  .signUp(
                                      email: context
                                          .read<SignupCubit>()
                                          .emailController
                                          .text,
                                      password: context
                                          .read<SignupCubit>()
                                          .passwordController
                                          .text)
                                  .then((value) {
                                if (value == null) {
                                  Navigator.pop(context);
                                  putBool("hatirla", true);
                                  putString(
                                      "email",
                                      context
                                          .read<SignupCubit>()
                                          .emailController
                                          .text);
                                  putString(
                                      "password",
                                      context
                                          .read<SignupCubit>()
                                          .passwordController
                                          .text);
                                  File _Firebaseimage =
                                      BlocProvider.of<SignupCubit>(context,
                                              listen: false)
                                          .image;

                                  CloudHelper()
                                      .addUserNamePhoto(
                                          _Firebaseimage,
                                          context
                                              .read<SignupCubit>()
                                              .userNameController
                                              .text)
                                      .then((value) {
                                    if (value != null) {
                                      debugPrint(_Firebaseimage.path);
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (builder) => LogIn()),
                                        (route) => false,
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text("Sorun Oluştu")));
                                    }
                                  });
                                  // print(
                                  //     "Giriş yapıldı. email: ${context.watch<SignupCubit>().emailController.text} password: " +
                                  //         context.watch<SignupCubit>().passwordController.text);
                                  context
                                      .read<SignupCubit>()
                                      .clearFiled(context);
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (builder) => VerifyPage()),
                                    (route) => true,
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
                            "Kayıt Ol",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height / 50,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
