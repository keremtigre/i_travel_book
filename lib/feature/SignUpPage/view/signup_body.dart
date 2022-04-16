part of signup_view.dart;

class SignupBody extends StatelessWidget {
  const SignupBody({Key? key}) : super(key: key);

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
                  child: Text(
                    "Kayıt Ol",
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: size.width / 20),
                  child: _BuildUserPhoto(),
                ),
                _BuildForm(
                    size: size,
                    paddingleft: size.width / 20,
                    paddingright: size.width / 20,
                    paddingtop: size.width / 20),
                Padding(
                  padding: EdgeInsets.only(top: size.width / 20),
                  child: _BuildSignupButton(size: size),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
