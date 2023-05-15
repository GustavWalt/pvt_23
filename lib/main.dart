import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:pvt_23/providers/navigation_bar_provider.dart';
import 'package:pvt_23/screens/CalendarPage/calendar_page.dart';
import 'package:pvt_23/screens/ForumPage/forum_page.dart';
import 'package:pvt_23/screens/SpecificMovieResultPage/specific_movie_result_page.dart';
import 'package:pvt_23/screens/FindGroupResultPage/find_group_result_page.dart';
import 'package:pvt_23/screens/FindNewGroupPage/find_new_group_page.dart';
import 'package:pvt_23/screens/FetchDataTestPage/fetch_data_test_page.dart';
import 'package:pvt_23/screens/LoginPage/login_page.dart';
import 'package:pvt_23/screens/RegisterPage/register_page.dart';
import 'package:pvt_23/screens/ChatListPage/chat_list_page.dart';
import 'package:pvt_23/screens/GroupPage/group_page.dart';
import 'package:pvt_23/screens/ProfilePage/profile_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pvt_23/screens/PlannedEventPage/planned_event_page.dart';
import 'firebase_options.dart';
import 'screens/CreateGroupPage/create_group_page.dart';

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
          return const ForumPage();
        }),
    GoRoute(
        path: '/forum_page',
        builder: (BuildContext context, GoRouterState state) {
          return const ForumPage();
        }),
    GoRoute(
        path: '/planned_event_page',
        builder: (BuildContext context, GoRouterState state) {
          return const PlannedEventPage();
        }),
    GoRoute(
        path: '/calendar_page',
        builder: (BuildContext context, GoRouterState state) {
          return const CalendarPage();
        }),
    GoRoute(
        path: '/test_page',
        builder: (BuildContext context, GoRouterState state) {
          return FetchDataTestPage();
        }),
    GoRoute(
        path: '/specific_movie_result_page',
        builder: (BuildContext context, GoRouterState state) {
          return const SpecificMovieResultPage();
        }),
    GoRoute(
        path: '/login_page',
        builder: (BuildContext context, GoRouterState state) {
          return const LoginPage();
        }),
    GoRoute(
      path: '/register_page',
      builder: (BuildContext context, GoRouterState state) {
        return const RegisterPage();
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
    GoRoute(
      path: '/chat_list_page',
      builder: (BuildContext context, GoRouterState state) {
        return const ChatListPage();
      },
    ),
    GoRoute(
      path: '/create_group_page',
      builder: (BuildContext context, GoRouterState state) {
        return const CreateGroupPage();
      },
    ),
    GoRoute(
      path: '/find_new_group_page',
      builder: (BuildContext context, GoRouterState state) {
        return const FindNewGroupPage();
      },
    ),
    GoRoute(
      path: '/find_group_result_page',
      builder: (BuildContext context, GoRouterState state) {
        return const FindGroupResultPage();
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
