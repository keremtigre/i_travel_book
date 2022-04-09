import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
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
}
