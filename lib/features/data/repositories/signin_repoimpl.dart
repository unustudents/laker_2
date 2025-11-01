import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/repositories/signin_repository.dart';
import '../datasources/remote/signin_remote.dart';

/// Implementasi SigninRepository untuk Firebase Authentication
class SigninRepositoryImpl implements SigninRepository {
  final SigninRemoteDataSource _remoteDataSource;

  SigninRepositoryImpl({required SigninRemoteDataSource remoteDataSource})
    : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, Unit>> signin({
    required String email,
    required String password,
  }) async {
    try {
      await _remoteDataSource.signin(email: email, password: password);
      return Right(unit);
    } on AuthException catch (e) {
      // Handle Supabase Auth exception
      return Left(_handleSupabaseAuthException(e));
    } catch (e) {
      // Handle unexpected error
      return Left(ServerFailure('Sign in gagal: ${e.toString()}'));
    }
  }

  Failure _handleSupabaseAuthException(AuthException e) {
    final message = e.message.toLowerCase();

    // Error: Email tidak ditemukan atau password salah di Supabase
    if (message.contains('invalid login credentials')) {
      return ServerFailure('Email atau password salah');
    }

    // // Error: Email belum diverifikasi oleh user
    // if (message.contains('email not confirmed')) {
    //   return ServerFailure('Email belum diverifikasi');
    // }

    // // Error: Akun sudah terdaftar di Supabase (biasanya untuk signup)
    // if (message.contains('user already exists')) {
    //   return ServerFailure('Email sudah terdaftar');
    // }

    // // Error: Password tidak memenuhi kriteria keamanan minimal
    // if (message.contains('password')) {
    //   return ServerFailure('Password tidak memenuhi kriteria keamanan');
    // }

    // Error tidak dikenali, return failure dengan pesan Supabase
    return ServerFailure('Kesalahan autentikasi Supabase: ${e.message}');
  }
  //   try {
  //     // Call remote datasource untuk sign in
  //     final signinModel = await _remoteDataSource.signin(
  //       email: email,
  //       password: password,
  //     );

  //     // Convert SigninModel ke SigninEntity dan return
  //     return Right(signinModel.toEntity());
  //   } on FirebaseAuthException catch (e) {
  //     // Handle Firebase Auth exception
  //     return Left(_mapFirebaseAuthException(e));
  //   } catch (e) {
  //     // Handle unexpected error
  //     return Left(ServerFailure('Sign in gagal: ${e.toString()}'));
  //   }
  // }

  // /// Map Firebase Auth Exception ke Failure
  // Failure _mapFirebaseAuthException(FirebaseAuthException exception) {
  //   switch (exception.code) {
  //     case 'user-not-found':
  //       return ServerFailure('Email tidak terdaftar');
  //     case 'wrong-password':
  //       return ServerFailure('Password salah');
  //     case 'invalid-email':
  //       return ServerFailure('Email tidak valid');
  //     case 'user-disabled':
  //       return ServerFailure('Akun telah dinonaktifkan');
  //     case 'too-many-requests':
  //       return ServerFailure(
  //         'Terlalu banyak percobaan sign in, coba lagi nanti',
  //       );
  //     case 'operation-not-allowed':
  //       return ServerFailure('Sign in tidak diizinkan');
  //     case 'network-request-failed':
  //       return ConnectionFailure('Jaringan tidak tersedia');
  //     case 'invalid-credential':
  //       return ServerFailure('Email atau password salah');
  //     default:
  //       return ServerFailure(
  //         exception.message ?? 'Sign in gagal, silahkan coba lagi',
  //       );
  //   }
  // }
}
