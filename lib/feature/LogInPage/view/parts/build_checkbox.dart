part of login_view.dart;

class _BuildCheckBox extends StatelessWidget {
  const _BuildCheckBox({Key? key, required this.language}) : super(key: key);
  final language;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Checkbox(
          activeColor: AppColor().appColor,
          value: context.watch<LoginCubit>().beniHatirla,
          onChanged: (bool? value) {
            context.read<LoginCubit>().changeBeniHatirla(value);
          },
        ),
        AutoSizeText(language == "TR" ? "Beni Hatırla":"Remember Me"),
      ],
    );
  }
}
