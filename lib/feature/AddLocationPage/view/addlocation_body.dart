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
            return Stack(
              children: [
                ListView(
                  children: [
                    _BuildGoogleMap(
                      isdarkmode: isdarkmode,
                    ),
                    //Mapin aşağısında kalan kısım için alan
                    Container(
                      padding: EdgeInsets.only(top: context.height / 60),
                      width: context.width,
                      child: Column(
                        children: [
                          _BuildInfoText(
                              language: language, isdarkmode: isdarkmode),
                          Theme(
                            data: ThemeData(
                              colorScheme: Theme.of(context)
                                  .colorScheme
                                  .copyWith(primary: AppColor().appColor),
                            ),
                            child: Stepper(
                              controlsBuilder: (context, details) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    context
                                                .read<AddlocationCubit>()
                                                .currentStep ==
                                            0
                                        ? SizedBox()
                                        : ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                primary: AppColor().appColor),
                                            onPressed: details.onStepCancel,
                                            child: Text(
                                              language == "TR"
                                                  ? "Önceki Adım"
                                                  : "Previous Step",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                    context
                                                .read<AddlocationCubit>()
                                                .currentStep ==
                                            2
                                        ? SizedBox()
                                        : ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                primary: AppColor().appColor),
                                            onPressed: details.onStepContinue,
                                            child: Text(
                                                language == "TR"
                                                    ? "Sonraki Adım"
                                                    : "Next Step",
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          )
                                  ],
                                );
                              },
                              elevation: 20,
                              type: StepperType.vertical,
                              physics: ScrollPhysics(),
                              currentStep:
                                  context.read<AddlocationCubit>().currentStep,
                              onStepTapped: (step) =>
                                  context.read<AddlocationCubit>().tapped(step),
                              onStepContinue:
                                  context.read<AddlocationCubit>().continued,
                              onStepCancel:
                                  context.read<AddlocationCubit>().cancel,
                              steps: <Step>[
                                Step(
                                  title: Text('Konum Başlığı'),
                                  content: Column(
                                    children: <Widget>[
                                      Form(
                                        key: context
                                            .read<AddlocationCubit>()
                                            .formKeys[0],
                                        child: AddLocationText(
                                            isdarkmode: isdarkmode,
                                            title: language == "TR"
                                                ? "Konum Başlığı"
                                                : "Location Title",
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return language == "TR"
                                                    ? AddLocationStrings
                                                        .emptytexterror
                                                    : "this field cannot be left blank";
                                              } else {
                                                return null;
                                              }
                                            },
                                            hinntext: language == "TR"
                                                ? AddLocationStrings
                                                    .placestitletext
                                                : "Add a Title to Your Location (Ex. *Home,Cafe...)",
                                            controller: context
                                                .read<AddlocationCubit>()
                                                .placeTitleTextController,
                                            maxLength: 30),
                                      ),
                                    ],
                                  ),
                                  isActive: context
                                          .read<AddlocationCubit>()
                                          .currentStep >=
                                      0,
                                  state: context
                                              .read<AddlocationCubit>()
                                              .currentStep >
                                          0
                                      ? StepState.complete
                                      : StepState.disabled,
                                ),
                                Step(
                                  title: Text('Konum Detayı'),
                                  content: Column(
                                    children: <Widget>[
                                      Form(
                                        key: context
                                            .read<AddlocationCubit>()
                                            .formKeys[1],
                                        child: AddLocationText(
                                          isdarkmode: isdarkmode,
                                          title: language == "TR"
                                              ? "Konum Detayı"
                                              : "Location Text",
                                          controller: context
                                              .read<AddlocationCubit>()
                                              .placeDetailTextController,
                                          hinntext: language == "TR"
                                              ? AddLocationStrings
                                                  .locationTextFieldDetailText
                                              : "You can add details about your location",
                                          maxLength: 120,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return language == "TR"
                                                  ? AddLocationStrings
                                                      .emptytexterror
                                                  : "this field cannot be left blank";
                                            } else {
                                              return null;
                                            }
                                          },
                                          maxLines: 2,
                                        ),
                                      ),
                                    ],
                                  ),
                                  isActive: context
                                          .read<AddlocationCubit>()
                                          .currentStep >=
                                      0,
                                  state: context
                                              .read<AddlocationCubit>()
                                              .currentStep >
                                          1
                                      ? StepState.complete
                                      : StepState.disabled,
                                ),
                                Step(
                                  title: Text(
                                      'Konum Hakkında Görsel(İsteğe Bağlı)'),
                                  content: Column(
                                    children: <Widget>[
                                      _BuildAddPhotoWidget(
                                        language: language,
                                        isdarkmode: isdarkmode,
                                      ),
                                    ],
                                  ),
                                  isActive: context
                                          .read<AddlocationCubit>()
                                          .currentStep >=
                                      0,
                                  state: context
                                              .read<AddlocationCubit>()
                                              .currentStep >=
                                          2
                                      ? StepState.complete
                                      : StepState.disabled,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SaveLocationButton(language: language),
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
