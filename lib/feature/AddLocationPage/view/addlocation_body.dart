part of addlocation_view.dart;

class AddLocationPageBody extends StatelessWidget {
  final isdarkmode;
  const AddLocationPageBody({Key? key, required this.isdarkmode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<AddlocationCubit>().addLocationDispose(context);
        Navigator.pop(context);
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
                        _BuildInfoText(isdarkmode: isdarkmode),
                        _BuildAddPhotoWidget(
                          isdarkmode: isdarkmode,
                        ),
                        AddLocationText(
                            isdarkmode: isdarkmode,
                            title: "Konum Başlığı",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AddLocationStrings.emptytexterror;
                              } else {
                                return null;
                              }
                            },
                            hinntext: AddLocationStrings.placestitletext,
                            controller: context
                                .read<AddlocationCubit>()
                                .placeTitleTextController,
                            maxLength: 30),
                        AddLocationText(
                          isdarkmode: isdarkmode,
                          title: "Konum Detayı",
                          controller: context
                              .read<AddlocationCubit>()
                              .placeDetailTextController,
                          hinntext:
                              AddLocationStrings.locationTextFieldDetailText,
                          maxLength: 120,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AddLocationStrings.emptytexterror;
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
              child: AutoSizeText("SORUN OLUŞTU"),
            );
        },
      ),
    );
  }
}
