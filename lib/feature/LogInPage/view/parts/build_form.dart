part of login_view.dart;

class _BuildForm extends StatelessWidget {
  bool _isValidEmail(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  const _BuildForm({
    Key? key,
    required this.language,
    required this.size,
  }) : super(key: key);
  final language;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<LoginCubit>().formKey,
      child: Column(
        children: [
          //email text
          Padding(
            padding: EdgeInsets.only(
                top: size.width / 40,
                left: size.width / 40,
                right: size.width / 40),
            child: AuthTextField(
              isLoginCubit: true,
              controller: context.read<LoginCubit>().emailController,
              hinntext:language == "TR" ?  LoginPageStrings.emailFieldText : "Enter your mail address",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return language == "TR" ?  "Lütfen e-mail adresinizi giriniz": "Please enter your mail address";
                }
                if (!_isValidEmail(value)) {
                  return language == "TR" ? "Geçersiz e-mail": "invalid e-mail";
                } else {
                  return null;
                }
              },
            ),
          ),
          //password text
          Padding(
            padding: EdgeInsets.only(
                top: size.width / 40,
                left: size.width / 40,
                right: size.width / 40),
            child: AuthTextField(
              isLoginCubit: true,
              isPasswordText: true,
              controller: context.read<LoginCubit>().passwordController,
              hinntext: language == "TR" ?  LoginPageStrings.passwordTextField : "Enter your password",
              validator: (password) {
                if (password!.isEmpty || password == null) {
                  return language == "TR" ?  LoginPageStrings.passwordTextErrorMesage1: "Please enter your password";
                }
                if (password.length < 6) {
                  return language == "TR" ?  LoginPageStrings.passwordTextErrorMesage2 : " Your password cannot be less than 6 characters";;
                } else {
                  return null;
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
