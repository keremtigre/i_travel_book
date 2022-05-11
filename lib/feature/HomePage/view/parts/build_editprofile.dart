part of home_view.dart;

class EditProfile extends StatelessWidget {
  EditProfile({Key? key, required this.isdarkmode}) : super(key: key);

  final GlobalKey<FormState> _formKey =
      new GlobalKey<FormState>(debugLabel: 'editProfile');
  TextEditingController _controller = TextEditingController();
  final isdarkmode;
  @override
  Widget build(BuildContext context) {
    Color editProfileColor = !isdarkmode! ? AppColor().appColor : Colors.white;
    return AlertDialog(
      scrollable: true,
      alignment: Alignment.center,
      title: Text("Profilimi Düzenle"),
      content: Container(
        height: context.height / 3.8,
        width: context.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Kullanıcı adınızı aşağıdan değiştirebilirsiniz"),
            Padding(
              padding: EdgeInsets.only(top: context.height / 50),
              child: Form(
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
                    hintText: "Kullanıcı adınızı giriniz",
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
                        "İptal",
                        style: TextStyle(color: editProfileColor),
                      )),
                  TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          CloudHelper().setUserName(_controller.text);
                          Navigator.pop(context);
                        }
                      },
                      child: AutoSizeText("Onayla",
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
