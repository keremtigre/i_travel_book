import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:i_travel_book/feature/LogInPage/view/login_view.dart';
import 'package:i_travel_book/feature/VerifyPage/verify_page.dart';
import 'package:i_travel_book/core/Helper/shared_preferences.dart';
import 'package:i_travel_book/core/Helper/showcircularprogress.dart';
import 'package:i_travel_book/core/services/authentication.dart';
import 'package:i_travel_book/core/services/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());

  TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey =
      new GlobalKey<FormState>(debugLabel: 'signupKey');
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  bool passwordVisibility = true;
  bool passwordVisibility2 = true;
  bool isLoading = false;
  void changePasswordVisibilty() {
    passwordVisibility == true
        ? passwordVisibility = false
        : passwordVisibility = true;
    emit(SignupInitial());
  }

  setIsloading() {
    isLoading = !isLoading;
    emit(SignupInitial());
  }

  void changePasswordVisibilty2() {
    passwordVisibility2 == true
        ? passwordVisibility2 = false
        : passwordVisibility2 = true;
    emit(SignupInitial());
  }

  File image = File('');
  updateImageFile(File file) {
    image = file;
    emit(SignupInitial());
    print("PRpathh1: " + image.path);
  }

  void clearFiled(BuildContext context) {
    clearImageFile();
    userNameController.clear();
    emailController.clear();
    passwordController.clear();
    passwordController2.clear();
    emit(SignupInitial());
  }

  clearImageFile() {
    image = File('');
    emit(SignupInitial());
    print("PRpathh2: " + image.path);
  }

  Future pickImage(BuildContext context) async {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 4,
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.camera),
                    title: AutoSizeText("Kamera"),
                    onTap: () async {
                      try {
                        final image = await ImagePicker()
                            .pickImage(source: ImageSource.camera);
                        if (image == null) return;
                        final imageTemporary = File(image.path);
                        updateImageFile(imageTemporary);
                        Navigator.pop(context);
                      } on PlatformException catch (e) {
                        print("başarısız oldu " + e.message.toString());
                      }
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.collections),
                    title: AutoSizeText("Galeri"),
                    onTap: () async {
                      try {
                        final image = await ImagePicker().pickImage(
                            source: ImageSource.gallery,
                            imageQuality: 50,
                            maxHeight: 480,
                            maxWidth: 640);
                        if (image == null) return;
                        final imageTemporary = File(image.path);
                        updateImageFile(imageTemporary);
                        Navigator.pop(context);
                      } on PlatformException catch (e) {
                        print("başarısız oldu " + e.message.toString());
                      }
                    },
                  ),
                  ListTile(
                    onTap: () {
                      updateImageFile(File(''));
                      Navigator.pop(context);
                    },
                    leading: Icon(Icons.delete),
                    title: AutoSizeText("Fotoğrafı Kaldır"),
                  )
                ],
              ));
        });
  }

  SignupWithEmail(BuildContext context) async {
    setIsloading();
    AuthenticationHelper()
        .signUp(email: emailController.text, password: passwordController.text)
        .then((value) {
      if (value == null) {
        setIsloading();
        Navigator.pop(context);
        putBool("hatirla", true);
        putString("email", emailController.text);
        putString("password", passwordController.text);
        File _Firebaseimage = image;

        CloudHelper()
            .addUserNamePhoto(_Firebaseimage, userNameController.text,false)
            .then((value) {
          if (value != null) {
            setIsloading();
            debugPrint(_Firebaseimage.path);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (builder) => LoginPage()),
              (route) => false,
            );
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: AutoSizeText("Sorun Oluştu")));
          }
        });
        // print(
        //     "Giriş yapıldı. email: ${context.watch<SignupCubit>().emailController.text} password: " +
        //         context.watch<SignupCubit>().passwordController.text);
        clearFiled(context);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (builder) => VerifyPage()),
          (route) => true,
        );
      } else {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: AutoSizeText(
          value,
        )));
      }
    });
  }
}
