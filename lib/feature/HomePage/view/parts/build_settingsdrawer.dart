part of home_view.dart;

class SettingsDrawer extends StatelessWidget {
  final double height;
  final double width;
  final String imageUrl;
  const SettingsDrawer({
    Key? key,
    required this.height,
    required this.width,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: getBool("darkmode"),
        builder: (context, snapshot) {
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
                            return EditProfile();
                          });
                    },
                    leading: Icon(
                      Icons.manage_accounts_outlined,
                      size: 35,
                      color: settingDrawerColor,
                    ),
                    title: AutoSizeText(
                      "Profilimi Düzenle",
                      style: TextStyle(fontSize: 16, color: settingDrawerColor),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (builder) {
                            return ChangePasswordDialog();
                          });
                    },
                    leading: Icon(
                      Icons.password_outlined,
                      size: 35,
                      color: settingDrawerColor,
                    ),
                    title: AutoSizeText(
                      "Şifremi Değiştir",
                      style: TextStyle(color: settingDrawerColor, fontSize: 16),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (builder) {
                            return AlertDialog(
                              title: const AutoSizeText("Çkış Yap"),
                              content: const AutoSizeText("Çıkış Yapılsın mı"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: AutoSizeText(
                                      "Hayır",
                                      style: TextStyle(
                                        color: settingDrawerColor,
                                      ),
                                    )),
                                TextButton(
                                    onPressed: () {
                                      AuthenticationHelper().signOut();
                                      removeDataSignup();
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (builder) =>
                                                  LoginPage()),
                                          (Route<dynamic> route) => false);
                                    },
                                    child: AutoSizeText("Evet",
                                        style: TextStyle(
                                            color: settingDrawerColor))),
                              ],
                            );
                          });
                    },
                    leading: Icon(
                      Icons.logout,
                      size: 35,
                      color: settingDrawerColor,
                    ),
                    title: AutoSizeText(
                      "Oturumu Kapat",
                      style: TextStyle(color: settingDrawerColor, fontSize: 16),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (builder) {
                            return AlertDialog(
                              title: const AutoSizeText("Hesabı Sil"),
                              content: const AutoSizeText(
                                  "Bu işlemden sonra tüm verileriniz silinecektir. Devam etmek istiyor musunuz ?"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: AutoSizeText(
                                      "Hayır",
                                      style: TextStyle(
                                        color: settingDrawerColor,
                                      ),
                                    )),
                                TextButton(
                                    onPressed: () {
                                      debugPrint("Hesap Silindi=> " +
                                          FirebaseAuth
                                              .instance.currentUser!.email
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
                                          (Route<dynamic> route) => false);
                                    },
                                    child: AutoSizeText("Evet",
                                        style: TextStyle(
                                          color: settingDrawerColor,
                                        ))),
                              ],
                            );
                          });
                    },
                    leading: Icon(
                      Icons.delete_sweep,
                      size: 35,
                      color: settingDrawerColor,
                    ),
                    title: AutoSizeText(
                      "Hesabımı Sil",
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
