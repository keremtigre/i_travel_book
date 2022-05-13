part of addlocation_view.dart;

class SaveLocationButton extends StatelessWidget {
  final language;
  const SaveLocationButton({Key? key, required this.language})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      elevation: 10,
      backgroundColor: AppColor().appColor,
      label: !context.read<AddlocationCubit>().saveProgress
          ? AutoSizeText(
              language == "TR" ? "Kaydet" : "Save",
              style: TextStyle(color: Colors.white),
            )
          : Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
      onPressed: () async {
        if (context.read<AddlocationCubit>().formKey.currentState!.validate() &&
            await InternetConnectionChecker().hasConnection == false) {
          ShowDialogForAddLocationPage(
              context, "Internet Bağlantınızı Kontrol Edin");
        }
        if (context.read<AddlocationCubit>().formKey.currentState!.validate() &&
            context.read<AddlocationCubit>().markers.isEmpty) {
          ShowDialogForAddLocationPage(
              context, "lütfen Haritadan Konum Seçiniz");
        }
        if (context.read<AddlocationCubit>().formKey.currentState!.validate() &&
            !context.read<AddlocationCubit>().markers.isEmpty &&
            await InternetConnectionChecker().hasConnection) {
          showDialog(
              context: context,
              builder: (builder) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              });
          CloudHelper()
              .addLocation(
            context.read<AddlocationCubit>().placeTitleTextController.text,
            context.read<AddlocationCubit>().placeDetailTextController.text,
            context.read<AddlocationCubit>().originLatitude.toString(),
            context.read<AddlocationCubit>().originLongitude.toString(),
            context.read<AddlocationCubit>().image != null
                ? context.read<AddlocationCubit>().image!
                : File(''),
          )
              .then((value) {
            if (value == null) {
              context.read<LocationsCubit>().setNewLocationAdded(true);
              if (context.read<AddlocationCubit>().isInterstitialAdReady) {
                context.read<AddlocationCubit>().interstitialAd?.show();
              }
              context.read<AddlocationCubit>().addLocationDispose(context);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (builder) => HomePage()),
                  (route) => false);

              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  duration: Duration(milliseconds: 25),
                  backgroundColor: AppColor().appColor,
                  content: AutoSizeText("Konum Eklendi")));
            } else if (value != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: AutoSizeText(value.toString())));
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (builder) => HomePage()),
                  (route) => false);
            }
          });
        }
      },
    );
  }
}
