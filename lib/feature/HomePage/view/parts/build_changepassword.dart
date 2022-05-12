part of home_view.dart;

class ChangePasswordDialog extends StatelessWidget {
  ChangePasswordDialog(
      {Key? key, required this.isdarkmode, required this.language})
      : super(key: key);
  final GlobalKey<FormState> _formKey =
      new GlobalKey<FormState>(debugLabel: 'changepasskey');
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordController2 = TextEditingController();
  final isdarkmode;
  String language = "";
  initialLanguage() async {
    language = await getString("language");
  }

  @override
  Widget build(BuildContext context) {
    Color changePasswordColor =
        !isdarkmode! ? AppColor().appColor : Colors.white;
    return Form(
      key: _formKey,
      child: AlertDialog(
        title: Text(language =="TR" ? "Şifremi Değiştir" :"Change My Password"),
        content: Container(
          height: context.height / 3.7,
          width: context.width,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return language =="TR" ?  'Bu alan boş bırakılamaz':"This field cannot be left blank";
                    }
                    if (value != _passwordController2.text) {
                      return language =="TR" ?  'İki Şife Birbiri ile uyuşmuyor':"Two Passwords Don't Match Each Other";
                    } else {
                      return null;
                    }
                  },
                  obscureText:
                      context.read<HomeCubit>().changePasswordVisibility,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    suffixIcon: InkWell(
                      onTap: () {
                        context.read<HomeCubit>().changePasswordVisibilty();
                      },
                      child:
                          context.read<HomeCubit>().changePasswordVisibility ==
                                  true
                              ? Icon(
                                  Icons.visibility,
                                  color: changePasswordColor,
                                )
                              : Icon(
                                  Icons.visibility_off,
                                  color: changePasswordColor,
                                ),
                    ),
                    prefixIcon: Icon(
                      Icons.vpn_key,
                      color: changePasswordColor,
                    ),
                    hintText: language =="TR" ?  "Yeni Şifrenizi Giriniz":"Enter Your New Password",
                    prefixText: ' ',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return language =="TR" ?  'Bu alan boş bırakılamaz':"This field cannot be left blank";
                    }
                    if (value != _passwordController.text) {
                      return  language =="TR" ? 'İki Şife Birbiri ile uyuşmuyor':"Two Passwords Don't Match Each Other";
                    } else {
                      return null;
                    }
                  },
                  obscureText:
                      context.read<HomeCubit>().changePasswordVisibility2,
                  controller: _passwordController2,
                  decoration: InputDecoration(
                    suffixIcon: InkWell(
                      onTap: () {
                        context.read<HomeCubit>().changePasswordVisibilty2();
                      },
                      child:
                          context.read<HomeCubit>().changePasswordVisibility2 ==
                                  true
                              ? Icon(
                                  Icons.visibility,
                                  color: changePasswordColor,
                                )
                              : Icon(
                                  Icons.visibility_off,
                                  color: changePasswordColor,
                                ),
                    ),
                    prefixIcon: Icon(
                      Icons.vpn_key,
                      color: changePasswordColor,
                    ),
                    hintText: language =="TR" ?  "Yeni Şifrenizi Tekrarlayın":"Repeat Your New Password",
                    prefixText: ' ',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: context.height / 70),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: AutoSizeText(
                           language =="TR" ?  "İptal" : "Cancel",
                            style: TextStyle(
                              color: changePasswordColor,
                            ),
                          )),
                      TextButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              AuthenticationHelper()
                                  .changePassword(_passwordController2.text)
                                  .then((value) {
                                if (value == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: AutoSizeText(
                                            language =="TR" ?   "Şifreniz Başarıyla Güncellendi" :"Your Password Has Been Updated Successfully")));
                                  putString(
                                      "password", _passwordController2.text);
                                  Navigator.pop(context);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: AutoSizeText(
                                            language =="TR" ?   "Bir Sorun Oluştu. Başarısız İşlem":"A Problem Occurred. Failed Transaction")));
                                  Navigator.pop(context);
                                }
                              });
                            }
                          },
                          child: AutoSizeText(
                           language =="TR" ?  "Değiştir" :"Change",
                            style: TextStyle(
                              color: changePasswordColor,
                            ),
                          ))
                    ],
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
