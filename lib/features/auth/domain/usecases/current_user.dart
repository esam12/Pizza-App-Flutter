import 'package:fpdart/fpdart.dart';
import 'package:pizza_app/core/usecases/use_case.dart';
import 'package:pizza_app/core/utils/errors/failure.dart';
import 'package:pizza_app/core/common/entities/user_entity.dart';
import 'package:pizza_app/features/auth/domain/repos/user_repo.dart';

class CurrentUser implements UseCase<User, NoParams> {
  final AuthRepository authRepository;

  CurrentUser(this.authRepository);
  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await authRepository.currentUser();
  }
}
