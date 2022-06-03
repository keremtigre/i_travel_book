part of addlocation_view.dart;

class _BuildAddPhotoWidget extends StatelessWidget {
  final bool isdarkmode;
  _BuildAddPhotoWidget({
    Key? key,
    required this.language,
    required this.isdarkmode,
  }) : super(key: key);
  final language;
  @override
  Widget build(BuildContext context) {
    Color settingDrawerColor = isdarkmode ? AppColor().appColor : Colors.white;
    return InkWell(
        onTap: (() {
          FocusScope.of(context).requestFocus(FocusNode());
          context.read<AddlocationCubit>().pickImage(context);
          debugPrint(context.read<AddlocationCubit>().image.toString());
        }),
        child: context.read<AddlocationCubit>().image == null
            ? Align(
                alignment: Alignment.centerLeft,
                child: Container(
                    width: context.width / 3,
                    height: context.height / 6,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color:
                              !isdarkmode ? AppColor().appColor : Colors.white,
                          width: 5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: AddPhotoAnimation()),
              )
            : Align(
                alignment: Alignment.centerLeft,
                child: Container(
                    width: context.width / 3,
                    height: context.height / 6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.file(
                        context.read<AddlocationCubit>().image!,
                        fit: BoxFit.cover,
                      ),
                    )),
              ));
  }
}
