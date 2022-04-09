import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:i_travel_book/Pages/AddLocationPage/add_location.dart';
import 'package:i_travel_book/Pages/HomePage/Widgets/settings_drawer.dart';
import 'package:i_travel_book/Pages/LocationsPage/Locations.dart';
import 'package:i_travel_book/admob/admob_helper.dart';
import 'package:i_travel_book/core/color/appcolor..dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  String userName = "";
  String imageUrl = "";
  @override
  void initState() {
    AddmobService.initialize();
    Geolocator.requestPermission();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection("ProfileData").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            snapshot.data!.docs.forEach((element) {
              if (element.id == _auth.currentUser!.email.toString()) {
                userName = element["userName"];
                imageUrl = element["userPhoto"];
              }
            });
          }
          return Scaffold(
            backgroundColor: Colors.white,
            drawer: SettingsDrawer(
              imageUrl: imageUrl,
              width: size.width,
              height: size.height,
            ),
            appBar: AppBar(
              centerTitle: true,
              leading: Builder(
                //End Drawer Widgetına context parametresini göndermek için Builder ile Sarmalandı
                //Yoksa Hata verir
                builder: (context) {
                  return IconButton(
                    color: Colors.white,
                    icon: CircleAvatar(
                      backgroundColor: AppColor().appColor,
                      radius: 40,
                      child: imageUrl.isEmpty
                          ? Image.asset(
                              "assets/images/profile.png",
                              fit: BoxFit.cover,
                            )
                          : CircleAvatar(
                              minRadius: 40,
                              maxRadius: 40,
                              backgroundImage: NetworkImage(
                                imageUrl,
                              )),
                    ),
                    onPressed: () {
                      setState(() {});
                      Scaffold.of(context).openDrawer();
                    },
                  );
                },
              ),
              elevation: 0,
              backgroundColor: Colors.white,
              title: Text(
                'ITravelBook',
                style: TextStyle(
                  color: AppColor().appColor,
                ),
              ),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height / 25,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: size.width / 10,
                  ),
                  child: Text(
                    userName.isEmpty & !snapshot.hasData
                        ? "Hoşgeldin"
                        : "Hoşgeldin ${userName}",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  height: size.height / 50,
                ),
                Padding(
                  padding: EdgeInsets.only(left: size.width / 6),
                  child: Text(
                    "Gezdiğin her an ITravelBook Seninle",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.italic),
                  ),
                ),
                SizedBox(
                  height: size.height / 40,
                ),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  height: size.height / 3,
                  width: size.width,
                  child: ListView(
                      physics: PageScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: [
                        InkWell(
                          onTap: () async {
                            var _permission =
                                await Geolocator.checkPermission();
                            if (_permission == LocationPermission.denied ||
                                _permission ==
                                    LocationPermission.deniedForever) {
                              await Geolocator.requestPermission();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) => AddLocation()));
                            } else if (_permission ==
                                    LocationPermission.always ||
                                _permission == LocationPermission.whileInUse) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) => AddLocation()));
                            }
                          },
                          child: Column(
                            children: [
                              Container(
                                height: size.height / 3.5,
                                width: size.width / 1.4,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      width: 2, color: AppColor().appColor),
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/addlocation.png"),
                                      fit: BoxFit.cover),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(
                                  "Konum Ekle",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            var _permission =
                                await Geolocator.checkPermission();
                            if (_permission == LocationPermission.denied ||
                                _permission ==
                                    LocationPermission.deniedForever) {
                              await Geolocator.requestPermission();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) => Locations()));
                            } else if (_permission ==
                                    LocationPermission.always ||
                                _permission == LocationPermission.whileInUse) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) => Locations()));
                            }
                          },
                          child: Column(
                            children: [
                              Container(
                                height: size.height / 3.5,
                                width: size.width / 1.4,
                                margin: EdgeInsets.only(left: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      width: 2, color: AppColor().appColor),
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/locations.png"),
                                      fit: BoxFit.cover),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(
                                  "Kayıtlı Konumlarım",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ]),
                ),
                Expanded(
                  child: Image(
                    width: size.width,
                    image: AssetImage(
                      "assets/images/home_background.png",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: AdWidget(ad: AddmobService.createBannerAdd()..load()),
                ),
              ],
            ),
          );
        });
  }
}
