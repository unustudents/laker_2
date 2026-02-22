import 'dart:io' show Platform;

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  /// Instance Supabase client untuk cek session user
  final SupabaseClient _supabaseClient;

  /// Constructor yang menerima [SupabaseClient] untuk operasi autentikasi
  SplashCubit({SupabaseClient? supabaseClient})
    : _supabaseClient = supabaseClient ?? Supabase.instance.client,
      super(SplashInitial());

  /// Initialize splash screen and handle authentication routing
  Future<void> initializeSplash() async {
    // Pengecekan platform tetap di awal, tapi tidak perlu return agar
    // platform lain tetap bisa lanjut ke Supabase check.

    try {
      // 1. Emit loading dan atur UI
      emit(SplashLoading());
      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

      // 2. Blok khusus In-App Update (Try-Catch Terpisah)
      if (Platform.isAndroid) {
        try {
          final updateInfo = await InAppUpdate.checkForUpdate();

          if (updateInfo.updateAvailability ==
              UpdateAvailability.updateAvailable) {
            emit(SplashUpdateStatus(UpdateStatus.available));

            // Jalankan startFlexibleUpdate TANPA await agar tidak memblokir splash screen.
            // Download berjalan di background.
            InAppUpdate.startFlexibleUpdate()
                .then((_) {
                  // Akan terpicu setelah download selesai
                  emit(SplashUpdateStatus(UpdateStatus.downloaded));
                  InAppUpdate.completeFlexibleUpdate();
                })
                .catchError((e) {
                  // Abaikan jika user cancel update
                  print("Flexible update dibatalkan atau error: $e");
                });
          } else {
            emit(SplashUpdateStatus(UpdateStatus.notAvailable));
          }
        } catch (e) {
          // ERROR UPDATE DITANGKAP DI SINI
          // Biasa terjadi saat run di Emulator/Debug karena tidak ada Play Store
          // Eksekusi kode TIDAK AKAN lompat ke catch utama
          print('In-App Update error (Bisa diabaikan jika mode Debug): $e');
          emit(SplashUpdateStatus(UpdateStatus.notAvailable));
        }
      }

      // 3. Delay untuk estetika Splash Screen
      await Future.delayed(const Duration(seconds: 3));

      // 4. Lanjut ke pengecekan Session Supabase
      final session = _supabaseClient.auth.currentSession;

      if (session != null) {
        emit(SplashNavigateToHome());
      } else {
        emit(SplashNavigateToSignIn());
      }
    } catch (e) {
      // Tangani error krusial (seperti error dari Supabase)
      emit(SplashError('Kesalahan saat initialize splash: ${e.toString()}'));
    }
  }

  /// Restore system UI when splash is dismissed
  Future<void> onSplashClose() async {
    await SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
  }

  @override
  Future<void> close() async {
    await onSplashClose();
    return super.close();
  }
}
