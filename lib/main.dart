import 'package:breakingbadproject/app_router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(GameOfThrnoesApp(
    appRouter: AppRouter(),
  ));
}

class GameOfThrnoesApp extends StatelessWidget {
  final AppRouter appRouter;

  const GameOfThrnoesApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}
