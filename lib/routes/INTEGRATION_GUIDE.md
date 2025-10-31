/// Router Integration Guide
/// 
/// Step-by-step guide untuk mengintegrasikan go_router ke main.dart

/*
STEP 1: Update main.dart

Ganti dari:
```dart
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
```

Menjadi:
```dart
import 'routes/app_router.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      title: 'Laker 2',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      builder: DevicePreview.appBuilder,
    );
  }
}
```

STEP 2: Dependencies Check

Pastikan pubspec.yaml sudah memiliki:
```yaml
dependencies:
  flutter:
    sdk: flutter
  go_router: ^16.3.0  # Sudah ada di project
  flutter_bloc: ^8.1.6
  bloc: ^8.1.4
```

STEP 3: Navigation di Screen

Gunakan navigation dengan:
```dart
// Option 1: Menggunakan helper methods
AppRouter.goToHome(context);
AppRouter.goToSignUp(context);

// Option 2: Direct context.go
context.go('/home');

// Option 3: Named navigation
context.goNamed('home');
```

CURRENT STATE:
✅ app_router.dart - Router configuration dengan go_router
✅ app_routes.dart - Constants untuk routes
✅ README.md - Dokumentasi lengkap

TODO:
1. Update main.dart untuk menggunakan MaterialApp.router
2. Implementasi SignUpScreen di features/presentation/pages/
3. Implementasi HomeScreen di features/presentation/pages/
4. Tambahan redirect logic untuk authentication flow
*/
