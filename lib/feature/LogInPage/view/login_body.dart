part of login_view.dart;

class LoginPageBody extends StatelessWidget {
  const LoginPageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: size.height / 30),
              child: Image.asset(
                "assets/images/login2.png",
                height: size.height / 5,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: size.height / 25),
              child: Column(
                children: [
                  Text(
                    "Giriş Yap",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  _BuildForm(size: size),
                  Padding(
                    padding: EdgeInsets.only(
                        top: size.height / 70, right: size.width * 0.05),
                    child: _BuildCheckBox(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: size.height / 40),
                    child: _BuildLoginOrSignUp(size: size),
                  ),
                  _BuildGoogleSignInButton(size: size),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
