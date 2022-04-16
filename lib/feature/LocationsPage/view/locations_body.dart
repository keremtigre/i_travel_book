part of locations_view.dart;

class LocationsPageBody extends StatelessWidget {
  LocationsPageBody({Key? key}) : super(key: key);

  late bool darkmode = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection(FirebaseAuth.instance.currentUser!.email.toString())
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                context.read<LocationsCubit>().pageViewTotalCount =
                    snapshot.data!.size;
                //eğer ilk eleman ise onu çağırır (sadece sayfanın ilk kez Açılışında gerekiyor)
                if (context.read<LocationsCubit>().isFirstItem &&
                    snapshot.data!.size != 0) {
                  double _lng = double.parse(snapshot.data!.docs[0].get("lng"));
                  double _lat = double.parse(snapshot.data!.docs[0].get("lat"));
                  context.read<LocationsCubit>().getMarker(0, _lat, _lng);
                } else if (snapshot.data!.size == 0) {
                  context.read<LocationsCubit>().IsFirstItemChanged();

                  debugPrint("value2: " +
                      context.read<LocationsCubit>().isFirstItem.toString());
                }
              }
              return Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.white,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: <Widget>[
                    SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                      child: GoogleMap(
                        padding: EdgeInsets.only(bottom: context.height / 2),
                        markers: context
                            .read<LocationsCubit>()
                            .markers
                            .values
                            .toSet(),
                        myLocationEnabled: true,
                        zoomControlsEnabled: true,
                        myLocationButtonEnabled: true,
                        mapType: MapType.normal,
                        tiltGesturesEnabled: true,
                        compassEnabled: true,
                        scrollGesturesEnabled: true,
                        zoomGesturesEnabled: true,
                        onMapCreated: (GoogleMapController controller) async {
                          var _permision = await Geolocator.checkPermission();
                          debugPrint("izin: " + _permision.toString());
                          if (await Geolocator.isLocationServiceEnabled()) {
                            context
                                .read<LocationsCubit>()
                                .controller
                                .complete(controller);
                          } else {
                            Geolocator.openLocationSettings();
                          }
                        },
                        initialCameraPosition:
                            context.read<LocationsCubit>().cameraPosition,
                      ),
                    ),
                    Align(
                        alignment: FractionalOffset.bottomCenter,
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
                                            .markerClear();
                                        final _lng = double.parse(snapshot
                                            .data!.docs[value]
                                            .get("lng"));
                                        final _lat = double.parse(snapshot
                                            .data!.docs[value]
                                            .get("lat"));
                                        context
                                            .read<LocationsCubit>()
                                            .getMarker(value, _lat, _lng);
                                        if (value != 0) {
                                          context
                                              .read<LocationsCubit>()
                                              .setIsFirstItem(false);
                                        }
                                        if (value == 0) {
                                          context
                                              .read<LocationsCubit>()
                                              .setIsFirstItem(true);
                                        }
                                        context
                                            .read<LocationsCubit>()
                                            .incrementPageViewCounter(value);
                                      },
                                      itemBuilder: (context, index) {
                                        if (snapshot.data!.size != 0 &&
                                            index == 0) {
                                          context
                                              .read<LocationsCubit>()
                                              .setIsFirstItem(true);
                                        } else if (snapshot.data!.size != 0 &&
                                            index != 0) {
                                          context
                                              .read<LocationsCubit>()
                                              .setIsFirstItem(false);
                                        }
                                        String _url = snapshot.data!.docs[index]
                                            .get("downloadUrl");

                                        return Container(
                                          margin: EdgeInsets.all(20),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 5,
                                                child: !_url.isEmpty
                                                    ? ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        child: Image.network(
                                                          _url,
                                                          height:
                                                              context.height,
                                                          width: context.width,
                                                          fit: BoxFit.cover,
                                                          filterQuality:
                                                              FilterQuality
                                                                  .high,
                                                        ),
                                                      )
                                                    : ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        child: Container(
                                                          color: darkmode ==
                                                                  true
                                                              ? AppColor()
                                                                  .darkModeBackgroundColor
                                                              : Colors.white,
                                                          alignment:
                                                              Alignment.center,
                                                          width:
                                                              double.infinity,
                                                          height:
                                                              double.infinity,
                                                          child: Image.asset(
                                                            "assets/images/signup.png",
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    IconButton(
                                                        onPressed: () {
                                                          final String _baslik =
                                                              snapshot.data!
                                                                  .docs[index]
                                                                  .get("title")
                                                                  .toString();
                                                          final String
                                                              _aciklama =
                                                              snapshot.data!
                                                                  .docs[index]
                                                                  .get("action")
                                                                  .toString();

                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (context) =>
                                                                      DetailPage(
                                                                        image_url:
                                                                            _url,
                                                                        aciklama:
                                                                            _aciklama,
                                                                        baslik:
                                                                            _baslik,
                                                                      ));
                                                        },
                                                        icon: Icon(
                                                          Icons.info_outline,
                                                          color: AppColor()
                                                              .appColor,
                                                          size: 30,
                                                        )),
                                                    Text(context
                                                            .read<
                                                                LocationsCubit>()
                                                            .pageViewCounter
                                                            .toString() +
                                                        "/" +
                                                        context
                                                            .read<
                                                                LocationsCubit>()
                                                            .pageViewTotalCount
                                                            .toString()),
                                                    IconButton(
                                                        onPressed: () async {
                                                          var collection =
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(FirebaseAuth
                                                                      .instance
                                                                      .currentUser!
                                                                      .email
                                                                      .toString());
                                                          await collection
                                                              .where('id',
                                                                  isEqualTo: snapshot
                                                                      .data!
                                                                      .docs[
                                                                          index]
                                                                      .get(
                                                                          "id"))
                                                              .get()
                                                              .then((value) {
                                                            if (value != null) {
                                                              value.docs.first
                                                                  .reference
                                                                  .delete();
                                                              ScaffoldMessenger
                                                                      .of(
                                                                          context)
                                                                  .showSnackBar(
                                                                      SnackBar(
                                                                          content:
                                                                              Text("Seçilen Konum Başarıyla Silindi")));
                                                            }
                                                          });
                                                          await CloudHelper()
                                                              .deleteImage(
                                                                  _url);
                                                          context
                                                              .read<
                                                                  LocationsCubit>()
                                                              .pageViewController
                                                              .jumpToPage(0);
                                                        },
                                                        icon: Icon(
                                                          Icons.delete,
                                                          color: Colors.red,
                                                          size: 30,
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          decoration: BoxDecoration(
                                            color: darkmode == false
                                                ? Colors.grey.shade100
                                                : AppColor()
                                                    .darkModeBackgroundColor,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                          ),
                                        );
                                      })
                                  : AlertDialog(
                                      title: Text("Konum Ekleyin"),
                                      content: Text(
                                          "Eklediğiniz konumlar burada listelenecektir."),
                                    )
                              : Center(
                                  child: CircularProgressIndicator(),
                                ),
                        )),
                  ],
                ),
              );
            }),
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: AppColor().appColor,
              size: context.width / 10,
            )),
      ],
    );
  }

  //izinleri kontrol eden fonksion
  Future<void> checkLocation(BuildContext context) async {
    LocationPermission _permission;
    _permission = await Geolocator.checkPermission();
    if (!await Geolocator.isLocationServiceEnabled()) {
      await Geolocator.openLocationSettings();
    }
    if (_permission == LocationPermission.denied) {
      showDialog(
          context: context,
          builder: (builder) => AlertDialog(
                title: Text("Uyarı"),
                content: Text(
                    "Konum izni olmadan bu özelliği kullanamazsınız. Uygulama ayarlarından konuma izin verin"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (builder) => HomePage()),
                            (route) => false);
                      },
                      child: Text("Geri Dön")),
                  TextButton(
                      onPressed: () async {
                        await Geolocator.openAppSettings();
                      },
                      child: Text("Ayarlara Git"))
                ],
              ));
    }
    if (_permission == LocationPermission.deniedForever) {
      showDialog(
          context: context,
          builder: (builder) => AlertDialog(
                title: Text("Uyarı"),
                content: Text(
                    "Konum izni olmadan bu özelliği kullanamazsınız. Uygulama ayarlarından konuma izin verin"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (builder) => HomePage()),
                            (route) => false);
                      },
                      child: Text("Geri Dön")),
                  TextButton(
                      onPressed: () async {
                        await Geolocator.openAppSettings();
                      },
                      child: Text("Ayarlara Git"))
                ],
              ));
    }
  }
}
