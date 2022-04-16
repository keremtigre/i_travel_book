part of signup_view.dart;

class _BuildForm extends StatelessWidget {
  Size size;
  double paddingleft;
  double paddingright;
  double paddingtop;
  double paddingbottom;
  _BuildForm(
      {Key? key,
      required this.size,
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
                    return 'Kullanıcı Adınızı Giriniz';
                  } else {
                    null;
                  }
                },
                hinntext: SignUpPageStrings.usernameTextField,
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
                    return SignUpPageStrings.emailTextErrorMesage1;
                  }
                  if (!_isValidEmail(email)) {
                    return SignUpPageStrings.inavalidEmail;
                  } else {
                    return null;
                  }
                },
                hinntext: SignUpPageStrings.emailFieldText,
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
                    return SignUpPageStrings.passwordTextErrorMesage1;
                  }

                  if (password.length < 6) {
                    return SignUpPageStrings.passwordTextErrorMesage2;
                  } else {
                    return null;
                  }
                },
                hinntext: SignUpPageStrings.passwordTextField,
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
                    return SignUpPageStrings.passwordTextErrorMesage1;
                  }
                  if (password.length < 6) {
                    return SignUpPageStrings.passwordTextErrorMesage2;
                  }
                  if (password !=
                      context.read<SignupCubit>().passwordController.text) {
                    return SignUpPageStrings.passwordTextErrorMesage3;
                  } else {
                    return null;
                  }
                },
                hinntext: SignUpPageStrings.passwordTextField2,
                controller: context.read<SignupCubit>().passwordController2),
          ),
        ],
      ),
    );
  }
}
