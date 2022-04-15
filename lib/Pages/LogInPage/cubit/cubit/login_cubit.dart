import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:i_travel_book/services/cloud_firestore.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  bool passwordVisibility = true;
  bool beniHatirla = false;
  TextEditingController emailController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  void changeBeniHatirla(bool? value) {
    beniHatirla = value!;
    emit(LoginInitial());
  }

  void clearFiled(BuildContext context) {
    passwordController.clear();
    emit(LoginInitial());
  }

  void changePasswordVisibility() {
    passwordVisibility == true
        ? passwordVisibility = false
        : passwordVisibility = true;
    emit(LoginInitial());
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<String?> signInwithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await _auth.signInWithCredential(credential);
      await CloudHelper()
          .addUserNamePhoto(File(''), _auth.currentUser!.displayName!);
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw e;
    }
  }

  Future<void> signOutFromGoogle() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
