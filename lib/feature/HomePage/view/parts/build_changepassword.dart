part of home_view.dart;

class ChangePasswordDialog extends StatelessWidget {
  ChangePasswordDialog({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey =
      new GlobalKey<FormState>(debugLabel: 'changepasskey');
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordController2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: AlertDialog(
        title: AutoSizeText("Şifremi Değiştir"),
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
            obscureText: context.read<HomeCubit>().changePasswordVisibility,
            controller: _passwordController,
            decoration: InputDecoration(
              suffixIcon: InkWell(
                onTap: () {
                  context.read<HomeCubit>().changePasswordVisibilty();
                },
                child:
                    context.read<HomeCubit>().changePasswordVisibility == true
                        ? Icon(
                            Icons.visibility,
                          )
                        : Icon(
                            Icons.visibility_off,
                          ),
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
            obscureText: context.read<HomeCubit>().changePasswordVisibility2,
            controller: _passwordController2,
            decoration: InputDecoration(
              suffixIcon: InkWell(
                onTap: () {
                  context.read<HomeCubit>().changePasswordVisibilty2();
                },
                child:
                    context.read<HomeCubit>().changePasswordVisibility2 == true
                        ? Icon(
                            Icons.visibility,
                          )
                        : Icon(
                            Icons.visibility_off,
                          ),
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
                  child: AutoSizeText("İptal")),
              TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      AuthenticationHelper()
                          .changePassword(_passwordController2.text)
                          .then((value) {
                        if (value == null) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: AutoSizeText(
                                  "Şifreniz Başarıyla Güncellendi")));
                          putString("password", _passwordController2.text);
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: AutoSizeText(
                                  "Bir Sorun Oluştu. Başarısız İşlem")));
                          Navigator.pop(context);
                        }
                      });
                    }
                  },
                  child: AutoSizeText("Değiştir"))
            ],
          )
        ],
      ),
    );
  }
}
