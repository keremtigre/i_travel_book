part of locations_view.dart;

class LocationsPageBody extends StatelessWidget {
  LocationsPageBody({Key? key, required this.isdarkmode}) : super(key: key);
  bool isdarkmode;
  bool isfirstitem = true;
  String language = "";
  initialLanguage() async {
    language = await getString("language");
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection(FirebaseAuth.instance.currentUser!.email.toString())
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          initialLanguage();
          return BlocConsumer<LocationsCubit, LocationsState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              if (state is LocationsInitial) {
                context.read<LocationsCubit>().LocationPageInit(snapshot);
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is LocationsLoaded) {
                if (context.read<LocationsCubit>().newLocationAdded) {
                  context.read<LocationsCubit>().getLocations(snapshot);
                  context.read<LocationsCubit>().setNewLocationAdded(false);
                }
                return Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      _BuildGoogleMap(
                        darkmode: isdarkmode,
                      ),
                      _searchText(
                          isdarkmode: isdarkmode,
                          snapshot: snapshot,
                          language: language),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                              height: context.height * .35,
                              width: double.infinity,
                              child: snapshot.hasData
                                  ? snapshot.data!.size != 0
                                      ? context
                                                  .read<LocationsCubit>()
                                                  .locationModel
                                                  .length !=
                                              0
                                          ? PageView.builder(
                                              controller: context
                                                  .read<LocationsCubit>()
                                                  .pageViewController,
                                              itemCount: context
                                                  .read<LocationsCubit>()
                                                  .locationModel
                                                  .length,
                                              padEnds: true,
                                              onPageChanged: (value) {
                                                context
                                                    .read<LocationsCubit>()
                                                    .PageViewOnChanged(
                                                        context
                                                            .read<
                                                                LocationsCubit>()
                                                            .locationModel,
                                                        value);
                                              },
                                              itemBuilder: (context, index) {
                                                final String _baslik = context
                                                    .read<LocationsCubit>()
                                                    .locationModel[index]
                                                    .title;
                                                final String _aciklama = context
                                                    .read<LocationsCubit>()
                                                    .locationModel[index]
                                                    .action;
                                                if (isfirstitem) {
                                                  context
                                                      .read<LocationsCubit>()
                                                      .PageViewOnChanged(
                                                        context
                                                            .read<
                                                                LocationsCubit>()
                                                            .locationModel,
                                                        index,
                                                      );
                                                  isfirstitem = false;
                                                }
                                                String _url = context
                                                    .read<LocationsCubit>()
                                                    .locationModel[index]
                                                    .downloadUrl;
                                                return LocationsContainer(
                                                    isdarkmode: isdarkmode,
                                                    snapshot2: snapshot,
                                                    language: language,
                                                    index: index,
                                                    detail: _aciklama,
                                                    pageViewCount: context
                                                        .read<LocationsCubit>()
                                                        .pageViewCounter,
                                                    pageViewTotalCount: context
                                                        .read<LocationsCubit>()
                                                        .pageViewTotalCount,
                                                    title: _baslik,
                                                    url: _url);
                                              })
                                          : AlertDialog(
                                              alignment: Alignment.bottomCenter,
                                              actionsAlignment:
                                                  MainAxisAlignment.center,
                                              title: Text(language == "TR"
                                                  ? "Arama Sonucu"
                                                  : "Search Result"),
                                              content: Text(language == "TR"
                                                  ? "Konum Bulunamadı"
                                                  : "Location Not Found"),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      context
                                                          .read<
                                                              LocationsCubit>()
                                                          .getLocations(
                                                              snapshot);
                                                    },
                                                    child: Text(language == "TR"
                                                        ? "Konumları Tekrar Getir"
                                                        : "Refresh Locations"))
                                              ],
                                            )
                                      : AlertDialog(
                                          title: Text("Add Location"),
                                          content: Text(language == "TR"
                                              ? "Eklediğiniz konumlar burada listelenecektir."
                                              : "The locations you add will be listed here."),
                                        )
                                  : Center(
                                      child: CircularProgressIndicator(),
                                    ))),
                    ],
                  ),
                );
              } else
                return AutoSizeText("hata var");
            },
          );
        });
  }
}
