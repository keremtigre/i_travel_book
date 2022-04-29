part of addlocation_view.dart;

class _BuildInfoText extends StatelessWidget {
  final bool isdarkmode;
  _BuildInfoText({
    Key? key,
    required this.isdarkmode,
  }) : super(key: key);

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
              width: 2,
              color: !isdarkmode ? AppColor().appColor : Colors.white),
          color: Colors.white.withOpacity(0.6),
        ),
        height: context.height / 20,
        width: context.width,
        child: AutoSizeText(
          "Kaydetmek istediğiniz konumun üzerine basılı tutun",
          style: TextStyle(color: Colors.black),
        ));
  }
}
