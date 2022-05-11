part of addlocation_view.dart;

class _BuildGoogleMap extends StatelessWidget {
  final bool isdarkmode;
  _BuildGoogleMap({Key? key, required this.isdarkmode}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Color settingDrawerColor = isdarkmode ? AppColor().appColor : Colors.white;
    return Container(
      width: double.infinity,
      height: context.height / 2.9,
      child: Stack(
        children: [
          GoogleMap(
            onLongPress: (argument) async {
              context.read<AddlocationCubit>().setismarkerloading(true);
              if (await InternetConnectionChecker().hasConnection &&
                  await Geolocator.isLocationServiceEnabled()) {
                context.read<AddlocationCubit>().setismarkerloading(true);
                //eklenen markerları silmek için yaptım
                context.read<AddlocationCubit>().clearMarker();
                //MarkerId için addres geldi
                String address = await GetAddressFromLatLong(
                    argument.latitude, argument.longitude);
                //Konumu Kaydet Butonu için gereken atamalar yapıldı
                context.read<AddlocationCubit>().updateLocation(argument);
                //marker oluşturuluyor
                final marker =
                    Marker(markerId: MarkerId(address), position: argument);
                context.read<AddlocationCubit>().updateMarker(address, marker);
                await Future.delayed(Duration(milliseconds: 100));
                if (!context.read<AddlocationCubit>().markers.isEmpty) {
                  context.read<AddlocationCubit>().setismarkerloading(false);
                }

                debugPrint("lat: " +
                    context.read<AddlocationCubit>().originLatitude.toString() +
                    " long: " +
                    context
                        .read<AddlocationCubit>()
                        .originLongitude
                        .toString());
              } else if (await InternetConnectionChecker().hasConnection ==
                      false &&
                  await Geolocator.isLocationServiceEnabled() == false) {
                context.read<AddlocationCubit>().setismarkerloading(false);
                ShowDialogForAddLocationPage(context,
                    "Internet ve Konum özelliğinizin açık olduğundan emin olun");
              } else if (await InternetConnectionChecker().hasConnection ==
                  false) {
                context.read<AddlocationCubit>().setismarkerloading(false);
                ShowDialogForAddLocationPage(
                    context, "Internet Bağlantınızı Kontrol Ediniz");
              } else if (await Geolocator.isLocationServiceEnabled() == false) {
                context.read<AddlocationCubit>().setismarkerloading(false);
                ShowDialogForAddLocationPage(
                    context, "Konumunuzun açık olduğundan emin olun");
              }
            },
            markers: context.read<AddlocationCubit>().markers.values.toSet(),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            zoomControlsEnabled: true,
            mapType: MapType.normal,
            tiltGesturesEnabled: true,
            compassEnabled: true,
            scrollGesturesEnabled: true,
            zoomGesturesEnabled: true,
            onMapCreated: (GoogleMapController controller) async {
              if (isdarkmode) {
                rootBundle
                    .loadString('assets/json/map-dark.json')
                    .then((string) {
                  controller.setMapStyle(string);
                });
              }
              var _permision = await Geolocator.checkPermission();
              debugPrint("izin: " + _permision.toString());
              if (await Geolocator.isLocationServiceEnabled() &&
                      _permision == LocationPermission.whileInUse ||
                  _permision == LocationPermission.always) {
                var position = await Geolocator.getCurrentPosition();
                 controller.animateCamera(
                    CameraUpdate.newCameraPosition(CameraPosition(
                        target: LatLng(
                          position.latitude,
                          position.longitude,
                        ),
                        zoom: 17)));
                controller.dispose();
              } else {
                checkLocation(context);
              }
            },
            initialCameraPosition:
                context.read<AddlocationCubit>().cameraPosition,
            gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
              new Factory<OneSequenceGestureRecognizer>(
                () => new EagerGestureRecognizer(),
              ),
            ].toSet(),
          ),
          Positioned(
            child: IconButton(
              onPressed: () {
                context.read<AddlocationCubit>().addLocationDispose(context);
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: isdarkmode
                    ? AppColor().appColor
                    : AppColor().darkModeBackgroundColor,
                size: context.width / 10,
              ),
            ),
          ),
          context.read<AddlocationCubit>().isMarkerLoading
              ? Center(child: CircularProgressIndicator())
              : Container()
        ],
      ),
    );
  }
}

Future<String> GetAddressFromLatLong(double lat, double long) async {
  List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
  Placemark place = placemarks[0];
  return '${place.thoroughfare}-${place.subThoroughfare}';
}
