import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuncblog/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:tuncblog/core/theme/theme.dart';
import 'package:tuncblog/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:tuncblog/feature/auth/presentation/pages/sign_in_page.dart';
import 'package:tuncblog/feature/blog/presentation/bloc/blog_bloc.dart';
import 'package:tuncblog/feature/blog/presentation/pages/blog_page.dart';
import 'init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => serviceLocator<AuthBloc>(),
        ),
        BlocProvider<BlogBloc>(
          create: (_) => serviceLocator<BlogBloc>(),
        ),
        BlocProvider<AppUserCubit>(
          create: (_) => serviceLocator<AppUserCubit>(),
        ),
      ],
      child: const MyAppStateful(),
    );
  }
}

class MyAppStateful extends StatefulWidget {
  const MyAppStateful({super.key});

  @override
  State<MyAppStateful> createState() => _MyAppState();
}

class _MyAppState extends State<MyAppStateful> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthBloc>().add(AuthIsUserLoggedIn());
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(2790, 1290),
      child: MaterialApp(
        title: "Blog App",
        theme: AppTheme.darkThemeMode,
        home: BlocSelector<AppUserCubit, AppUserState, bool>(
          selector: (state) {
            return state is AppUserLoggedIn;
          },
          builder: (context, isLoggedIn) {
            if (isLoggedIn) {
              return const BlogPage();
            }
            return const SignInPage();
          },
        ),
      ),
    );
  }
}
