part of home_view.dart;
class _BuildHomePageImage extends StatelessWidget {
  const _BuildHomePageImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Image(
        width: context.width,
        image: AssetImage(
          "assets/images/home_background.png",
        ),
        fit: BoxFit.cover,
      ),
    );
  }
}
