import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:pvt_23/providers/group_id_provider.dart';
import 'package:pvt_23/providers/navigation_bar_provider.dart';
import 'package:pvt_23/screens/CreateGroupPage/create_group_page.dart';
import 'package:pvt_23/screens/LoginPage/login_page.dart';
import 'package:pvt_23/screens/RegisterPage/register_page.dart';
import 'package:pvt_23/screens/ChatListPage/chat_list_page.dart';
import 'package:pvt_23/screens/GroupPage/group_page.dart';
import 'package:pvt_23/screens/ProfilePage/profile_page.dart';
import 'package:pvt_23/screens/SearchPage/search_page.dart';
import 'package:pvt_23/screens/SearchPickPage/search_pick_page.dart';
import 'package:pvt_23/screens/SearchResultsPage/search_results_page.dart';
import 'package:pvt_23/screens/calendarPage/calendar_page.dart';
import 'package:pvt_23/screens/ChatPage/chat_page.dart';
import 'package:pvt_23/screens/SpecificMovieResultPage/specific_movie_result_page.dart';
import 'package:pvt_23/screens/FindGroupResultPage/find_group_result_page.dart';
import 'package:pvt_23/screens/FindNewGroupPage/find_new_group_page.dart';
import 'package:pvt_23/screens/FetchDataTestPage/fetch_data_test_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pvt_23/screens/PlannedEventPage/planned_event_page.dart';
import 'package:pvt_23/screens/CreateEventPage/create_event_page.dart';
import 'package:pvt_23/screens/SpecificMovieResultPickPage/specific_movie_result_pick_page.dart';
import 'package:pvt_23/screens/createGroupPage/create_group_page_edit.dart';

import 'package:pvt_23/screens/profilePage/profile_page_edit.dart';
import 'package:pvt_23/screens/selectedGroupPage/selected_group_page.dart';

import 'firebase_options.dart';
import 'logic/movie_class.dart';

/*
Bra sen när vi vill redirect någon som inte är inloggad.

*/

// Route config
final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return LoginPage();
        }),
    GoRoute(
      path: '/chat_page',
      name: 'chat_page',
      builder: (context, state) {
        Stream<QuerySnapshot<Map<String, dynamic>>> selectedGroup =
            state.extra as Stream<QuerySnapshot<Map<String, dynamic>>>;
        return ChatPage(selectedGroup: selectedGroup);
      },
    ),
    GoRoute(
        path: '/search_page',
        builder: (BuildContext context, GoRouterState state) {
          return const SearchPage();
        }),
    GoRoute(
        path: '/search_pick_page',
        builder: (BuildContext context, GoRouterState state) {
          return const SearchPickPage();
        }),
    GoRoute(
      path: '/planned_event_page',
      name: 'planned_event_page',
      builder: (context, state) {
        Map? eventInfo = state.extra as Map?; // -> casting is important
        return PlannedEventPage(eventInfo: eventInfo);
      },
    ),
    GoRoute(
      path: '/create_group_page',
      builder: (BuildContext context, GoRouterState state) {
        return const CreateGroupPage();
      },
    ),
    GoRoute(
      path: '/create_group_page_edit',
      name: 'create_group_page_edit',
      builder: (context, state) {
        Stream<QuerySnapshot<Map<String, dynamic>>> selectedGroup =
            state.extra as Stream<QuerySnapshot<Map<String, dynamic>>>;
        return CreateGroupPageEdit(selectedGroup: selectedGroup);
      },
    ),
    GoRoute(
      path: '/create_event_page',
      name: 'create_event_page',
      builder: (context, state) {
        Movie? movie = state.extra as Movie?; // -> casting is important
        return CreateEventPage(movie: movie);
      },
    ),
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
      name: 'specific_movie_result_page',
      builder: (context, state) {
        Movie? movie = state.extra as Movie?; // -> casting is important
        return SpecificMovieResultPage(movie: movie);
      },
    ),
    GoRoute(
      path: '/specific_movie_result_pick_page',
      name: 'specific_movie_result_pick_page',
      builder: (context, state) {
        Movie? movie = state.extra as Movie?; // -> casting is important
        return SpecificMovieResultPickPage(movie: movie);
      },
    ),
    GoRoute(
        path: '/login_page',
        builder: (BuildContext context, GoRouterState state) {
          return LoginPage();
        }),
    GoRoute(
      path: '/register_page',
      builder: (BuildContext context, GoRouterState state) {
        return RegisterPage();
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
        path: '/profile_page_edit',
        builder: (BuildContext context, GoRouterState state) {
          return const ProfilePageEdit();
        }),
    GoRoute(
      path: '/chat_list_page',
      builder: (BuildContext context, GoRouterState state) {
        return const ChatListPage();
      },
    ),
    GoRoute(
      path: '/search_results_page',
      builder: (BuildContext context, GoRouterState state) {
        return const SearchResultsPage();
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
      name: 'find_group_result_page',
      builder: (context, state) {
        Stream<QuerySnapshot<Map<String, dynamic>>> foundGroups =
            state.extra as Stream<QuerySnapshot<Map<String, dynamic>>>;
        return FindGroupResultPage(foundGroups: foundGroups);
      },
    ),
    GoRoute(
      path: '/selected_group_page',
      name: 'selected_group_page',
      builder: (context, state) {
        Stream<QuerySnapshot<Map<String, dynamic>>> selectedGroup =
            state.extra as Stream<QuerySnapshot<Map<String, dynamic>>>;
        return SelectedGroupPage(selectedGroup: selectedGroup);
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
        ChangeNotifierProvider(create: (context) => NavigationBarProvider()),
        ChangeNotifierProvider(create: (context) => GroupIdProvider())
      ],
      child: MaterialApp.router(
        routerConfig: _router,
      ),
    );
  }
}
