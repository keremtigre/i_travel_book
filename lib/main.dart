import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:i_travel_book/feature/AddLocationPage/add_location.dart';
import 'package:i_travel_book/feature/AddLocationPage/viewmodel/cubit/addlocation_cubit.dart';
import 'package:i_travel_book/feature/HomePage/view/home_view.dart';
import 'package:i_travel_book/feature/HomePage/viewmodel/cubit/home_cubit.dart';
import 'package:i_travel_book/feature/LogInPage/view/login_view.dart';
import 'package:i_travel_book/feature/LogInPage/viewmodel/cubit/cubit/login_cubit.dart';
import 'package:i_travel_book/feature/SignUpPage/viewmodel/cubit/cubit/signup_cubit.dart';
import 'package:i_travel_book/feature/StartingPage/startingpage.dart';
import 'package:i_travel_book/core/color/appcolor..dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit(),
        ),
        BlocProvider(
          create: (context) => SignupCubit(),
        ),
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => AddlocationCubit(),
        )
      ],
      child: MyApp(),
    ), // Wrap your app
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return FutureBuilder<ThemeData>(
            future: context.read<HomeCubit>().getThemeMode(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return MaterialApp(
                  theme: snapshot.data,
                  debugShowCheckedModeBanner: false,
                  home: StartingPage(),
                );
              } else {
                return CircularProgressIndicator();
              }
            });
      },
    );
  }
}
