import 'package:fpdart/fpdart.dart';
import 'package:pizza_app/core/usecases/use_case.dart';
import 'package:pizza_app/core/utils/errors/failure.dart';
import 'package:pizza_app/core/common/entities/user_entity.dart';
import 'package:pizza_app/features/auth/domain/repos/user_repo.dart';

class UserSignUp implements UseCase<User, UserSignUpParams> {
  final AuthRepository authRepository;
  const UserSignUp(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserSignUpParams params) async {
    return await authRepository.signUpWithEmailPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignUpParams {
  final String email;
  final String password;
  final String name;

  UserSignUpParams(
      {required this.email, required this.password, required this.name});
}
