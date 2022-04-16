part of addlocation_view.dart;
class _BuildInfoText extends StatelessWidget {
  const _BuildInfoText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(width: 2, color: AppColor().appColor),
          color: Colors.white.withOpacity(0.6),
        ),
        height: context.height / 10,
        width: context.width / 2,
        child: Text(
          "Seçmek istediğiniz konumun üzerine birkaç saniye basılı tutunuz",
          style: TextStyle(color: Colors.black),
        ));
  }
}
