part of addlocation_view.dart;

class _BuildInfoText extends StatelessWidget {
  final bool isdarkmode;
  _BuildInfoText({
    Key? key,
    required this.language,
    required this.isdarkmode,
  }) : super(key: key);
  final language;
  @override
  Widget build(BuildContext context) {
    Color settingDrawerColor = isdarkmode ? AppColor().appColor : Colors.white;
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(3),
        margin: EdgeInsets.only(
            left: context.width / 20, right: context.width / 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
              width: 1,
              color: !isdarkmode ? AppColor().appColor : Colors.white),
          color: Colors.white.withOpacity(0.6),
        ),
        height: context.height / 20,
        width: context.width,
        child: AutoSizeText(
          language == "TR"
              ? "Kaydetmek istediğiniz konumun üzerine basılı tutun"
              : "Hold on the location you want to save",
          style: TextStyle(color: Colors.black),
        ));
  }
}
