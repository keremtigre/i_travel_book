part of addlocation_view.dart;

class SaveLocationButton extends StatelessWidget {
  const SaveLocationButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      elevation: 10,
      backgroundColor: AppColor().appColor,
      label: Text(
        "Kaydet",
        style: TextStyle(color: Colors.white),
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
          ShowLoaderDialog(context, "Konum kaydediliyor...");
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
              if (context.read<AddlocationCubit>().isInterstitialAdReady) {
                context.read<AddlocationCubit>().interstitialAd?.show();
              }
              context.read<AddlocationCubit>().AddLocationInit(context);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (builder) => HomePage()),
                  (route) => false);

              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  duration: Duration(milliseconds: 25),
                  backgroundColor: AppColor().appColor,
                  content: Text("Konum Eklendi")));
            } else if (value != null) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(value.toString())));
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
