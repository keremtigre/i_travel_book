part of home_view.dart;

class HomePageBody extends StatelessWidget {
  HomePageBody({Key? key}) : super(key: key);
  FirebaseAuth _auth = FirebaseAuth.instance;
  String language = "";
  initialLanguage() async {
    language = await getString("language");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: getBool("darkmode"),
        builder: (context, darkmodeSnapshot) {
          initialLanguage();
          if (darkmodeSnapshot.hasData) {
            return BlocConsumer<HomeCubit, HomeState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is HomeInitial) {
                    context.read<HomeCubit>().homeInitState();
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is HomeLoaded) {
                    return StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("ProfileData")
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            snapshot.data!.docs.forEach((element) {
                              if (element.id ==
                                  _auth.currentUser!.email.toString()) {
                                context.read<HomeCubit>().FirebaseuserName =
                                    element["userName"];
                                context.read<HomeCubit>().FirebaseimageUrl =
                                    element["userPhoto"];
                              }
                            });
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _BuildWelcomeUserNameText(
                                  snapshot: snapshot, language: language),
                              _BuildAppSlogan(language: language),
                              _BuildListView(
                                  isdarkmode: darkmodeSnapshot.data!,
                                  language: language),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: context.width / 30),
                                child: AutoSizeText(
                                  language == "TR"
                                      ? "Konumunuzda Gezilebilecek Yerler"
                                      : "Places to Visit in Your Location",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(left: 10, top: 10),
                                  height: context.height / 4,
                                  width: context.width,
                                  child: ListView(
                                      physics: BouncingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                        InkWell(
                                          onTap: () {},
                                          child: Stack(
                                            children: [
                                              Banner(
                                                location:
                                                    BannerLocation.topStart,
                                                message: language == "TR"
                                                    ? "Çok Yakında"
                                                    : "coming soon",
                                                child: HomePageContainer(
                                                    isdarkmode:
                                                        darkmodeSnapshot.data!,
                                                    assetname:
                                                        "assets/images/collesium.jpeg",
                                                    height:
                                                        context.height / 4.5,
                                                    width: context.width / 2,
                                                    containerTitle: ""),
                                              ),
                                            ],
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {},
                                          child: Banner(
                                            location: BannerLocation.topStart,
                                            message: language == "TR"
                                                ? "Çok Yakında"
                                                : "coming soon",
                                            child: HomePageContainer(
                                                isdarkmode:
                                                    darkmodeSnapshot.data!,
                                                assetname:
                                                    "assets/images/galata_tower.jpeg",
                                                height: context.height / 4.5,
                                                margin:
                                                    EdgeInsets.only(left: 10),
                                                width: context.width / 2,
                                                containerTitle: ""),
                                          ),
                                        )
                                      ]),
                                ),
                              ),
                              _BuildBannerAdMob(),
                            ],
                          );
                        });
                  } else
                    return Container(
                      child: Center(child: AutoSizeText("sorun oluştu")),
                    );
                });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
