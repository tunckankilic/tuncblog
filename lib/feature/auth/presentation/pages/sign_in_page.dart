import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuncblog/feature/auth/presentation/pages/sign_up_page.dart';
import 'package:tuncblog/feature/auth/presentation/widgets/auth_button.dart';
import 'package:tuncblog/feature/auth/presentation/widgets/auth_field.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
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
                  "Sign In",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                SizedBox(
                  height: 50.h,
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
                  title: "Sign In",
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
                        builder: (context) => SignUpPage(),
                      ),
                    );
                  },
                  child: RichText(
                    text: TextSpan(
                        text: "Don't you have an account? ",
                        style: Theme.of(context).textTheme.titleMedium,
                        children: [
                          TextSpan(
                              text: "Sign Up",
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
