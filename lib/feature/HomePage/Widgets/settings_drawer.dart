import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_travel_book/feature/HomePage/Widgets/change_password.dart';
import 'package:i_travel_book/feature/HomePage/Widgets/edit_profile.dart';
import 'package:i_travel_book/feature/HomePage/cubit/home_cubit.dart';
import 'package:i_travel_book/feature/HomePage/home.dart';
import 'package:i_travel_book/feature/LogInPage/view/login_view.dart';
import 'package:i_travel_book/core/Helper/shared_preferences.dart';
import 'package:i_travel_book/core/color/appcolor..dart';
import 'package:i_travel_book/main.dart';
import 'package:i_travel_book/services/authentication.dart';

class SettingsDrawer extends StatefulWidget {
  final double height;
  final double width;
  SettingsDrawer({
    Key? key,
    required this.height,
    required this.width,
    required this.imageUrl,
  }) : super(key: key);
  String imageUrl;
  @override
  State<SettingsDrawer> createState() => _SettingsDrawerState();
}

class _SettingsDrawerState extends State<SettingsDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          widget.imageUrl.isEmpty
              ? CircleAvatar(
                  backgroundColor: AppColor().appColor,
                  minRadius: 40,
                  maxRadius: 40,
                  child: Image.asset("assets/images/profile.png"))
              : CircleAvatar(
                  minRadius: 40,
                  maxRadius: 40,
                  backgroundImage: NetworkImage(
                    widget.imageUrl,
                  ),
                ),
          Text(
            FirebaseAuth.instance.currentUser!.email.toString(),
            style: TextStyle(
                color: AppColor().appColor,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          ListTile(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (builder) {
                    return const EditProfile();
                  });
            },
            leading: Icon(
              Icons.manage_accounts_outlined,
              size: 35,
              color: AppColor().appColor,
            ),
            title: Text(
              "Profilimi Düzenle",
              style: TextStyle(color: AppColor().appColor, fontSize: 16),
            ),
          ),
          ListTile(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (builder) {
                    return const ChangePasswordDiaolog();
                  });
            },
            leading: Icon(
              Icons.password_outlined,
              size: 35,
              color: AppColor().appColor,
            ),
            title: Text(
              "Şifremi Değiştir",
              style: TextStyle(color: AppColor().appColor, fontSize: 16),
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
                                color: AppColor().appColor,
                              ),
                            )),
                        TextButton(
                            onPressed: () {
                              AuthenticationHelper().signOut();
                              removeDataSignup();
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) => LoginPage()),
                                  (Route<dynamic> route) => false);
                            },
                            child: Text("Evet",
                                style: TextStyle(color: AppColor().appColor))),
                      ],
                    );
                  });
            },
            leading: Icon(
              Icons.logout,
              size: 35,
              color: AppColor().appColor,
            ),
            title: Text(
              "Oturumu Kapat",
              style: TextStyle(color: AppColor().appColor, fontSize: 16),
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
                                color: AppColor().appColor,
                              ),
                            )),
                        TextButton(
                            onPressed: () {
                              debugPrint("Hesap Silindi=> " +
                                  FirebaseAuth.instance.currentUser!.email
                                      .toString());
                              AuthenticationHelper().deleteUser(
                                  user: FirebaseAuth.instance.currentUser!);
                              removeData();
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) => LoginPage()),
                                  (Route<dynamic> route) => false);
                            },
                            child: Text("Evet",
                                style: TextStyle(
                                  color: AppColor().appColor,
                                ))),
                      ],
                    );
                  });
            },
            leading: Icon(
              Icons.delete_sweep,
              size: 35,
              color: AppColor().appColor,
            ),
            title: Text(
              "Hesabımı Sil",
              style: TextStyle(color: AppColor().appColor, fontSize: 16),
            ),
          ),
          FutureBuilder<bool>(
              future: getBool("darkmode"),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.light_mode),
                      Switch(
                          value: snapshot.data!,
                          onChanged: (value) {
                            if (value == true) {
                              context
                                  .read<HomeCubit>()
                                  .isDarkModeSelected(false);
                            } else {
                              context
                                  .read<HomeCubit>()
                                  .isDarkModeSelected(true);
                            }
                            debugPrint("gell:" + snapshot.data.toString());
                          }),
                      Icon(Icons.dark_mode),
                    ],
                  );
                } else {
                  return CircularProgressIndicator();
                }
              })
        ],
      ),
    );
  }
}
