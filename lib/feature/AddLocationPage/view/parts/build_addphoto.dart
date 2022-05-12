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
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 2, color: AppColor().appColor)),
      margin: EdgeInsets.only(
          top: context.height / 70,
          right: context.width / 30,
          left: context.width / 30),
      child: ExpansionTile(
          childrenPadding: EdgeInsets.only(
              left: context.width / 20, bottom: context.height / 50),
          expandedAlignment: Alignment.centerLeft,
          title: AutoSizeText(language == "TR"
              ? "Fotoğraf Ekleyebilirsiniz"
              : "You Can Add Photo"),
          children: [
            InkWell(
                onTap: (() {
                  FocusScope.of(context).requestFocus(FocusNode());
                  context.read<AddlocationCubit>().pickImage(context);
                  debugPrint(context.read<AddlocationCubit>().image.toString());
                }),
                child: context.read<AddlocationCubit>().image == null
                    ? Container(
                        width: context.width / 3,
                        height: context.height / 6,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: !isdarkmode
                                  ? AppColor().appColor
                                  : Colors.white,
                              width: 5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: AddPhotoAnimation())
                    : Container(
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
                        ))),
          ]),
    );
  }
}
