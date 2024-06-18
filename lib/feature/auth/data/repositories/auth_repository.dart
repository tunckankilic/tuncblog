// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fpdart/src/either.dart';
import 'package:tuncblog/core/common/constants/constants.dart';
import 'package:tuncblog/core/common/entities/user.dart';
import 'package:tuncblog/core/error/exceptions.dart';

import 'package:tuncblog/core/error/failure.dart';
import 'package:tuncblog/core/network/connection_checker.dart';
import 'package:tuncblog/feature/auth/data/datasources/auth_remote_data_source.dart';
import 'package:tuncblog/feature/auth/data/models/user_model.dart';
import 'package:tuncblog/feature/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final ConnectionChecker connectionChecker;
  const AuthRepositoryImpl(
    this.remoteDataSource,
    this.connectionChecker,
  );

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      if (!await (connectionChecker.isConnected)) {
        final session = remoteDataSource.currentUserSession;

        if (session == null) {
          return left(Failure(message: 'User not logged in!'));
        }

        return right(
          UserModel(
            id: session.user.id,
            email: session.user.email ?? '',
            name: '',
          ),
        );
      }
      final user = await remoteDataSource.getCurrentUserData();
      if (user == null) {
        return left(Failure(message: 'User not logged in!'));
      }

      return right(user);
    } on ServerExceptions catch (e) {
      return left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, User>> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await remoteDataSource.loginWithEmailPassword(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await remoteDataSource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      ),
    );
  }

  Future<Either<Failure, User>> _getUser(
    Future<User> Function() fn,
  ) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(Failure(message: Constants.noConnectionErrorMessage));
      }
      final user = await fn();

      return right(user);
    } on ServerExceptions catch (e) {
      return left(Failure(message: e.message));
    }
  }
}
