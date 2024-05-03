import 'package:flutter/material.dart';
import 'package:pizza_app/core/router/app_router.dart';
import 'package:pizza_app/pizza_app.dart';

void main() {
  runApp(
    PizzaApp(
      appRouter: AppRouter(),
    ),
  );
}
