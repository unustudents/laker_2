import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
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
    try {
      // Emit loading state untuk menunjukkan splash screen sedang loading
      emit(SplashLoading());

      // Set immersive UI mode (fullscreen tanpa status bar dan navigation bar)
      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

      // Delay selama 3 detik untuk menampilkan splash screen dengan baik
      await Future.delayed(const Duration(seconds: 3));

      // Cek session Supabase untuk user yang sudah authenticated
      final session = _supabaseClient.auth.currentSession;

      // Jika ada session, user sudah login (session.user pasti not null)
      if (session != null) {
        // Navigate ke Home screen
        emit(SplashNavigateToHome());
      } else {
        // Tidak ada session, user harus login
        emit(SplashNavigateToSignIn());
      }
    } catch (e) {
      // Tangani error saat initialize splash
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
