import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuncblog/feature/auth/presentation/pages/sign_in_page.dart';
import 'package:tuncblog/feature/auth/presentation/widgets/auth_button.dart';
import 'package:tuncblog/feature/auth/presentation/widgets/auth_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 150.w, vertical: 150.h),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Sign Up",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                SizedBox(
                  height: 50.h,
                ),
                AuthField(
                  title: "Name",
                  isObs: false,
                  tec: nameController,
                ),
                SizedBox(
                  height: 30.h,
                ),
                AuthField(
                  title: "Email",
                  isObs: false,
                  tec: emailController,
                ),
                SizedBox(
                  height: 30.h,
                ),
                AuthField(
                  title: "Password",
                  isObs: true,
                  tec: passwordController,
                ),
                SizedBox(
                  height: 50.h,
                ),
                AuthButton(
                  title: "Sign Up",
                  onPressed: () {
                    log("Pressed");
                  },
                ),
                SizedBox(
                  height: 50.h,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SignInPage(),
                      ),
                    );
                  },
                  child: RichText(
                    text: TextSpan(
                        text: "Do you have an account? ",
                        style: Theme.of(context).textTheme.titleMedium,
                        children: [
                          TextSpan(
                              text: "Sign In",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: Colors.red[700]))
                        ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
