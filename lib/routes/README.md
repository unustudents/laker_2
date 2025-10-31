## Routes Configuration Documentation

### Overview
Router configuration untuk aplikasi menggunakan `go_router` package. File ini mengelola semua routing logic aplikasi.

### File Structure

```
lib/routes/
├── app_router.dart     # Main router configuration
├── app_routes.dart     # Route paths and names constants
└── README.md           # This file
```

### Routes Definition

#### Available Routes:

| Route | Path | Name | Purpose |
|-------|------|------|---------|
| SignIn | `/signin` | `signin` | User authentication screen |
| SignUp | `/signup` | `signup` | User registration screen |
| Home | `/home` | `home` | Main application screen |

### Usage Examples

#### 1. Basic Navigation (GoRouter)

```dart
// Navigate using path
context.go('/signin');

// Navigate using name
context.goNamed('signin');

// Replace current screen with path
context.replace('/home');

// Replace using name
context.replaceName('home');
```

#### 2. Using Helper Methods

```dart
// SignIn Navigation
AppRouter.goToSignIn(context);

// SignUp Navigation
AppRouter.goToSignUp(context);

// Home Navigation
AppRouter.goToHome(context);

// Replace with SignIn
AppRouter.replaceWithSignIn(context);

// Replace with Home
AppRouter.replaceWithHome(context);
```

#### 3. Query Parameters

```dart
// Navigate with query parameters
context.go('/signin?email=user@example.com');

// Access parameters in page
final email = state.uri.queryParameters['email'];
```

#### 4. Path Parameters

```dart
// Define route with path parameter (in app_router.dart):
GoRoute(
  path: '/user/:id',
  builder: (context, state) {
    final userId = state.pathParameters['id'];
    return UserDetailScreen(userId: userId);
  },
)

// Navigate with path parameter
context.go('/user/123');
```

### Setup in main.dart

```dart
import 'package:flutter/material.dart';
import 'routes/app_router.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      title: 'Laker 2',
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}
```

### Best Practices

1. **Use Named Routes**: Always use named routes (`goNamed`) instead of hardcoded paths for better maintainability.

2. **Centralize Route Constants**: All route paths and names are defined in `app_routes.dart`.

3. **Helper Methods**: Use `AppRouter` helper methods for common navigation operations.

4. **Error Handling**: Router has built-in error page handling for undefined routes.

5. **Type Safety**: Using constants prevents typos in route names.

### Adding New Routes

To add a new route:

1. Add route path and name to `app_routes.dart`:
```dart
static const String newPage = '/new-page';
static const String newPageName = 'newPage';
```

2. Add route definition to `app_router.dart`:
```dart
GoRoute(
  path: AppRoutes.newPage,
  name: AppRouteNames.newPageName,
  pageBuilder: (context, state) => MaterialPage(
    child: NewScreen(),
  ),
),
```

3. Add helper method (optional):
```dart
static void goToNewPage(BuildContext context) {
  context.goNamed(AppRouteNames.newPageName);
}
```

### Advanced Features

#### 1. Nested Routes
```dart
GoRoute(
  path: '/parent',
  pageBuilder: (context, state) => MaterialPage(child: ParentScreen()),
  routes: [
    GoRoute(
      path: 'child',
      pageBuilder: (context, state) => MaterialPage(child: ChildScreen()),
    ),
  ],
)
```

#### 2. Route Transitions
```dart
GoRoute(
  path: '/slide',
  pageBuilder: (context, state) => CustomTransitionPage(
    child: const Screen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: animation.drive(Tween(begin: const Offset(1, 0), end: Offset.zero)),
        child: child,
      );
    },
  ),
)
```

#### 3. Redirect Logic
```dart
GoRouter(
  redirect: (context, state) {
    // Example: Redirect to signin if not authenticated
    if (!isAuthenticated && state.matchedLocation != '/signin') {
      return '/signin';
    }
    return null;
  },
)
```

### Troubleshooting

**Route Not Found**
- Check if route is defined in `app_router.dart`
- Verify path and name are consistent with `app_routes.dart`

**Navigation Not Working**
- Ensure `MaterialApp.router` is used instead of `MaterialApp`
- Check `routerConfig` is set to `AppRouter.router`

**Parameters Not Passed**
- Use `state.uri.queryParameters` for query parameters
- Use `state.pathParameters` for path parameters

### References

- [go_router documentation](https://pub.dev/packages/go_router)
- [Flutter routing best practices](https://docs.flutter.dev/development/ui/navigation)
