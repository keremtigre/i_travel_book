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
                  Text(
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
                            return  EditProfile();
                          });
                    },
                    leading: Icon(
                      Icons.manage_accounts_outlined,
                      size: 35,
                      color: settingDrawerColor,
                    ),
                    title: Text(
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
                    title: Text(
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
                              title: const Text("Çkış Yap"),
                              content: const Text("Çıkış Yapılsın mı"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
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
                                    child: Text("Evet",
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
                    title: Text(
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
                              title: const Text("Hesabı Sil"),
                              content: const Text(
                                  "Bu işlemden sonra tüm verileriniz silinecektir. Devam etmek istiyor musunuz ?"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
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
                                    child: Text("Evet",
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
                    title: Text(
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
