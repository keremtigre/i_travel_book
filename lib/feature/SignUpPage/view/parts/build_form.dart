part of signup_view.dart;

class _BuildForm extends StatelessWidget {
  Size size;
  double paddingleft;
  double paddingright;
  double paddingtop;
  double paddingbottom;
  final language;
  _BuildForm(
      {Key? key,
      required this.size,
      required this.language,
      this.paddingleft = 0.0,
      this.paddingright = 0.0,
      this.paddingtop = 0.0,
      this.paddingbottom = 0.0})
      : super(key: key);
  bool _isValidEmail(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<SignupCubit>().formKey,
      child: Column(
        children: [
          // username textfield
          Padding(
            padding: EdgeInsets.only(
              left: paddingleft,
              right: paddingright,
              top: paddingtop,
            ),
            child: AuthTextField(
                isLoginCubit: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return language == "TR" ? 'Kullanıcı Adınızı Giriniz' : "Please enter your username";
                  } else {
                    null;
                  }
                },
                hinntext: language == "TR" ? SignUpPageStrings.usernameTextField :"Enter your username",
                controller: context.read<SignupCubit>().userNameController),
          ),
          //email textfield
          Padding(
            padding: EdgeInsets.only(
              left: paddingleft,
              right: paddingright,
              top: paddingtop,
            ),
            child: AuthTextField(
                isLoginCubit: false,
                validator: (email) {
                  if (email!.isEmpty || email == null) {
                    return language == "TR" ? SignUpPageStrings.emailTextErrorMesage1: "Please enter your e-mail address";
                  }
                  if (!_isValidEmail(email)) {
                    return  language == "TR" ? SignUpPageStrings.inavalidEmail: "Invalid e-mail";
                  } else {
                    return null;
                  }
                },
                hinntext:language == "TR" ? SignUpPageStrings.emailFieldText :"Enter your mail",
                controller: context.read<SignupCubit>().emailController),
          ),
          //password text
          Padding(
            padding: EdgeInsets.only(
              left: paddingleft,
              right: paddingright,
              top: paddingtop,
            ),
            child: AuthTextField(
                isLoginCubit: false,
                isPasswordText: true,
                validator: (password) {
                  if (password!.isEmpty || password == null) {
                    return language == "TR" ? SignUpPageStrings.passwordTextErrorMesage1 : "Please enter your password";
                  }

                  if (password.length < 6) {
                    return language == "TR" ? SignUpPageStrings.passwordTextErrorMesage2 :"";
                  } else {
                    return null;
                  }
                },
                hinntext: language == "TR" ? SignUpPageStrings.passwordTextField :" Your password cannot be less than 6 characters",
                controller: context.read<SignupCubit>().passwordController),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: paddingleft,
              right: paddingright,
              top: paddingtop,
            ),
            child: AuthTextField(
                isVerifyPassword: true,
                isLoginCubit: false,
                isPasswordText: true,
                validator: (password) {
                  if (password!.isEmpty || password == null) {
                    return language == "TR" ? SignUpPageStrings.passwordTextErrorMesage1:"Please enter your password";
                  }
                  if (password.length < 6) {
                    return language == "TR" ? SignUpPageStrings.passwordTextErrorMesage2:" Your password cannot be less than 6 characters";
                  }
                  if (password !=
                      context.read<SignupCubit>().passwordController.text) {
                    return language == "TR" ? SignUpPageStrings.passwordTextErrorMesage3:"Passwords do not match";
                  } else {
                    return null;
                  }
                },
                hinntext: language == "TR" ? SignUpPageStrings.passwordTextField2:"Enter your password again",
                controller: context.read<SignupCubit>().passwordController2),
          ),
        ],
      ),
    );
  }
}
