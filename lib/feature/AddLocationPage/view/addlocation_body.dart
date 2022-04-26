part of addlocation_view.dart;

class AddLocationPageBody extends StatelessWidget {
  const AddLocationPageBody({Key? key}) : super(key: key);

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
                _BuildGoogleMap(),
                //Mapin aşağısında kalan kısım için alan
                Container(
                  padding: EdgeInsets.only(top: context.height / 30),
                  width: context.width,
                  child: Form(
                    key: context.read<AddlocationCubit>().formKey,
                    child: Column(
                      children: [
                        _BuildAddPhotoWidget(),
                        AddLocationText(
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
              child: Text("SORUN OLUŞTU"),
            );
        },
      ),
    );
  }
}
