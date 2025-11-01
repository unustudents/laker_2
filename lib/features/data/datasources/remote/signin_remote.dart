import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/errors/failures.dart' show ServerFailure;

/// Remote datasource untuk Firebase Sign In
abstract class SigninRemoteDataSource {
  Future<void> signin({required String email, required String password});
}
//   /// Sign in dengan email dan password
//   ///
//   /// Returns [SigninModel] dengan email dan name dari Firebase
//   /// Throws [FirebaseAuthException] jika gagal sign in
//   Future<SigninModel> signin({required String email, required String password});

//   /// Sign out dari akun Firebase
//   ///
//   /// Throws [FirebaseAuthException] jika gagal sign out
//   Future<void> signout();

//   /// Get current user dari Firebase
//   ///
//   /// Returns [SigninModel] jika ada user yang login, null jika tidak
//   SigninModel? getCurrentUser();
// }

// /// Implementasi Firebase Sign In Remote DataSource
// class SigninRemoteDataSourceImpl implements SigninRemoteDataSource {
//   final FirebaseAuth _firebaseAuth;

//   SigninRemoteDataSourceImpl({required FirebaseAuth firebaseAuth})
//     : _firebaseAuth = firebaseAuth;

//   @override
//   Future<SigninModel> signin({
//     required String email,
//     required String password,
//   }) async {
//     try {
//       final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );

//       final user = userCredential.user;
//       if (user == null) {
//         throw FirebaseAuthException(
//           code: 'user-not-found',
//           message: 'User tidak ditemukan setelah sign in',
//         );
//       }

//       return SigninModel(
//         email: user.email ?? '',
//         name: user.displayName ?? '',
//         uid: user.uid,
//       );
//     } on FirebaseAuthException catch (e) {
//       throw _handleFirebaseAuthException(e);
//     }
//   }

//   @override
//   Future<void> signout() async {
//     try {
//       await _firebaseAuth.signOut();
//     } on FirebaseAuthException catch (e) {
//       throw _handleFirebaseAuthException(e);
//     }
//   }

//   @override
//   SigninModel? getCurrentUser() {
//     final user = _firebaseAuth.currentUser;
//     if (user == null) return null;

//     return SigninModel(
//       email: user.email ?? '',
//       name: user.displayName ?? '',
//       uid: user.uid,
//     );
//   }

//   /// Handle Firebase Auth Exception dan convert ke pesan user-friendly
//   FirebaseAuthException _handleFirebaseAuthException(FirebaseAuthException e) {
//     switch (e.code) {
//       case 'user-not-found':
//         return FirebaseAuthException(
//           code: 'user-not-found',
//           message: 'Email tidak terdaftar',
//         );
//       case 'wrong-password':
//         return FirebaseAuthException(
//           code: 'wrong-password',
//           message: 'Password salah',
//         );
//       case 'invalid-email':
//         return FirebaseAuthException(
//           code: 'invalid-email',
//           message: 'Email tidak valid',
//         );
//       case 'user-disabled':
//         return FirebaseAuthException(
//           code: 'user-disabled',
//           message: 'Akun telah dinonaktifkan',
//         );
//       case 'too-many-requests':
//         return FirebaseAuthException(
//           code: 'too-many-requests',
//           message: 'Terlalu banyak percobaan sign in, coba lagi nanti',
//         );
//       case 'operation-not-allowed':
//         return FirebaseAuthException(
//           code: 'operation-not-allowed',
//           message: 'Sign in tidak diizinkan',
//         );
//       case 'network-request-failed':
//         return FirebaseAuthException(
//           code: 'network-request-failed',
//           message: 'Jaringan tidak tersedia',
//         );
//       default:
//         return e;
//     }
//   }
// }

class SigninRemoteDataSourceImpl implements SigninRemoteDataSource {
  /// Dapatkan instance Supabase client untuk operasi autentikasi
  final SupabaseClient _supabaseClient;

  SigninRemoteDataSourceImpl({required SupabaseClient supabaseClient})
    : _supabaseClient = supabaseClient;

  @override
  Future<void> signin({required String email, required String password}) async {
    final response = await _supabaseClient.auth.signInWithPassword(
      email: email,
      password: password,
    );

    if (response.user == null) {
      throw ServerFailure('Gagal masuk');
    }
  }

  /// Handle Supabase Auth Exception dan convert ke pesan user-friendly
}
