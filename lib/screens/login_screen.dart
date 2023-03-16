// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:dashboard_task/constants/colors.dart';
import 'package:dashboard_task/constants/sizes.dart';
import 'package:dashboard_task/constants/styles.dart';
import 'package:dashboard_task/global/widgets/button_wrapper.dart';
import 'package:dashboard_task/global/widgets/custom_text_field.dart';
import 'package:dashboard_task/global/widgets/padding_wrapper.dart';
import 'package:dashboard_task/global/widgets/v_space.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class LoginScreen extends StatefulWidget {
  final bool signUpUser;
  const LoginScreen({
    super.key,
    this.signUpUser = false,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: PaddingWrapper(
        child: Column(
          children: [
            VSpace(factor: 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/icons/teamwork.png',
                  width: largeIconSize * 3,
                ),
              ],
            ),
            VSpace(factor: 2),
            CustomTextField(
              controller: emailController,
              padding: EdgeInsets.zero,
              title: widget.signUpUser
                  ? 'Enter new user email'
                  : 'Enter your email',
              requiredField: true,
            ),
            VSpace(),
            CustomTextField(
              controller: passwordController,
              padding: EdgeInsets.zero,
              title: widget.signUpUser
                  ? 'Enter new user password'
                  : 'Enter your password',
              password: true,
              requiredField: true,
            ),
            VSpace(factor: 2),
            ButtonWrapper(
              padding: EdgeInsets.symmetric(
                horizontal: kHPad * 5,
                vertical: kVPad / 2,
              ),
              borderRadius: mediumBorderRadius,
              backgroundColor: primaryColor,
              onTap: () async {
                try {
                  if (widget.signUpUser) {
                    var res = await auth.FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text);
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('user added')));
                    Navigator.pop(context);
                  } else {
                    var res = await auth.FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text);
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('An Error Accourred')));
                }
              },
              child: Text(
                widget.signUpUser ? 'Add User' : 'Login',
                style: h3TextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
