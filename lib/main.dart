import 'dart:io';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'features/presentation/cubit/profile_cubit.dart';
import 'injection.dart';
import 'observer.dart';
import 'routes/app_router.dart';
import 'supabase_config.dart';
import 'theme/theme_light.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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

class MainApp extends HookWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      final streaming = SupabaseConfig.client.auth.onAuthStateChange.listen((
        event,
      ) {
        if (event.event == AuthChangeEvent.signedOut ||
            event.event == AuthChangeEvent.passwordRecovery) {
          // Gunakan router.go() langsung, bukan context
          // karena context di sini belum memiliki GoRouter
          router.go('/signin');
        }
      });

      // Cleanup function (equivalent dengan dispose)
      return () => streaming.cancel();
    }, []); // Empty dependency array, runs once like initState

    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfileCubit>(create: (context) => dI<ProfileCubit>()),
      ],
      child: MaterialApp.router(
        builder: DevicePreview.appBuilder,
        routerConfig: router,
        theme: ThemeApp.light,
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
        title: 'Laker',
      ),
    );
  }
}
