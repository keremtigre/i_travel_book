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
