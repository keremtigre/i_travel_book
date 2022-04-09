import 'package:flutter/material.dart';
import 'package:i_travel_book/services/cloud_firestore.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Profilimi Düzenle"),
      content: const Text("Kullanıcı adınızı aşağıdan değiştirebilirsiniz"),
      actions: [
        Form(
          key: _formKey,
          child: TextFormField(
            controller: _controller,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Bu alan boş bırakılamaz";
              } else {
                return null;
              }
            },
            decoration: InputDecoration(hintText: "Kullanıcı Adınızı Giriniz"),
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
                    CloudHelper().setUserName(_controller.text);
                    Navigator.pop(context);
                  }
                },
                child: Text("Onayla"))
          ],
        )
      ],
    );
  }
}
