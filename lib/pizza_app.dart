import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pizza_app/core/router/app_router.dart';
import 'package:pizza_app/core/router/routes.dart';

class PizzaApp extends StatelessWidget {
  final AppRouter appRouter;

  const PizzaApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: MaterialApp(
        title: 'Pizza Delivery',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.light(
            background: Colors.grey.shade200,
            onBackground: Colors.black,
            primary: Colors.blue,
            onPrimary: Colors.white,
          ),
        ),
        initialRoute: Routes.loginScreen,
        onGenerateRoute: appRouter.generateRoute,
      ),
    );
  }
}
