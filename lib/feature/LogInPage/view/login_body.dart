part of login_view.dart;

class LoginPageBody extends StatelessWidget {
  LoginPageBody({Key? key, required this.language}) : super(key: key);
  final language;
  @override
  Widget build(BuildContext context) {
    debugPrint(
        "benihatirla: " + context.read<LoginCubit>().beniHatirla.toString());
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is LoginInitial) {
          context.read<LoginCubit>().loginInitial();
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is LoginLoaded) {
          return Container(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: size.height / 50),
                    child: Image.asset(
                      "assets/images/login2.png",
                      height: size.height / 5.5,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: size.height / 25),
                    child: Column(
                      children: [
                        AutoSizeText(
                          language == "TR" ? "Giriş Yap" : "Log In",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        _BuildForm(language: language, size: size),
                        Padding(
                          padding: EdgeInsets.only(
                              top: size.height / 70, right: size.width * 0.05),
                          child: _BuildCheckBox(
                            language: language,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: size.height / 40),
                          child: _BuildLoginOrSignUp(
                              language: language, size: size),
                        ),
                        _BuildGoogleSignInButton(
                            language: language, size: size),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
