import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/presentation/pages/signin_screen.dart';
import '../features/presentation/pages/signup_screen.dart';
import 'app_routes.dart';

/// Application router configuration using go_router
class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/signin',
    routes: <RouteBase>[
      GoRoute(
        path: RoutePath.signin,
        name: RouteName.signin,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return const MaterialPage<void>(child: SignInScreen());
        },
      ),
      GoRoute(
        path: RoutePath.signup,
        name: RouteName.signup,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return const MaterialPage<void>(child: SignUpScreen());
        },
      ),
    ],
  );
}
