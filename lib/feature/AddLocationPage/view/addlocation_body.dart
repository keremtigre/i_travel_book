part of addlocation_view.dart;

class AddLocationPageBody extends StatelessWidget {
  const AddLocationPageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPopScope(
        context,
        "Emin Misin ?",
        "Bütün değişiklikler kayboalcak emin misin ?",
      ),
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
                SizedBox(
                  height: context.height / 40,
                ),
                //Mapin aşağısında kalan kısım için alan
                SizedBox(
                  width: context.width,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _BuildAddPhotoWidget(),
                          SizedBox(
                            width: 10,
                          ),
                          _BuildInfoText(),
                        ],
                      ),
                      _BuildForm(),
                      SizedBox(height: context.height / 20),
                    ],
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

  Future<bool> _onWillPopScope(
      BuildContext context, String title, String detail) async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(title),
            content: Text(detail),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  'Hayır',
                  style: TextStyle(color: AppColor().appColor),
                ),
              ),
              TextButton(
                  onPressed: () {
                    context
                        .read<AddlocationCubit>()
                        .addLocationDispose(context);
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (builder) => HomePage()),
                        (route) => false);
                  },
                  child: Text(
                    'Evet',
                    style: TextStyle(color: AppColor().appColor),
                  )),
            ],
          ),
        )) ??
        false;
  }
}
