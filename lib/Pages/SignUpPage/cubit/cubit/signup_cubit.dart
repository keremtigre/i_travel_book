import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());

  TextEditingController emailController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  bool passwordVisibility = true;
  bool passwordVisibility2 = true;

  void changePasswordVisibilty() {
    passwordVisibility == true
        ? passwordVisibility = false
        : passwordVisibility = true;
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
                    title: Text("Kamera"),
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
                    title: Text("Galeri"),
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
                    title: Text("Fotoğrafı Kaldır"),
                  )
                ],
              ));
        });
  }

 


}
