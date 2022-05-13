part of login_view.dart;

class _BuildLoginOrSignUp extends StatelessWidget {
  const _BuildLoginOrSignUp({
    Key? key,
    required this.language,
    required this.size,
  }) : super(key: key);

  final Size size;
  final language;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: size.width / 4,
          decoration: BoxDecoration(
            color: AppColor().appColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextButton(
            onPressed: () async {
              if (context.read<LoginCubit>().formKey.currentState!.validate()) {
                await context.read<LoginCubit>().LoginWithEmailMethod(context);
              }
            },
            child: !context.read<LoginCubit>().isLodingEmail
                ? AutoSizeText(
                    language == "TR" ? "Giriş Yap" : "Log In",
                    style: TextStyle(color: Colors.white),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
        ),
        AutoSizeText(language == "TR" ? "ya da" : "or"),
        Container(
          width: size.width / 4,
          decoration: BoxDecoration(
            color: AppColor().appColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignUpPage()));
            },
            child: Text(
              language == "TR" ? "Üye Ol" : "Sign Up",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
