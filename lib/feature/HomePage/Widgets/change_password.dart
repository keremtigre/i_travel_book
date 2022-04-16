import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:i_travel_book/core/Helper/shared_preferences.dart';
import 'package:i_travel_book/services/authentication.dart';

class ChangePasswordDiaolog extends StatefulWidget {
  const ChangePasswordDiaolog({Key? key}) : super(key: key);
  @override
  _ChangePasswordDiaologState createState() => _ChangePasswordDiaologState();
}

class _ChangePasswordDiaologState extends State<ChangePasswordDiaolog> {
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisibility = true;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordController2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: AlertDialog(
        title: Text("Şifremi Değiştir"),
        actions: [
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Bu alan boş bırakılamaz';
              }
              if (value != _passwordController2.text) {
                return 'İki Şife Birbiri ile uyuşmuyor';
              } else {
                return null;
              }
            },
            obscureText: _passwordVisibility,
            controller: _passwordController,
            decoration: InputDecoration(
              suffixIcon: InkWell(
                onTap: () {
                  setState(() {});
                  if (_passwordVisibility == true) {
                    _passwordVisibility = false;
                  } else {
                    _passwordVisibility = true;
                  }
                },
                child: _passwordVisibility == true
                    ? Icon(Icons.visibility, color: Colors.blue)
                    : Icon(Icons.visibility_off, color: Colors.blue),
              ),
              prefixIcon: Icon(
                Icons.vpn_key,
              ),
              hintText: "Yeni Şifrenizi Giriniz",
              prefixText: ' ',
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Bu alan boş bırakılamaz';
              }
              if (value != _passwordController.text) {
                return 'İki Şife Birbiri ile uyuşmuyor';
              } else {
                return null;
              }
            },
            obscureText: _passwordVisibility,
            controller: _passwordController2,
            decoration: InputDecoration(
              suffixIcon: InkWell(
                onTap: () {
                  setState(() {});
                  if (_passwordVisibility == true) {
                    _passwordVisibility = false;
                  } else {
                    _passwordVisibility = true;
                  }
                },
                child: _passwordVisibility == true
                    ? Icon(Icons.visibility, color: Colors.blue)
                    : Icon(Icons.visibility_off, color: Colors.blue),
              ),
              prefixIcon: Icon(
                Icons.vpn_key,
              ),
              hintText: "Yeni Şifrenizi Tekrarlayın",
              prefixText: ' ',
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("İptal")),
              TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      AuthenticationHelper()
                          .changePassword(_passwordController2.text)
                          .then((value) {
                        if (value == null) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Şifreniz Başarıyla Güncellendi")));
                          putString("password", _passwordController2.text);
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text("Bir Sorun Oluştu. Başarısız İşlem")));
                          Navigator.pop(context);
                        }
                      });
                    }
                  },
                  child: Text("Değiştir"))
            ],
          )
        ],
      ),
    );
  }
}
