part of login_view.dart;


class _BuildGoogleSignInButton extends StatelessWidget {
  const _BuildGoogleSignInButton({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height / 15,
      width: size.width / 2,
      margin: EdgeInsets.all(size.height / 20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColor().appColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        onPressed: () async {
          await context.read<LoginCubit>().signInwithGoogle();
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (builder) => HomePage()),
              (route) => false);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              "assets/images/google.png",
              height: size.height / 25,
              fit: BoxFit.cover,
            ),
            Text(
              "Google ile Giriş Yap",
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}