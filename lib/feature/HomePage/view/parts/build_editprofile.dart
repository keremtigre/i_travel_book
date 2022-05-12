part of home_view.dart;

class EditProfile extends StatelessWidget {
  EditProfile({Key? key, required this.isdarkmode, required this.language})
      : super(key: key);

  final GlobalKey<FormState> _formKey =
      new GlobalKey<FormState>(debugLabel: 'editProfile');
  TextEditingController _controller = TextEditingController();
  final isdarkmode;
  String language = "";
  initialLanguage() async {
    language = await getString("language");
  }

  @override
  Widget build(BuildContext context) {
    initialLanguage();
    Color editProfileColor = !isdarkmode! ? AppColor().appColor : Colors.white;
    return AlertDialog(
      scrollable: true,
      alignment: Alignment.center,
      title: Text(language =="TR" ? "Profilimi Düzenle" : "Edit Profile"),
      content: Container(
        height: context.height / 3.8,
        width: context.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(language =="TR" ?  "Kullanıcı adınızı aşağıdan değiştirebilirsiniz" :"You can change your username below"),
            Padding(
              padding: EdgeInsets.only(top: context.height / 50),
              child: Form(
                key: _formKey,
                child: TextFormField(
                  controller: _controller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return language =="TR" ? "Bu alan boş bırakılamaz" : "This field cannot be left blank";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          width: 2,
                          color: editProfileColor,
                        )),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          width: 2,
                          color: editProfileColor,
                        )),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          width: 2,
                          color: Colors.red,
                        )),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          width: 2,
                          color: editProfileColor,
                        )),
                    prefixIcon: Icon(Icons.person, color: editProfileColor),
                    hintText: language =="TR" ? "Kullanıcı adınızı giriniz":"Enter your username",
                    prefixText: ' ',
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: context.height / 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: AutoSizeText(
                       language =="TR" ?  "İptal":"Cancel",
                        style: TextStyle(color: editProfileColor),
                      )),
                  TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          CloudHelper().setUserName(_controller.text);
                          Navigator.pop(context);
                        }
                      },
                      child: AutoSizeText(language =="TR" ?  "Değiştir": "Change",
                          style: TextStyle(color: editProfileColor)))
                ],
              ),
            )
          ],
        ),
      ),
      /*actions: [
        
        
      ], */
    );
  }
}
