part of home_view.dart;

class _BuildScaffoldAppBar extends StatelessWidget implements PreferredSize {
   _BuildScaffoldAppBar({
    Key? key,
  }) : super(key: key);
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: getBool("darkmode"),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return AppBar(
              backgroundColor: snapshot.data == false
                  ? Colors.white
                  : AppColor().darkModeBackgroundColor,
              actions: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.light_mode,
                        color: snapshot.data == false
                            ? AppColor().appColor
                            : Colors.white,
                      ),
                      Switch(
                          value: snapshot.data!,
                          onChanged: (value) {
                            if (value == true) {
                              context
                                  .read<HomeCubit>()
                                  .isDarkModeSelected(false);
                            } else {
                              context
                                  .read<HomeCubit>()
                                  .isDarkModeSelected(true);
                            }
                            debugPrint("gell:" + snapshot.data.toString());
                          }),
                      Icon(Icons.dark_mode,
                          color: snapshot.data == false
                              ? AppColor().appColor
                              : Colors.white),
                    ],
                  ),
                )
              ],
              centerTitle: true,
              leading: _BuildScaffoldLeading(),
              elevation: 0,
              title: Text(
                'ITravelBook',
                style: TextStyle(
                    color: snapshot.data == true
                        ? Colors.white
                        : AppColor().appColor),
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        });

    /*  */
  }

  @override
  // TODO: implement child
  Widget get child => throw UnimplementedError();
}
