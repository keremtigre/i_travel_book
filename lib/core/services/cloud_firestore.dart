import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class CloudHelper {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Future setProfilePhoto(File? file) async {
    try {
      String file_name = file!.path.split('/').last;
      var download_url;
      String uid = FirebaseAuth.instance.currentUser!.email.toString();
      CollectionReference users =
          FirebaseFirestore.instance.collection("ProfileData");

      if (file.path != '') {
        Reference firebaseStorageRef = FirebaseStorage.instance
            .ref()
            .child('uploads/${uid}/ProfilePhoto/${file_name}');
        UploadTask uploadTask = firebaseStorageRef.putFile(file);
        download_url = await (await uploadTask.whenComplete(() => null))
            .ref
            .getDownloadURL();
      }
      await users
          .doc(uid)
          .update({'userPhoto': file.path != '' ? download_url : ""});
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future setUserName(String? userName) async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.email.toString();
      CollectionReference users =
          FirebaseFirestore.instance.collection("ProfileData");
      await users.doc(uid).update({'userName': userName});
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future deleteImage(String downloadUrl) async {
    if (!downloadUrl.isEmpty) {
      try {
        FirebaseStorage.instance.refFromURL(downloadUrl).delete();
        return null;
      } on FirebaseException catch (e) {
        return e.message;
      }
    }
  }

  Future addUserNamePhoto(File file, String userName,bool privacyAccepted) async {
    try {
      String file_name = file.path.split('/').last;
      var download_url;
      String uid = FirebaseAuth.instance.currentUser!.email.toString();
      CollectionReference users =
          FirebaseFirestore.instance.collection("ProfileData");

      if (file.path != '') {
        Reference firebaseStorageRef = FirebaseStorage.instance
            .ref()
            .child('${uid}/ProfilePhoto/${file_name}');
        UploadTask uploadTask = firebaseStorageRef.putFile(file);
        download_url = await (await uploadTask.whenComplete(() => null))
            .ref
            .getDownloadURL();
      }
      await users.doc(uid).set({
        'userPhoto': file.path != '' ? download_url : "",
        'userName': userName,
        'privacyPolicyAccepted': privacyAccepted
      });
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future addLocation(
      String title, String action, String lat, String lng, File file) async {
    try {
      String file_name = file.path.split('/').last;
      String uid = FirebaseAuth.instance.currentUser!.email.toString();
      CollectionReference users = FirebaseFirestore.instance.collection(uid);
      var download_url;
      if (file.path != '') {
        Reference firebaseStorageRef = FirebaseStorage.instance
            .ref()
            .child('${uid}/LocationPhoto/${file_name}');
        UploadTask uploadTask = firebaseStorageRef.putFile(file);
        download_url = await (await uploadTask.whenComplete(() => null))
            .ref
            .getDownloadURL();
      }

      await users.add({
        'id': Uuid().v4(),
        'title': title,
        'action': action,
        'lat': lat,
        'lng': lng,
        'downloadUrl': file.path != '' ? download_url : "",
        'createdTime': Timestamp.now()
      });
      return null;
    } on FirebaseException catch (error) {
      return error.message;
    }
  }

  Future privacyPolicyAccepted() async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.email.toString();
      CollectionReference snapshot =
          await firebaseFirestore.collection('ProfileData');
      await snapshot.doc(uid).update({'privacyPolicyAccepted': true});
      return null;
    } on FirebaseException catch (e) {
      return e.message;
    }
  }
}
