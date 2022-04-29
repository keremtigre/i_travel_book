part of signup_view.dart;

class _BuildUserPhoto extends StatelessWidget {
  const _BuildUserPhoto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () async {
            context.read<SignupCubit>().pickImage(context);
          },
          child: context.watch<SignupCubit>().image.path != ''
              ? CircleAvatar(
                  backgroundImage:
                      FileImage(context.watch<SignupCubit>().image),
                  radius: 60,
                )
              : CircleAvatar(
                  radius: 60,
                  backgroundColor: AppColor().appColor,
                  child: Image.asset("assets/images/profile.png")),
        ),
        SizedBox(
          height: 10,
        ),
        AutoSizeText(
          "Profil fotoğrafı Eklemek için fotoğrafa tıklayın",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
