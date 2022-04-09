import 'package:flutter/material.dart';
import 'package:i_travel_book/Pages/SignUpPage/cubit/cubit/signup_cubit.dart';
import 'package:i_travel_book/core/color/appcolor..dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserPhoto extends StatelessWidget {
  const UserPhoto({Key? key}) : super(key: key);

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
        Text(
          "Profil fotoğrafı Eklemek için fotoğrafa tıklayın",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
