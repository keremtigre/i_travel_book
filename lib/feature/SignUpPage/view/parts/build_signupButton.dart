part of signup_view.dart;

class _BuildSignupButton extends StatelessWidget {
  const _BuildSignupButton({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width / 4,
      decoration: BoxDecoration(
        color: AppColor().appColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        onPressed: () async {
          if (context.read<SignupCubit>().formKey.currentState!.validate()) {
            await context.read<SignupCubit>().SignupWithEmail(context);
          }
        },
        child: Text(
          "Kayıt Ol",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
