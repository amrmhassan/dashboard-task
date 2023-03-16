// ignore_for_file: prefer_const_constructors

import 'package:dashboard_task/constants/colors.dart';
import 'package:dashboard_task/constants/sizes.dart';
import 'package:dashboard_task/constants/styles.dart';
import 'package:dashboard_task/global/widgets/button_wrapper.dart';
import 'package:dashboard_task/global/widgets/custom_text_field.dart';
import 'package:dashboard_task/global/widgets/h_line.dart';
import 'package:dashboard_task/global/widgets/h_space.dart';
import 'package:dashboard_task/global/widgets/padding_wrapper.dart';
import 'package:dashboard_task/global/widgets/v_space.dart';
import 'package:dashboard_task/screens/add_category.dart';
import 'package:dashboard_task/screens/categories.dart';
import 'package:dashboard_task/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var user = auth.FirebaseAuth.instance.currentUser;
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: largeIconSize * 2,
            color: primaryColor,
            child: Row(
              children: [
                HSpace(),
                Expanded(
                    child: Row(
                  children: [
                    Text(
                      'Hello ',
                      style: h2TextStyle,
                    ),
                    Text(
                      '${user?.email}',
                      style: h4LightTextStyle,
                    ),
                    Text(
                      ' (Admin)',
                      style: h4LightTextStyle,
                    ),
                  ],
                )),
                IconButton(
                  onPressed: () {
                    auth.FirebaseAuth.instance.signOut();
                  },
                  icon: Icon(
                    Icons.exit_to_app,
                    color: Colors.white,
                  ),
                ),
                HSpace(),
              ],
            ),
          ),
          VSpace(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonWrapper(
                padding:
                    EdgeInsets.symmetric(horizontal: kHPad, vertical: kVPad),
                backgroundColor: secondaryColor,
                border: Border.all(width: 1, color: primaryColor),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddCategory(),
                      ));
                },
                child: Text(
                  'Add Category',
                  style: h4TextStyle.copyWith(color: primaryColor),
                ),
              ),
              HSpace(),
              ButtonWrapper(
                padding:
                    EdgeInsets.symmetric(horizontal: kHPad, vertical: kVPad),
                backgroundColor: secondaryColor,
                border: Border.all(width: 1, color: primaryColor),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Categories(),
                      ));
                },
                child: Text(
                  'View Categories',
                  style: h4TextStyle.copyWith(color: primaryColor),
                ),
              ),
            ],
          ),
          VSpace(),
          HLine(
            color: primaryColor.withOpacity(.5),
          ),
          VSpace(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonWrapper(
                padding:
                    EdgeInsets.symmetric(horizontal: kHPad, vertical: kVPad),
                backgroundColor: secondaryColor,
                border: Border.all(width: 1, color: primaryColor),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(
                          signUpUser: true,
                        ),
                      ));
                },
                child: Text(
                  'Add User',
                  style: h4TextStyle.copyWith(color: primaryColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
