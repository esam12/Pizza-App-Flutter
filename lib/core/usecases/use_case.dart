import 'package:fpdart/fpdart.dart';
import 'package:pizza_app/core/utils/errors/failure.dart';

abstract class UseCase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}

class NoParams{}
