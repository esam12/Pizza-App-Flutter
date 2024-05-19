import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:pizza_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:pizza_app/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:pizza_app/features/auth/data/repos/firebase_user_repo.dart';
import 'package:pizza_app/features/auth/domain/repos/user_repo.dart';
import 'package:pizza_app/features/auth/domain/usecases/current_user.dart';
import 'package:pizza_app/features/auth/domain/usecases/user_sign_in.dart';
import 'package:pizza_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:pizza_app/features/auth/presentation/manager/auth/auth_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  final firebaseAuth = FirebaseAuth.instance;
  serviceLocator.registerLazySingleton(() => firebaseAuth);

  // core
  serviceLocator.registerLazySingleton(() => AppUserCubit());
}

void _initAuth() {
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImp(
        serviceLocator(),
      ),
    )
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserSignUp(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserSignIn(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => CurrentUser(
        serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocator(),
        userSignIn: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCuibt: serviceLocator(),
      ),
    );
}
