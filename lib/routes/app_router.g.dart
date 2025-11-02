// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $splashRoute,
  $signinRoute,
  $signupRoute,
  $homeRoute,
];

RouteBase get $splashRoute =>
    GoRouteData.$route(path: '/', factory: $SplashRoute._fromState);

mixin $SplashRoute on GoRouteData {
  static SplashRoute _fromState(GoRouterState state) => const SplashRoute();

  @override
  String get location => GoRouteData.$location('/');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $signinRoute =>
    GoRouteData.$route(path: '/signin', factory: $SigninRoute._fromState);

mixin $SigninRoute on GoRouteData {
  static SigninRoute _fromState(GoRouterState state) => const SigninRoute();

  @override
  String get location => GoRouteData.$location('/signin');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $signupRoute =>
    GoRouteData.$route(path: '/signup', factory: $SignupRoute._fromState);

mixin $SignupRoute on GoRouteData {
  static SignupRoute _fromState(GoRouterState state) => const SignupRoute();

  @override
  String get location => GoRouteData.$location('/signup');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $homeRoute => GoRouteData.$route(
  path: '/home',
  factory: $HomeRoute._fromState,
  routes: [
    GoRouteData.$route(path: 'pretest', factory: $PretestRoute._fromState),
    GoRouteData.$route(path: 'posttest', factory: $PosttestRoute._fromState),
    GoRouteData.$route(path: 'materi', factory: $MateriRoute._fromState),
    GoRouteData.$route(path: 'listquiz', factory: $ListquizRoute._fromState),
    GoRouteData.$route(path: 'result', factory: $ResultRoute._fromState),
    GoRouteData.$route(path: 'profile', factory: $ProfileRoute._fromState),
    GoRouteData.$route(
      path: 'updatepassword',
      factory: $UpdatePasswordRoute._fromState,
    ),
    GoRouteData.$route(
      path: 'updateprofile',
      factory: $UpdateProfileRoute._fromState,
    ),
  ],
);

mixin $HomeRoute on GoRouteData {
  static HomeRoute _fromState(GoRouterState state) => const HomeRoute();

  @override
  String get location => GoRouteData.$location('/home');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $PretestRoute on GoRouteData {
  static PretestRoute _fromState(GoRouterState state) => PretestRoute(
    idKategori:
        _$convertMapValue(
          'id-kategori',
          state.uri.queryParameters,
          int.parse,
        ) ??
        1,
  );

  PretestRoute get _self => this as PretestRoute;

  @override
  String get location => GoRouteData.$location(
    '/home/pretest',
    queryParams: {
      if (_self.idKategori != 1) 'id-kategori': _self.idKategori.toString(),
    },
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $PosttestRoute on GoRouteData {
  static PosttestRoute _fromState(GoRouterState state) => const PosttestRoute();

  @override
  String get location => GoRouteData.$location('/home/posttest');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $MateriRoute on GoRouteData {
  static MateriRoute _fromState(GoRouterState state) => const MateriRoute();

  @override
  String get location => GoRouteData.$location('/home/materi');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ListquizRoute on GoRouteData {
  static ListquizRoute _fromState(GoRouterState state) =>
      ListquizRoute(state.uri.queryParameters['category']!);

  ListquizRoute get _self => this as ListquizRoute;

  @override
  String get location => GoRouteData.$location(
    '/home/listquiz',
    queryParams: {'category': _self.category},
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ResultRoute on GoRouteData {
  static ResultRoute _fromState(GoRouterState state) => ResultRoute(
    score:
        _$convertMapValue('score', state.uri.queryParameters, int.parse) ?? 0,
  );

  ResultRoute get _self => this as ResultRoute;

  @override
  String get location => GoRouteData.$location(
    '/home/result',
    queryParams: {if (_self.score != 0) 'score': _self.score.toString()},
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ProfileRoute on GoRouteData {
  static ProfileRoute _fromState(GoRouterState state) => const ProfileRoute();

  @override
  String get location => GoRouteData.$location('/home/profile');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $UpdatePasswordRoute on GoRouteData {
  static UpdatePasswordRoute _fromState(GoRouterState state) =>
      const UpdatePasswordRoute();

  @override
  String get location => GoRouteData.$location('/home/updatepassword');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $UpdateProfileRoute on GoRouteData {
  static UpdateProfileRoute _fromState(GoRouterState state) =>
      const UpdateProfileRoute();

  @override
  String get location => GoRouteData.$location('/home/updateprofile');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

T? _$convertMapValue<T>(
  String key,
  Map<String, String> map,
  T? Function(String) converter,
) {
  final value = map[key];
  return value == null ? null : converter(value);
}
