part of signup_view.dart;

class SignupBody extends StatelessWidget {
  SignupBody({Key? key,required this.language}) : super(key: key);
  final language;
  

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Stack(
        children: [
          Row(
            children: [
              Expanded(
                  child: Transform.rotate(
                      angle: 6,
                      child: Image.asset(
                        "assets/images/signup.png",
                      ))),
              SizedBox(
                width: size.width / 7,
              ),
              Expanded(
                  child: Transform.rotate(
                      angle: 6,
                      child: Image.asset(
                        "assets/images/signup2.png",
                      ))),
            ],
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: size.width / 10),
                  child: AutoSizeText(
                    language == "TR" ? "Kayıt Ol" : "Sign Up",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: size.width / 20),
                  child: _BuildUserPhoto(
                    language: language,
                  ),
                ),
                _BuildForm(
                    language: language,
                    size: size,
                    paddingleft: size.width / 20,
                    paddingright: size.width / 20,
                    paddingtop: size.width / 20),
                Padding(
                  padding: EdgeInsets.only(top: size.width / 20),
                  child: _BuildSignupButton(language: language, size: size),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
