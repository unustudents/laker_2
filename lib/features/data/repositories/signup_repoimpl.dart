import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:supabase/supabase.dart';

import '../../../core/errors/failures.dart';
import '../../domain/entities/signup_entity.dart';
import '../../domain/repositories/signup_repository.dart';
import '../datasources/remote/signup_remote.dart';
import '../models/signup_model.dart';

class SignupRepositoryImpl implements SignupRepository {
  final SignupRemoteDataSource _remoteDataSource;

  const SignupRepositoryImpl({required SignupRemoteDataSource remoteDataSource})
    : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, AuthResponse>> signup(SignupEntity data) async {
    try {
      final authResponse = await _remoteDataSource.signup(
        SignupModel.fromEntity(data),
      );

      // 3. Validate response
      final user = authResponse.user;
      if (user == null) {
        return Left(ServerFailure('Pendaftaran gagal. Silakan coba lagi.'));
      }

      return Right(authResponse);
    } on AuthException catch (e) {
      return Left(ServerFailure('Pendaftaran gagal: ${e.message}'));
    } on PostgrestException {
      return Left(ServerFailure('Server error'));
    } on SocketException {
      return Left(
        ServerFailure('Masalah koneksi, tolong periksa jaringan Anda.'),
      );
    } catch (e) {
      return Left(ServerFailure('Pendaftaran gagal: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, SignupEntity?>> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }
}
