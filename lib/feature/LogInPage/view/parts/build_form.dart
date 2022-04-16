part of login_view.dart;

class _BuildForm extends StatelessWidget {
  bool _isValidEmail(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  const _BuildForm({
    Key? key,
    required this.size,
  }) : super(key: key);

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
              hinntext: LoginPageStrings.emailFieldText,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Lütfen e-mail adresinizi giriniz";
                }
                if (!_isValidEmail(value)) {
                  return "Geçersiz e-mail";
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
              hinntext: LoginPageStrings.passwordTextField,
              validator: (password) {
                if (password!.isEmpty || password == null) {
                  return LoginPageStrings.passwordTextErrorMesage1;
                }
                if (password.length < 6) {
                  return LoginPageStrings.passwordTextErrorMesage2;
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
