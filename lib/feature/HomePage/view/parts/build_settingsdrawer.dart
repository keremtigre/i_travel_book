part of home_view.dart;

class SettingsDrawer extends StatelessWidget {
  final double height;
  final double width;
  final String imageUrl;
  String language = "";
  SettingsDrawer({
    Key? key,
    required this.height,
    required this.width,
    required this.imageUrl,
  }) : super(key: key);
  initialLanguage() async {
    language = await getString("language");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: getBool("darkmode"),
        builder: (context, snapshot) {
          initialLanguage();
          if (snapshot.hasData) {
            final isdarkmode = snapshot.data;
            Color settingDrawerColor =
                !isdarkmode! ? AppColor().appColor : Colors.white;
            return Drawer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  imageUrl.isEmpty
                      ? CircleAvatar(
                          backgroundColor: settingDrawerColor,
                          minRadius: 40,
                          maxRadius: 40,
                          child: Image.asset("assets/images/profile.png"))
                      : CircleAvatar(
                          minRadius: 40,
                          maxRadius: 40,
                          backgroundImage: NetworkImage(
                            imageUrl,
                          ),
                        ),
                  AutoSizeText(
                    FirebaseAuth.instance.currentUser!.email.toString(),
                    style: TextStyle(
                        color: settingDrawerColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  ListTile(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (builder) {
                            return EditProfile(
                              language: language,
                              isdarkmode: snapshot.data,
                            );
                          });
                    },
                    leading: Icon(
                      Icons.manage_accounts_outlined,
                      size: 32,
                      color: settingDrawerColor,
                    ),
                    title: AutoSizeText(
                      language == "TR" ? "Profilimi Düzenle" : "Edit Profile",
                      style: TextStyle(fontSize: 16, color: settingDrawerColor),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (builder) {
                            return ChangePasswordDialog(
                              language: language,
                              isdarkmode: snapshot.data,
                            );
                          });
                    },
                    leading: Icon(
                      Icons.password_outlined,
                      size: 32,
                      color: settingDrawerColor,
                    ),
                    title: AutoSizeText(
                      language == "TR" ? "Şifremi Değiştir" : "Change Password",
                      style: TextStyle(color: settingDrawerColor, fontSize: 16),
                    ),
                  ),
                  //************* dil değişikliği başlangc */
                  ListTile(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (builder) {
                            return changeLanguage(
                              isdarkmode: snapshot.data,
                            );
                          });
                    },
                    leading: Icon(
                      Icons.translate,
                      size: 32,
                      color: settingDrawerColor,
                    ),
                    title: AutoSizeText(
                      language == "TR" ? "Uygulama Dili" : "App Language",
                      style: TextStyle(fontSize: 16, color: settingDrawerColor),
                    ),
                  ),

                  //************* dil değişikliği son */
                  ListTile(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (builder) {
                            return AlertDialog(
                              title: Text(language == "TR" ? "Çıkış Yap" : "Log Out"),
                              content: Container(
                                height: context.height / 8,
                                width: context.width,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(language == "TR" ? "Çıkış Yapılsın mı ?":"Will be exited. Are you sure ?" ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: context.height / 50),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: AutoSizeText(
                                              language == "TR" ?   "Hayır" :"No",
                                                style: TextStyle(
                                                  color: settingDrawerColor,
                                                ),
                                              )),
                                          TextButton(
                                              onPressed: () {
                                                AuthenticationHelper()
                                                    .signOut();
                                                removeDataSignup();
                                                Navigator.pushAndRemoveUntil(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (builder) =>
                                                            LoginPage()),
                                                    (Route<dynamic> route) =>
                                                        false);
                                              },
                                              child: AutoSizeText(language == "TR" ? "Evet":"Yes",
                                                  style: TextStyle(
                                                      color:
                                                          settingDrawerColor))),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    leading: Icon(
                      Icons.logout,
                      size: 32,
                      color: settingDrawerColor,
                    ),
                    title: AutoSizeText(
                      language == "TR" ? "Oturumu Kapat" : "Login Out",
                      style: TextStyle(color: settingDrawerColor, fontSize: 16),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (builder) {
                            return AlertDialog(
                              title: Text(language == "TR" ? "Hesabı Sil":"Delete Account"),
                              content: Container(
                                height: context.height / 7,
                                width: context.width,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                       language == "TR" ?  "Bu işlemden sonra tüm verileriniz silinecektir. Devam etmek istiyor musunuz ?":"All your data will be deleted after this operation. Do you want to continue?"),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: AutoSizeText(
                                             language == "TR" ?  "Hayır":"No",
                                              style: TextStyle(
                                                color: settingDrawerColor,
                                              ),
                                            )),
                                        TextButton(
                                            onPressed: () {
                                              debugPrint("Hesap Silindi=> " +
                                                  FirebaseAuth.instance
                                                      .currentUser!.email
                                                      .toString());
                                              AuthenticationHelper().deleteUser(
                                                  user: FirebaseAuth
                                                      .instance.currentUser!);
                                              removeData();
                                              Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (builder) =>
                                                          LoginPage()),
                                                  (Route<dynamic> route) =>
                                                      false);
                                            },
                                            child: AutoSizeText(language == "TR" ? "Evet" :"Yes",
                                                style: TextStyle(
                                                  color: settingDrawerColor,
                                                ))),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    leading: Icon(
                      Icons.delete_sweep,
                      size: 32,
                      color: settingDrawerColor,
                    ),
                    title: AutoSizeText(
                      language == "TR" ? "Hesabımı Sil" : "Delete Account",
                      style: TextStyle(color: settingDrawerColor, fontSize: 16),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
