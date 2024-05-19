import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:pizza_app/core/di/init_dependencies.dart';
import 'package:pizza_app/core/router/app_router.dart';
import 'package:pizza_app/features/auth/presentation/manager/auth/auth_bloc.dart';
import 'package:pizza_app/firebase_options.dart';
import 'package:pizza_app/pizza_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initDependencies();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => serviceLocator<AuthBloc>(),
        ),
        BlocProvider(
          create: (context) => serviceLocator<AppUserCubit>(),
        ),
      ],
      child: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) {
          return state is AppUserLoggedIn;
        },
        builder: (context, isLoggedIn) {
          if (isLoggedIn) {
            return const Scaffold(
              body: Center(
                child: Text("Logged in !!"),
              ),
            );
          }
          return PizzaApp(
            appRouter: AppRouter(),
          );
        },
      ),
    ),
  );
}
