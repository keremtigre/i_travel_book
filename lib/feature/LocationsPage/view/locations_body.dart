part of locations_view.dart;

class LocationsPageBody extends StatelessWidget {
  LocationsPageBody({Key? key}) : super(key: key);

  bool isfirstitem = true;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocationsCubit, LocationsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is LocationsInitial) {
          context.read<LocationsCubit>().LocationPageInit();
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is LocationsLoaded) {
          return StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection(
                      FirebaseAuth.instance.currentUser!.email.toString())
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  context.read<LocationsCubit>().pageViewTotalCount =
                      snapshot.data!.size;
                }

                return Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      _BuildGoogleMap(),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                              height: context.height * .35,
                              width: double.infinity,
                              child: snapshot.hasData
                                  ? snapshot.data!.size != 0
                                      ? PageView.builder(
                                          controller: context
                                              .read<LocationsCubit>()
                                              .pageViewController,
                                          itemCount: context
                                              .read<LocationsCubit>()
                                              .pageViewTotalCount,
                                          padEnds: true,
                                          onPageChanged: (value) {
                                            context
                                                .read<LocationsCubit>()
                                                .PageViewOnChanged(
                                                    snapshot, value);
                                          },
                                          itemBuilder: (context, index) {
                                            final String _baslik = snapshot
                                                .data!.docs[index]
                                                .get("title")
                                                .toString();
                                            final String _aciklama = snapshot
                                                .data!.docs[index]
                                                .get("action")
                                                .toString();
                                            if (isfirstitem) {
                                              context
                                                  .read<LocationsCubit>()
                                                  .PageViewOnChanged(
                                                    snapshot,
                                                    index,
                                                  );
                                              isfirstitem = false;
                                            }
                                            String _url = snapshot
                                                .data!.docs[index]
                                                .get("downloadUrl");
                                            return LocationsContainer(
                                                snapshot2: snapshot,
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
                                          title: Text("Konum Ekleyin"),
                                          content: Text(
                                              "Eklediğiniz konumlar burada listelenecektir."),
                                        )
                                  : Center(
                                      child: CircularProgressIndicator(),
                                    ))),
                    ],
                  ),
                );
              });
        } else
          return Text("hata var");
      },
    );
  }
}
