part of home_view.dart;

class _BuildWelcomeUserNameText extends StatelessWidget {
  AsyncSnapshot<QuerySnapshot<Object?>> snapshot;
  _BuildWelcomeUserNameText(
      {Key? key, required this.snapshot, required this.language})
      : super(key: key);
  String language;

  @override
  Widget build(BuildContext context) {
    String text = language == "TR" ? "Hoşgeldin" : "Welcome";
    return Padding(
      padding: EdgeInsets.only(
        top: context.height / 25,
        left: context.width / 10,
        right: context.width / 10,
      ),
      child: AutoSizeText(
        context.read<HomeCubit>().FirebaseuserName.isEmpty & !snapshot.hasData
            ? text + " !"
            : text + " ! ${context.read<HomeCubit>().FirebaseuserName}",
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
      ),
    );
  }
}
