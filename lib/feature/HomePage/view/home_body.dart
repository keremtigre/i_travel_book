part of home_view.dart;

class HomePageBody extends StatelessWidget {
  HomePageBody({Key? key}) : super(key: key);
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: getBool("darkmode"),
        builder: (context, darkmodeSnapshot) {
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
                                snapshot: snapshot,
                              ),
                              _BuildAppSlogan(),
                              _BuildListView(isdarkmode:darkmodeSnapshot.data!,),
                              _BuildHomePageImage(),
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
