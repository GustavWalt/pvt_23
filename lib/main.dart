import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pvt_23/screens/homepage/home_page.dart';
import 'package:pvt_23/screens/login/sign_in_page.dart';
import 'package:pvt_23/screens/signup/sign_up_page.dart';
import 'package:pvt_23/screens/chatList/chat_list_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

/*
Bra sen när vi vill redirect någon som inte är inloggad.
redirect: (BuildContext context, GoRouterState state) {
  if (AuthState.of(context).isSignedIn) {
    return '/signin';
  } else {
    return null;
  }   
},
*/

// Route config
final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const ChatListView();
    }),
    GoRoute(
      path: '/sign_up',
      builder: (BuildContext context, GoRouterState state) {
        return const SignUpView();
      },
    ),
    GoRoute(
      path: '/home_page',
      builder: (BuildContext context, GoRouterState state) {
        return const HomePageView();
      },
    ),
    GoRoute(
      path: '/chat_list',
      builder: (BuildContext context, GoRouterState state) {
        return const ChatListView();
      },
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}
