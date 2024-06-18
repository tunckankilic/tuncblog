// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final String title;
  final TextEditingController tec;
  final bool isObs;
  const AuthField({
    super.key,
    required this.title,
    required this.tec,
    required this.isObs,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: tec,
      obscureText: isObs,
      decoration: InputDecoration(
        hintText: title,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "$title is missing! Please fill the field";
        }
        return null;
      },
    );
  }
}
