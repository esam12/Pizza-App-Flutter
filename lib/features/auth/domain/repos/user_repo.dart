import 'package:fpdart/fpdart.dart';
import 'package:pizza_app/core/utils/errors/failure.dart';
import 'package:pizza_app/core/common/entities/user_entity.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<Either<Failure, User>> loginWithEmailPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> currentUser();
}
