part of home_view.dart;

class _BuildScaffoldAppBar extends StatelessWidget implements PreferredSize {
  const _BuildScaffoldAppBar({
    Key? key,
  }) : super(key: key);
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: context.read<HomeCubit>().isdarkmode == true
          ? AppColor().appColor
          : Colors.white,
      centerTitle: true,
      leading: _BuildScaffoldLeading(),
      elevation: 0,
      title: Text(
        'ITravelBook',
        style: TextStyle(
            color: context.read<HomeCubit>().isdarkmode == true
                ? Colors.white
                : AppColor().appColor),
      ),
    );
  }

  @override
  // TODO: implement child
  Widget get child => throw UnimplementedError();
}
