import 'package:flutter/material.dart';
import 'package:pertemuan1/screens/detail_screen.dart';
import 'package:pertemuan1/screens/favorite_screen.dart';
import 'package:pertemuan1/screens/home_screen.dart';
import 'package:pertemuan1/screens/profile_screen.dart';
import 'package:pertemuan1/screens/signin_screen.dart';
import 'package:pertemuan1/screens/signup_screen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anime Verse',
      theme: ThemeData(
        fontFamily: 'Urbanist',
      ),
      home: const SignInScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

