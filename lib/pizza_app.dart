import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pizza_app/core/router/app_router.dart';
import 'package:pizza_app/core/router/routes.dart';
import 'package:pizza_app/core/styles/theme.dart';
import 'package:pizza_app/features/auth/presentation/manager/auth/auth_bloc.dart';

class PizzaApp extends StatefulWidget {
  final AppRouter appRouter;

  const PizzaApp({super.key, required this.appRouter});

  @override
  State<PizzaApp> createState() => _PizzaAppState();
}

class _PizzaAppState extends State<PizzaApp> {
  @override
  void initState() {
    super.initState();
    print("test");
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: MaterialApp(
        title: 'Pizza Delivery',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkThemeMode,
        initialRoute: Routes.loginScreen,
        onGenerateRoute: widget.appRouter.generateRoute,
      ),
    );
  }
}
