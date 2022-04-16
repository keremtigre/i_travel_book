part of login_view.dart;

class _BuildCheckBox extends StatelessWidget {
  const _BuildCheckBox({
    Key? key,
  }) : super(key: key);

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
        Text("Beni Hatırla"),
      ],
    );
  }
}
