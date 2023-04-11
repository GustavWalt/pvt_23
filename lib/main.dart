import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pvt_23/screens/login/login_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

// Route config
final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginView();
      },
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  //hejsan!

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}
