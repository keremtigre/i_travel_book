part of home_view.dart;

class ChangePasswordDialog extends StatelessWidget {
  ChangePasswordDialog({Key? key,required this.isdarkmode}) : super(key: key);
  final GlobalKey<FormState> _formKey =
      new GlobalKey<FormState>(debugLabel: 'changepasskey');
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordController2 = TextEditingController();
  final isdarkmode;
  @override
  Widget build(BuildContext context) {
    Color changePasswordColor =
        !isdarkmode! ? AppColor().appColor : Colors.white;
    return Form(
      key: _formKey,
      child: AlertDialog(
        title: Text("Şifremi Değiştir"),
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
                      return 'Bu alan boş bırakılamaz';
                    }
                    if (value != _passwordController2.text) {
                      return 'İki Şife Birbiri ile uyuşmuyor';
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
                    hintText: "Yeni Şifrenizi Tekrarlayın",
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
                            "İptal",
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
                                              "Şifreniz Başarıyla Güncellendi")));
                                  putString(
                                      "password", _passwordController2.text);
                                  Navigator.pop(context);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: AutoSizeText(
                                              "Bir Sorun Oluştu. Başarısız İşlem")));
                                  Navigator.pop(context);
                                }
                              });
                            }
                          },
                          child: AutoSizeText(
                            "Değiştir",
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
