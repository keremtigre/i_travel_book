part of addlocation_view.dart;

class SaveLocationButton extends StatelessWidget {
  final language;
  const SaveLocationButton({Key? key, required this.language})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: EdgeInsets.only(
            right: context.width / 50, bottom: context.height / 50),
        child: FloatingActionButton.extended(
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
            if (context
                    .read<AddlocationCubit>()
                    .formKeys[0]
                    .currentState!
                    .validate() &&
                context
                    .read<AddlocationCubit>()
                    .formKeys[1]
                    .currentState!
                    .validate() &&
                await InternetConnectionChecker().hasConnection == false) {
              ShowDialogForAddLocationPage(
                  context, "Internet Bağlantınızı Kontrol Edin");
            }
            if (context
                    .read<AddlocationCubit>()
                    .formKeys[0]
                    .currentState!
                    .validate() &&
                context
                    .read<AddlocationCubit>()
                    .formKeys[1]
                    .currentState!
                    .validate() &&
                context.read<AddlocationCubit>().markers.isEmpty) {
              ShowDialogForAddLocationPage(
                  context, "lütfen Haritadan Konum Seçiniz");
            }
            if (context
                    .read<AddlocationCubit>()
                    .formKeys[0]
                    .currentState!
                    .validate() &&
                context
                    .read<AddlocationCubit>()
                    .formKeys[1]
                    .currentState!
                    .validate() &&
                !context.read<AddlocationCubit>().markers.isEmpty &&
                await InternetConnectionChecker().hasConnection) {
              context.read<AddlocationCubit>().setSaveProgress(true);
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
                  context.read<LocationsCubit>().newLocationAdded=true;
                  if (context.read<AddlocationCubit>().isInterstitialAdReady) {
                    context.read<AddlocationCubit>().interstitialAd?.show();
                  }
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: AppColor().appColor,
                      content: AutoSizeText("Konum Eklendi")));
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (builder) {
                    context
                        .read<AddlocationCubit>()
                        .addLocationDispose(context);
                    return HomePage();
                  }), (route) => false);
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
        ),
      ),
    );
  }
}
