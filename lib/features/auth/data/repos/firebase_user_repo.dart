import 'package:fpdart/fpdart.dart';
import 'package:pizza_app/core/utils/errors/failure.dart';
import 'package:pizza_app/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:pizza_app/core/common/entities/user_entity.dart';
import 'package:pizza_app/features/auth/domain/repos/user_repo.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  const AuthRepositoryImpl(
    this.remoteDataSource,
  );

  @override
  Future<Either<Failure, User>> loginWithEmailPassword(
      {required String email, required String password}) async {
    return _getUser(() async => await remoteDataSource.loginWithEmailPassword(
        email: email, password: password));
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword(
      {required String name,
      required String email,
      required String password}) async {
    return _getUser(() async => await remoteDataSource.signUpWithEmailPassword(
        name: name, email: email, password: password));
  }

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      final user = await remoteDataSource.getCurrentUserData();
      if (user == null) {
        return left(ServerFailure('User not logged in!'));
      }
      return right(user);
    } on Failure catch (e) {
      return left(ServerFailure(e.meesage));
    }
  }

  Future<Either<Failure, User>> _getUser(
    Future<User> Function() fn,
  ) async {
    try {
      final user = await fn();

      return right(user);
    } on Failure catch (e) {
      return left(ServerFailure(e.meesage));
    }
  }
}
