// ignore_for_file: prefer_const_constructors

import 'package:dashboard_task/constants/colors.dart';
import 'package:dashboard_task/firebase_options.dart';
import 'package:dashboard_task/screens/add_category.dart';
import 'package:dashboard_task/screens/home_screen.dart';
import 'package:dashboard_task/screens/loading_screen.dart';
import 'package:dashboard_task/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: primaryColor),
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
          stream: FirebaseAuth.instance.userChanges(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return LoginScreen();
            } else if (snapshot.data != null) {
              return HomeScreen();
            } else {
              return LoadingScreen();
            }
          }),
    );
  }
}
