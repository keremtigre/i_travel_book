part of addlocation_view.dart;
class _BuildForm extends StatelessWidget {
  const _BuildForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<AddlocationCubit>().formKey,
      child: Column(
        children: [
          Padding(
            padding:
                EdgeInsets.only(top: context.height / 40, left: 10, right: 10),
            child: AddLocationText(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AddLocationStrings.emptytexterror;
                  } else {
                    return null;
                  }
                },
                hinntext: AddLocationStrings.placestitletext,
                controller:
                    context.read<AddlocationCubit>().placeTitleTextController,
                maxLength: 30),
          ),
          Padding(
              padding: EdgeInsets.only(
                  top: context.height / 80, left: 10, right: 10),
              child: AddLocationText(
                controller:
                    context.read<AddlocationCubit>().placeDetailTextController,
                hinntext: AddLocationStrings.locationTextFieldDetailText,
                maxLength: 120,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AddLocationStrings.emptytexterror;
                  } else {
                    return null;
                  }
                },
                maxLines: 2,
              )),
        ],
      ),
    );
  }
}
