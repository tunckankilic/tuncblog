import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuncblog/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:tuncblog/feature/auth/presentation/pages/sign_up_page.dart';
import 'package:tuncblog/feature/auth/presentation/widgets/auth_button.dart';
import 'package:tuncblog/feature/auth/presentation/widgets/auth_field.dart';
import 'package:tuncblog/feature/blog/presentation/pages/blog_page.dart';
import 'package:tuncblog/feature/blog/presentation/pages/blog_viewer_page.dart';

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
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthFailure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text("Auth Failed: ${state.message}"),
                    ),
                  );
              }
            },
            builder: (context, state) {
              if (state is AuthLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Form(
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
                          if (formKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                                  AuthLogin(
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                  ),
                                );
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const BlogPage(),
                              ),
                            );
                          }
                        },
                      ),
                      SizedBox(
                        height: 50.h,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const SignUpPage(),
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
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
