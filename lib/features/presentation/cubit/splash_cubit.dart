import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final FirebaseAuth _firebaseAuth;

  SplashCubit({FirebaseAuth? firebaseAuth})
    : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
      super(SplashInitial());

  /// Initialize splash screen and handle authentication routing
  Future<void> initializeSplash() async {
    try {
      emit(SplashLoading());

      // Set immersive UI mode (fullscreen without status bar)
      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

      // Listen to Firebase auth state changes
      _firebaseAuth.authStateChanges().listen((User? user) {
        // Delay navigation untuk menunjukkan splash screen
        Future.delayed(const Duration(seconds: 3), () {
          if (user != null && user.emailVerified) {
            emit(SplashNavigateToHome());
          } else {
            emit(SplashNavigateToSignIn());
          }
        });
      });
    } catch (e) {
      emit(SplashError(e.toString()));
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
