part of addlocation_view.dart;

class _BuildGoogleMap extends StatelessWidget {
  const _BuildGoogleMap({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: context.height / 3.5,
      child: Stack(
        children: [
          GoogleMap(
            onLongPress: (argument) async {
              if (await InternetConnectionChecker().hasConnection &&
                  await Geolocator.isLocationServiceEnabled()) {
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
                ShowDialogForAddLocationPage(context,
                    "Internet ve Konum özelliğinizin açık olduğundan emin olun");
              } else if (await InternetConnectionChecker().hasConnection ==
                  false) {
                ShowDialogForAddLocationPage(
                    context, "Internet Bağlantınızı Kontrol Ediniz");
              } else if (await Geolocator.isLocationServiceEnabled() == false) {
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
              var _permision = await Geolocator.checkPermission();
              debugPrint("izin: " + _permision.toString());
              if (await Geolocator.isLocationServiceEnabled() &&
                      _permision == LocationPermission.whileInUse ||
                  _permision == LocationPermission.always) {
                var position = await Geolocator.getCurrentPosition(
                    desiredAccuracy: LocationAccuracy.high);
                controller.animateCamera(
                    CameraUpdate.newCameraPosition(CameraPosition(
                        target: LatLng(
                          position.latitude,
                          position.longitude,
                        ),
                        zoom: 17)));
              } else {
                checkLocation(context);
              }
            },
            initialCameraPosition:
                context.read<AddlocationCubit>().cameraPosition,
          ),
          Positioned(
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: AppColor().appColor,
                size: context.width / 10,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<String> GetAddressFromLatLong(double lat, double long) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
    Placemark place = placemarks[0];
    return '${place.thoroughfare}-${place.subThoroughfare}';
  }
}
