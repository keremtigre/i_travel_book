part of home_view.dart;

class _BuildAppSlogan extends StatelessWidget {
  const _BuildAppSlogan({
    Key? key,required this.language
  }) : super(key: key);
  final language;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(top: context.height / 50, left: context.width / 6),
      child: AutoSizeText(
       language=="TR" ? "Gezdiğin her an ITravelBook seninle": "ITravelBook with you every time you travel",
        style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.italic),
      ),
    );
  }
}
