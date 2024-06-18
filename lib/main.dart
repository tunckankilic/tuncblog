import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tuncblog/core/secret/secret.dart';
import 'package:tuncblog/core/theme/theme.dart';
import 'package:tuncblog/feature/auth/presentation/pages/sign_up_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: Secret.url, anonKey: Secret.key);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(2790, 1290),
      child: MaterialApp(
        title: "Blog App",
        theme: AppTheme.darkThemeMode,
        home: SignUpPage(),
      ),
    );
  }
}
