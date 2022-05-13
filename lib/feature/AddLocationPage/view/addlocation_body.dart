part of addlocation_view.dart;

class AddLocationPageBody extends StatelessWidget {
  final isdarkmode;
  AddLocationPageBody(
      {Key? key, required this.isdarkmode, required this.language})
      : super(key: key);
  final language;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<AddlocationCubit>().addLocationDispose(context);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (builder) => HomePage()),
            (route) => false);
        return true;
      },
      child: BlocConsumer<AddlocationCubit, AddlocationState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is AddlocationInitial) {
            context.read<AddlocationCubit>().AddLocationInit(context);
            return Center(child: CircularProgressIndicator());
          }
          if (state is AddLocationLoaded) {
            return ListView(
              children: [
                _BuildGoogleMap(
                  isdarkmode: isdarkmode,
                ),
                //Mapin aşağısında kalan kısım için alan
                Container(
                  padding: EdgeInsets.only(top: context.height / 60),
                  width: context.width,
                  child: Form(
                    key: context.read<AddlocationCubit>().formKey,
                    child: Column(
                      children: [
                        _BuildInfoText(
                            language: language, isdarkmode: isdarkmode),
                        _BuildAddPhotoWidget(
                          language: language,
                          isdarkmode: isdarkmode,
                        ),
                        AddLocationText(
                            isdarkmode: isdarkmode,
                            title: language == "TR"
                                ? "Konum Başlığı"
                                : "Location Title",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return language == "TR"
                                    ? AddLocationStrings.emptytexterror
                                    : "this field cannot be left blank";
                              } else {
                                return null;
                              }
                            },
                            hinntext: language == "TR"
                                ? AddLocationStrings.placestitletext
                                : "Add a Title to Your Location (Ex. *Home,Cafe...)",
                            controller: context
                                .read<AddlocationCubit>()
                                .placeTitleTextController,
                            maxLength: 30),
                        AddLocationText(
                          isdarkmode: isdarkmode,
                          title: language == "TR"
                              ? "Konum Detayı"
                              : "Location Text",
                          controller: context
                              .read<AddlocationCubit>()
                              .placeDetailTextController,
                          hinntext: language == "TR"
                              ? AddLocationStrings.locationTextFieldDetailText
                              : "You can add details about your location",
                          maxLength: 120,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return language == "TR"
                                  ? AddLocationStrings.emptytexterror
                                  : "this field cannot be left blank";
                            } else {
                              return null;
                            }
                          },
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          } else
            return Center(
              child: AutoSizeText(language == "TR" ? "SORUN OLUŞTU" : "Error"),
            );
        },
      ),
    );
  }
}
