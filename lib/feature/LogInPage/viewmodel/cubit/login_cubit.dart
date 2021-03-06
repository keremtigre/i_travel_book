import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:i_travel_book/core/Helper/shared_preferences.dart';
import 'package:i_travel_book/core/Helper/showcircularprogress.dart';
import 'package:i_travel_book/core/services/authentication.dart';
import 'package:i_travel_book/core/services/cloud_firestore.dart';
import 'package:i_travel_book/feature/HomePage/view/home_view.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:i_travel_book/feature/LocationsPage/viewmodel/cubit/locations_cubit.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  bool isLodingGoogle = false;
  bool isLodingEmail = false;
  bool passwordVisibility = true;
  bool beniHatirla = false;
  TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey =
      new GlobalKey<FormState>(debugLabel: 'loginkey');
  TextEditingController passwordController = TextEditingController();
  void changeBeniHatirla(bool? value) {
    beniHatirla = value!;
    emit(LoginLoaded());
  }

  setIsLodingGoogle() {
    isLodingGoogle = !isLodingGoogle;
    emit(LoginLoaded());
  }

  loginDispose() {
    emit(LoginInitial());
  }

  loginInitial() async {
    await Future.delayed(Duration(milliseconds: 125));
    emit(LoginLoaded());
  }

  setIsLodingEmail() {
    isLodingEmail = !isLodingEmail;
    emit(LoginLoaded());
  }

  void clearFiled(BuildContext context) {
    passwordController.clear();
    emit(LoginLoaded());
  }

  void changePasswordVisibility() {
    passwordVisibility == true
        ? passwordVisibility = false
        : passwordVisibility = true;
    emit(LoginLoaded());
  }

// Google sign in
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<String?> signInwithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await _auth.signInWithCredential(credential).then((value) async {
        await putBool("hatirla", true);
        if (value.additionalUserInfo!.isNewUser) {
          await CloudHelper().addUserNamePhoto(
              File(''), _auth.currentUser!.displayName!, false);
        } else {
          await CloudHelper().addUserNamePhoto(
              File(''), _auth.currentUser!.displayName!, true);
        }
      });
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw e;
    }
  }

  Future<void> signOutFromGoogle() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
  // sign in with email - password

  LoginWithEmailMethod(BuildContext context) async {
    setIsLodingEmail();
    AuthenticationHelper()
        .signIn(
      email: emailController.text,
      password: passwordController.text,
    )
        .then((value) {
      if (value == null) {
        setIsLodingEmail();
        putBool("hatirla",
            beniHatirla); /* 
        if (beniHatirla == true) {
          putString("loginoption", "withemail");
          putString("email", emailController.text);
          putString("password", passwordController.text);
        } */
        clearFiled(context);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (builder) => HomePage()),
          (route) => false,
        );
      } else {
        setIsLodingEmail();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: AutoSizeText(
          value,
        )));
      }
    });
  }
}
