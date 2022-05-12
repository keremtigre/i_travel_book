part of signup_view.dart;

class _BuildSignupButton extends StatelessWidget {
  const _BuildSignupButton({
    Key? key,
    required this.language,
    required this.size,
  }) : super(key: key);

  final Size size;
  final language;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width / 4,
      height: size.height / 15,
      decoration: BoxDecoration(
        color: AppColor().appColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: !context.read<SignupCubit>().isLoading
          ? TextButton(
              onPressed: () async {
                if (context
                    .read<SignupCubit>()
                    .formKey
                    .currentState!
                    .validate()) {
                  await context.read<SignupCubit>().SignupWithEmail(context);
                }
              },
              child: AutoSizeText(
               language == "TR" ? "Kayıt Ol" : "Sign Up",
                style: TextStyle(color: Colors.white),
              ),
            )
          : Center(
              child: CircularProgressIndicator(backgroundColor: Colors.white),
            ),
    );
  }
}
