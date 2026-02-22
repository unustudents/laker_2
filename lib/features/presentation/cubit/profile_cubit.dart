import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:laker_2/features/domain/entities/profil_entity.dart';
import 'package:laker_2/features/domain/usecases/profil_usecase.dart';

import '../../../supabase_config.dart';

part 'profile_state.dart';

/// ProfileCubit - Handles profile management and signout business logic
///
/// This cubit manages user profile data and authentication state.
/// It fetches user info dari Firebase dan handle signout logic.
///
/// States:
/// - [ProfileInitial]: Initial state when cubit is created
/// - [ProfileLoading]: Loading state saat fetch user data
/// - [ProfileLoaded]: Successful fetch dengan user data
/// - [ProfileSigningOut]: Sedang dalam proses signout
/// - [ProfileSignoutSuccess]: Signout berhasil, ready untuk navigate ke login
/// - [ProfileError]: Error ketika fetch data atau signout
class ProfileCubit extends Cubit<ProfileState> {
  // final FirebaseAuth _firebaseAuth;
  final ProfilUsecase _profilUsecase;

  ProfileCubit({required ProfilUsecase profilUsecase})
    : _profilUsecase = profilUsecase,
      super(ProfileInitial()) {
    // Load user profile saat cubit dibuat
    loadUserProfile();
  }

  /// Load user profile data dari Firebase
  ///
  /// Mengambil data user dari FirebaseAuth.instance.currentUser
  /// Emit ProfileLoaded jika berhasil, ProfileError jika gagal
  Future<void> loadUserProfile() async {
    emit(ProfileLoading());
    final result = await _profilUsecase.call();
    result.fold(
      (failure) => emit(ProfileError(failure.msg)),
      (profil) => emit(ProfileLoaded(profil)),
    );
    // try {
    //   emit(ProfileLoading());

    //   final user = _firebaseAuth.currentUser;

    //   if (user != null) {
    //     // Buat map dengan user data
    //     final userData = {
    //       'uid': user.uid,
    //       'nama': user.displayName ?? 'Unknown User',
    //       'email': user.email ?? 'No email',
    //       'photoUrl': user.photoURL,
    //     };

    //     emit(ProfileLoaded(userData));
    //   } else {
    //     emit(const ProfileError('User tidak ditemukan'));
    //   }
    // } catch (e) {
    //   emit(ProfileError('Error loading profile: $e'));
    // }
  }

  /// Sign out user dari Firebase
  ///
  /// Emit ProfileSigningOut saat proses dimulai
  /// Emit ProfileSignoutSuccess jika berhasil
  /// Emit ProfileError jika gagal
  Future<void> signout() async {
    await SupabaseConfig.client.auth.signOut(scope: SignOutScope.global);
    // try {
    //   emit(ProfileSigningOut());

    //   // Sign out dari Firebase
    //   await _firebaseAuth.signOut();

    //   // Emit success state
    //   emit(ProfileSignoutSuccess());
    // } catch (e) {
    //   emit(ProfileError('Error signing out: $e'));
    // }
  }

  /// Update user display name
  ///
  /// Parameters:
  /// - [displayName]: Nama baru untuk user
  Future<void> updateDisplayName(String displayName) async {
    //   try {
    //     emit(ProfileLoading());

    //     final user = _firebaseAuth.currentUser;
    //     if (user != null) {
    //       // Update display name di Firebase
    //       await user.updateDisplayName(displayName);
    //       // Reload user data
    //       await user.reload();

    //       // Load updated profile
    //       await loadUserProfile();
    //     } else {
    //       emit(const ProfileError('User tidak ditemukan'));
    //     }
    //   } catch (e) {
    //     emit(ProfileError('Error updating profile: $e'));
    //   }
  }
}
