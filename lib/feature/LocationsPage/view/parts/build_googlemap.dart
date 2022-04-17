part of locations_view.dart;

class _BuildGoogleMap extends StatelessWidget {
  const _BuildGoogleMap({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: GoogleMap(
            padding: EdgeInsets.only(bottom: context.height / 2),
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
            onMapCreated: (GoogleMapController googleMapController) async {
              await Future.delayed(Duration(milliseconds: 100));
              context.read<LocationsCubit>().googleMapController = googleMapController;
            }));
  }
}
