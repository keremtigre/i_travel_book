part of home_view.dart;

class _BuildAppSlogan extends StatelessWidget {
  const _BuildAppSlogan({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(top: context.height / 50, left: context.width / 6),
      child: AutoSizeText(
        "Gezdiğin her an ITravelBook Seninle",
        style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.italic),
      ),
    );
  }
}
