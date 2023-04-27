import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:pvt_23/providers/navigation_bar_provider.dart';
import 'package:pvt_23/screens/homepage/home_page.dart';
import 'package:pvt_23/screens/login/sign_in.dart';
import 'package:pvt_23/screens/groupPage/group_page.dart';
import 'package:pvt_23/screens/profilePage/profile_page.dart';
import 'package:pvt_23/screens/signup/sign_up.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

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
          return const SignInView();
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
      path: '/group_page',
      builder: (BuildContext context, GoRouterState state) {
        return const GroupPage();
      },
    ),
    GoRoute(
      path: '/profile_page',
      builder: (BuildContext context, GoRouterState state) {
        return const ProfilePage();
      },
    ),
  ],
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NavigationBarProvider())
      ],
      child: MaterialApp.router(
        routerConfig: _router,
      ),
    );
  }
}
