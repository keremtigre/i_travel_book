part of locations_view.dart;

class _BuildGoogleMap extends StatelessWidget {
  const _BuildGoogleMap({Key? key, required this.darkmode}) : super(key: key);
  final bool darkmode;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: GoogleMap(
            padding: EdgeInsets.only(
                bottom: context.height / 3, top: context.height / 6),
            markers: context.read<LocationsCubit>().markers.values.toSet(),
            myLocationEnabled: true,
            zoomControlsEnabled: true,
            myLocationButtonEnabled: true,
            mapType: MapType.normal,
            tiltGesturesEnabled: true,
            compassEnabled: true,
            scrollGesturesEnabled: true,
            zoomGesturesEnabled: true,
            initialCameraPosition:
                context.read<LocationsCubit>().cameraPosition,
            onMapCreated: (GoogleMapController googleMapController) {
              context
                  .read<LocationsCubit>()
                  .initialGoogleMapController(googleMapController);
              if (darkmode) {
                rootBundle
                    .loadString('assets/json/map-dark.json')
                    .then((string) {
                  googleMapController.setMapStyle(string);
                });
              }
            }));
  }
}
