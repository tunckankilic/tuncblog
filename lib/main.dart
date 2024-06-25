import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuncblog/core/theme/theme.dart';
import 'package:tuncblog/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:tuncblog/feature/auth/presentation/pages/sign_up_page.dart';
import 'package:tuncblog/init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(2790, 1290),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => s1<AuthBloc>(),
          ),
        ],
        child: MaterialApp(
          title: "Blog App",
          theme: AppTheme.darkThemeMode,
          home: SignUpPage(),
        ),
      ),
    );
  }
}
