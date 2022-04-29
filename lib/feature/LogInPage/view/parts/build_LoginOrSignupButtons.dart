part of login_view.dart;

class _BuildLoginOrSignUp extends StatelessWidget {
  const _BuildLoginOrSignUp({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

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
                    "Giriş Yap",
                    style: TextStyle(color: Colors.white),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
        ),
        AutoSizeText("ya da"),
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
            child: AutoSizeText(
              "Üye Ol",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
