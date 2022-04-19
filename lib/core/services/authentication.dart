import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:i_travel_book/core/Helper/shared_preferences.dart';

class AuthenticationHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  get user => _auth.currentUser;

//User SignUp Process
  Future signUp({String? email, String? password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email!, password: password!);
      print("Hesap Oluşturuldu " +
          FirebaseAuth.instance.currentUser!.email.toString());
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future signIn({String? email, String? password}) async {
    try {
      //Giriş Yapıldı
      await _auth.signInWithEmailAndPassword(
          email: email!, password: password!);
      print("Giriş Yapıldı " +
          FirebaseAuth.instance.currentUser!.email.toString());
      //Eğer hesap Daha önce Doğrulanmadıysa Hesab Firebase'den siliniyor.
      if (!user!.emailVerified) {
        removeData();
        deleteUser(user: user);
        return "Hesap Bulunamadı";
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future deleteUser({User? user}) async {
    if (user != null) {
      print("Kullanıcı Silindi " +
          FirebaseAuth.instance.currentUser!.email.toString());
      Reference storageRef1 =
          FirebaseStorage.instance.ref(user.email).child('LocationPhoto');
      Reference storageRef2 =
          FirebaseStorage.instance.ref(user.email).child('ProfilePhoto');
      storageRef1.listAll().then((value) {
        value.items.forEach((element) {
          element.delete();
        });
      });
      storageRef2.listAll().then((value) {
        value.items.forEach((element) {
          element.delete();
        });
      });
      var snapshots = await FirebaseFirestore.instance
          .collection(user.email.toString())
          .get();
      for (var doc in snapshots.docs) {
        doc.reference.delete();
      }
      FirebaseFirestore.instance
          .collection("ProfileData")
          .doc(user.email.toString())
          .delete();
      user.delete();
      print("Sil Çalıştı");
      return "Hesap Silindi";
    } else {
      return "bir sorun oluştu";
    }
  }

  Future signOut() async {
    print(
        "Çıkış Yapıldı " + FirebaseAuth.instance.currentUser!.email.toString());
    await _auth.signOut();
    print("SignUp Çalıştı");
  }

  Future changePassword(String password) async {
    try {
      await user.updatePassword(password);
      return null;
    } on FirebaseAuthException catch (e) {
      return "Bir sorun oluşu";
    }
  }
}
