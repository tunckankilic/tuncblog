import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tuncblog/core/error/failure.dart';
import 'package:tuncblog/core/usecases/usecase.dart';
import 'package:tuncblog/feature/auth/domain/repositories/auth_repository.dart';

class CurrentUser implements UseCase<User, NoParams> {
  final AuthRepository authRepository;
  CurrentUser(this.authRepository);

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    throw await authRepository.currentUser();
  }
}
