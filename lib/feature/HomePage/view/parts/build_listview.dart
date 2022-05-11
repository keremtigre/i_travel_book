part of home_view.dart;

class _BuildListView extends StatelessWidget {
  final bool isdarkmode;
  const _BuildListView({Key? key, required this.isdarkmode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10),
      margin: EdgeInsets.only(
        top: context.height / 40,
      ),
      height: context.height / 3,
      width: context.width,
      child: ListView(
          physics: PageScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: [
            InkWell(
              onTap: () => ShowPermission(context, false),
              child: HomePageContainer(
                  isdarkmode: isdarkmode,
                  assetname: "assets/images/addlocation.png",
                  height: context.height / 3.5,
                  width: context.width / 1.4,
                  containerTitle: "Konum Ekle"),
            ),
            InkWell(
              onTap: () => ShowPermission(context, true),
              child: HomePageContainer(
                  isdarkmode: isdarkmode,
                  assetname: "assets/images/locations.png",
                  height: context.height / 3.5,
                  margin: EdgeInsets.only(left: 10),
                  width: context.width / 1.4,
                  containerTitle: "Kayıtlı Konumlarım"),
            )
          ]),
    );
  }

  ShowPermission(BuildContext context, bool isLocatinPage) async {
    var _permission = await Geolocator.checkPermission();
    if (_permission == LocationPermission.denied ||
        _permission == LocationPermission.deniedForever) {
      await Geolocator.requestPermission();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (builder) => !isLocatinPage
                ? AddLocationPage(
                    isdarkmode: isdarkmode,
                  )
                : LocationsPage(
                    isdarkmode: isdarkmode,
                  )),
        (route) => false,
      );
    } else if (_permission == LocationPermission.always ||
        _permission == LocationPermission.whileInUse) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (builder) => !isLocatinPage
                ? AddLocationPage(
                    isdarkmode: isdarkmode,
                  )
                : LocationsPage(
                    isdarkmode: isdarkmode,
                  )),
        (route) => false,
      );
    }
  }
}
