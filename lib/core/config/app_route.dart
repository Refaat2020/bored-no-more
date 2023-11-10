import 'package:bored_no_more/features/activity_feature/views/my_planned_activities/my_planned_activities_screen.dart';
import 'package:bored_no_more/features/auth_feature/views/registration_screen/registration_screen.dart';

import '../../features/activity_feature/views/activities_screen/activities_screen.dart';
import '../../features/auth_feature/views/splash_screen/splash_screen.dart';
import '../../fileExport.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static final route = GoRouter(
      navigatorKey: navigatorKey,
      debugLogDiagnostics: true,
      routes: <RouteBase>[
        GoRoute(
          path: '/',
          name: SplashScreen.route,
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path:  RegistrationScreen.route,
          name:  RegistrationScreen.route,
          builder: (context, state) => const RegistrationScreen(),
        ),

        GoRoute(
          path:  ActivitiesScreen.route,
          name:  ActivitiesScreen.route,
          builder: (context, state) =>  ActivitiesScreen(),
          routes: [
            GoRoute(
              path:  MyPlannedActivitiesScreen.route,
              name:  MyPlannedActivitiesScreen.route,
              builder: (context, state) =>  MyPlannedActivitiesScreen(),
            ),
          ]
        ),
      ]);
}