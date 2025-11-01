import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../features/presentation/cubit/materi_cubit.dart';
import '../features/presentation/cubit/post_test_cubit.dart';
import '../features/presentation/cubit/pre_test_cubit.dart';
import '../features/presentation/cubit/profile_cubit.dart';
import '../features/presentation/cubit/signin_cubit.dart';
import '../features/presentation/cubit/signup_cubit.dart';
import '../features/presentation/cubit/splash_cubit.dart';
import '../features/presentation/pages/home_screen.dart';
import '../features/presentation/pages/list_quis_screen.dart';
import '../features/presentation/pages/materi_screen.dart';
import '../features/presentation/pages/post_test_screen.dart';
import '../features/presentation/pages/pre_test_screen.dart';
import '../features/presentation/pages/profil_screen.dart';
import '../features/presentation/pages/result_screen.dart';
import '../features/presentation/pages/signin_screen.dart';
import '../features/presentation/pages/signup_screen.dart';
import '../features/presentation/pages/splash_screen.dart';
import '../features/presentation/pages/update_pass_screen.dart';
import '../features/presentation/pages/update_profil_screen.dart';
import '../injection.dart';

part 'app_router.g.dart';

/// SPLASH SCREEN - Entry point
@TypedGoRoute<SplashRoute>(path: '/')
class SplashRoute extends GoRouteData with $SplashRoute {
  const SplashRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => dI<SplashCubit>(),
      child: const SplashScreen(),
    );
  }
}

/// SIGNIN SCREEN
@TypedGoRoute<SigninRoute>(path: '/signin')
class SigninRoute extends GoRouteData with $SigninRoute {
  const SigninRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => dI<SigninCubit>(),
      child: const SignInScreen(),
    );
  }
}

/// SIGNUP SCREEN
@TypedGoRoute<SignupRoute>(path: '/signup')
class SignupRoute extends GoRouteData with $SignupRoute {
  const SignupRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => dI<SignupCubit>(),
      child: const SignUpScreen(),
    );
  }
}

/// HOME SCREEN - Main navigation hub
@TypedGoRoute<HomeRoute>(
  path: '/home',
  routes: [
    TypedGoRoute<PretestRoute>(path: 'pretest'),
    TypedGoRoute<PosttestRoute>(path: 'posttest'),
    TypedGoRoute<MateriRoute>(path: 'materi'),
    TypedGoRoute<ListquizRoute>(path: 'listquiz'),
    TypedGoRoute<ResultRoute>(path: 'result'),
    TypedGoRoute<ProfileRoute>(path: 'profile'),
    TypedGoRoute<UpdatePasswordRoute>(path: 'updatepassword'),
    TypedGoRoute<UpdateProfileRoute>(path: 'updateprofile'),
  ],
)
class HomeRoute extends GoRouteData with $HomeRoute {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomeScreen();
  }
}

/// PRETEST SCREEN - Nested under Home
class PretestRoute extends GoRouteData with $PretestRoute {
  const PretestRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => dI<PreTestCubit>(),
      child: const PreTestScreen(),
    );
  }
}

/// POSTTEST SCREEN - Nested under Home
class PosttestRoute extends GoRouteData with $PosttestRoute {
  const PosttestRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => dI<PostTestCubit>(),
      child: const PostTestScreen(),
    );
  }
}

/// MATERI SCREEN - Nested under Home
class MateriRoute extends GoRouteData with $MateriRoute {
  const MateriRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => dI<MateriCubit>(),
      child: const MateriScreen(),
    );
  }
}

/// LIST QUIZ SCREEN - Nested under Home
class ListquizRoute extends GoRouteData with $ListquizRoute {
  const ListquizRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ListQuisScreen();
  }
}

/// RESULT SCREEN - Nested under Home
class ResultRoute extends GoRouteData with $ResultRoute {
  const ResultRoute({this.score = 0});

  final int score;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ResultScreen(score: score);
  }
}

/// PROFILE SCREEN - Nested under Home
class ProfileRoute extends GoRouteData with $ProfileRoute {
  const ProfileRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => dI<ProfileCubit>(),
      child: const ProfileScreen(),
    );
  }
}

/// UPDATE PASSWORD SCREEN - Nested under Home
class UpdatePasswordRoute extends GoRouteData with $UpdatePasswordRoute {
  const UpdatePasswordRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const UpdatePasswordScreen();
  }
}

/// UPDATE PROFILE SCREEN - Nested under Home
class UpdateProfileRoute extends GoRouteData with $UpdateProfileRoute {
  const UpdateProfileRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const UpdateProfileScreen();
  }
}

/// Global GoRouter instance
final GoRouter router = GoRouter(
  routes: $appRoutes,
  initialLocation: '/',
  // redirect: (BuildContext context, GoRouterState state) {
  //   // Redirect root path (/) to splash screen
  //   if (state.matchedLocation == '/') {
  //     return RoutePath.splash;
  //   }
  //   return null;
  // },
);
