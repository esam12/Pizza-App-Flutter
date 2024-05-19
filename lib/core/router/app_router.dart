import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/core/di/init_dependencies.dart';
import 'package:pizza_app/core/router/routes.dart';
import 'package:pizza_app/features/auth/presentation/manager/auth/auth_bloc.dart';
import 'package:pizza_app/features/auth/presentation/views/login_screen.dart';
import 'package:pizza_app/features/auth/presentation/views/signup_screen.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => serviceLocator<AuthBloc>(),
            child: const LoginScreen(),
          ),
        );
      case Routes.signUpScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => serviceLocator<AuthBloc>(),
            child: const SignUpScreen(),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text("No route defined for ${settings.name}"),
            ),
          ),
        );
    }
  }
}
