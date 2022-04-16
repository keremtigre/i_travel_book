part of addlocation_view.dart;

class AddLocationPageBody extends StatelessWidget {
  const AddLocationPageBody({Key? key}) : super(key: key);
  Future<bool> _onWillPopScope(BuildContext context) async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Emin misiniz ?'),
            content: const Text(
                'Tüm değişiklikler kaybolacak emin misiniz ?'),
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
                    context.read<AddlocationCubit>().addLocationDispose(context);
                    Navigator.of(context).pop(true);
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPopScope(context),
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
}
