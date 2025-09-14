import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'screens/hello_card_screen.dart';

void main() {
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  initialLocation: '/hello_card',
  routes: <RouteBase>[
    GoRoute(
      path: '/hello_card',
      builder: (BuildContext context, GoRouterState state) {
        return const HelloCardScreen();
      },
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routerConfig: _router,
    );
  }
}
