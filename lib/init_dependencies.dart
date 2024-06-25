import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tuncblog/core/secret/secret.dart';
import 'package:tuncblog/feature/auth/data/datasources/auth_remote_data_source.dart';
import 'package:tuncblog/feature/auth/data/repositories/auth_repository.dart';
import 'package:tuncblog/feature/auth/domain/usecases/user_sign_up.dart';
import 'package:tuncblog/feature/auth/presentation/bloc/auth_bloc.dart';

final s1 = GetIt.instance;
Future<void> initDependencies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
    url: Secret.url,
    anonKey: Secret.key,
  );
  s1.registerSingleton(() => supabase.client);
}

void _initAuth() {
  s1.registerFactory<AuthRemoteDataSourceImpl>(
    () => AuthRemoteDataSourceImpl(
      s1(),
    ),
  );

  s1.registerFactory<AuthRepositoryImpl>(
    () => AuthRepositoryImpl(
      s1(),
    ),
  );

  s1.registerFactory<UserSignUp>(
    () => UserSignUp(
      s1(),
    ),
  );

  s1.registerLazySingleton<AuthBloc>(
    () => AuthBloc(
      userSignUp: s1(),
      userLogin: s1(),
      currentUser: s1(),
      appUserCubit: s1(),
    ),
  );
}
