part of home_view.dart;

class _BuildScaffoldLeading extends StatelessWidget {
  const _BuildScaffoldLeading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      //End Drawer Widgetına context parametresini göndermek için Builder ile Sarmalandı
      //Yoksa Hata verir
      builder: (context) {
        return IconButton(
          color: Colors.white,
          icon: CircleAvatar(
            backgroundColor: AppColor().appColor,
            radius: 40,
            child: context.read<HomeCubit>().FirebaseimageUrl.isEmpty
                ? Image.asset(
                    "assets/images/profile.png",
                    fit: BoxFit.cover,
                  )
                : CircleAvatar(
                    minRadius: 40,
                    maxRadius: 40,
                    backgroundImage: NetworkImage(
                      context.read<HomeCubit>().FirebaseimageUrl,
                    )),
          ),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        );
      },
    );
  }
}
