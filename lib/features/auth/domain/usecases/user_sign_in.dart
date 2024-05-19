import 'package:fpdart/fpdart.dart';
import 'package:pizza_app/core/usecases/use_case.dart';
import 'package:pizza_app/core/utils/errors/failure.dart';
import 'package:pizza_app/core/common/entities/user_entity.dart';
import 'package:pizza_app/features/auth/domain/repos/user_repo.dart';

class UserSignIn extends UseCase<User, UserSignInParams> {
  final AuthRepository authRepository;
  UserSignIn(this.authRepository);
  @override
  Future<Either<Failure, User>> call(UserSignInParams params) async {
    return await authRepository.loginWithEmailPassword(
        email: params.email, password: params.password);
  }
}

class UserSignInParams {
  final String email;
  final String password;

  UserSignInParams({
    required this.email,
    required this.password,
  });
}
