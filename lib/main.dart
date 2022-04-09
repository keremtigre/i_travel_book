import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:i_travel_book/Pages/LogInPage/cubit/cubit/login_cubit.dart';
import 'package:i_travel_book/Pages/SignUpPage/cubit/cubit/signup_cubit.dart';
import 'package:i_travel_book/Pages/StartingPage/startingpage.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SignupCubit(),
        ),
        BlocProvider(
          create: (context) => LoginCubit(),
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
    return MaterialApp(
      theme: ThemeData(
          textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme)),
      debugShowCheckedModeBanner: false,
      home: StartingPage(),
    );
  }
}
