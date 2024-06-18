import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuncblog/core/theme/color_palette.dart';

class AuthButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  const AuthButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(colors: [
          ColorPalette.gradient1,
          ColorPalette.gradient2,
          ColorPalette.gradient3,
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          fixedSize: Size(2000.w, 110.h),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        child: Text(
          title,
          style: TextStyle(fontSize: 110.sp, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
