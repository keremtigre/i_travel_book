part of home_view.dart;

class _BuildWelcomeUserNameText extends StatelessWidget {
  AsyncSnapshot<QuerySnapshot<Object?>> snapshot;
  _BuildWelcomeUserNameText({Key? key, required this.snapshot})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: context.height / 25,
        left: context.width / 10,
      ),
      child: Text(
        context.read<HomeCubit>().FirebaseuserName.isEmpty & !snapshot.hasData
            ? "Hoşgeldin"
            : "Hoşgeldin ${context.read<HomeCubit>().FirebaseuserName}",
        style: TextStyle(fontSize: 26, fontWeight: FontWeight.w400),
      ),
    );
  }
}
