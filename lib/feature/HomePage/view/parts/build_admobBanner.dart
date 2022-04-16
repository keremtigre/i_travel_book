part of home_view.dart;
class _BuildBannerAdMob extends StatelessWidget {
  const _BuildBannerAdMob({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      height: context.height / 10,
      child: AdWidget(ad: AddmobService.createBannerAdd()..load()),
    );
  }
}