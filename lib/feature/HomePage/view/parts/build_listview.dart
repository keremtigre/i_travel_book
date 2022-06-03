part of home_view.dart;

class _BuildListView extends StatelessWidget {
  final bool isdarkmode;
  const _BuildListView(
      {Key? key, required this.isdarkmode, required this.language})
      : super(key: key);
  final language;
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
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: [
            InkWell(
              onTap: () => ShowPermission(context, false),
              child: HomePageContainer(
                  isdarkmode: isdarkmode,
                  assetname: "assets/images/addlocation.png",
                  height: context.height / 4.5,
                  width: context.width / 2,
                  containerTitle:
                      language == "TR" ? "Konum Ekle" : "Add Location"),
            ),
            InkWell(
              onTap: () => ShowPermission(context, true),
              child: HomePageContainer(
                  isdarkmode: isdarkmode,
                  assetname: "assets/images/locations.png",
                  height: context.height / 4.5,
                  margin: EdgeInsets.only(left: 10),
                  width: context.width / 2,
                  containerTitle: language == "TR"
                      ? "Kayıtlı Konumlarım"
                      : "Saved Locations"),
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
                    language: language,
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
                    language: language,
                    isdarkmode: isdarkmode,
                  )),
        (route) => false,
      );
    }
  }
}
