import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'injection.dart';
import 'observer.dart';
import 'routes/app_router.dart';
import 'supabase_config.dart';
import 'theme/theme_light.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize Supabase
  await SupabaseConfig.initialize();

  await init();
  Bloc.observer = MainObserver();
  runApp(
    DevicePreview(
      enabled: !kReleaseMode && !Platform.isAndroid,
      builder: (BuildContext context) => const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      builder: DevicePreview.appBuilder,
      routerConfig: router,
      theme: ThemeApp.light,
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      title: 'Laker',
    );
  }
}
