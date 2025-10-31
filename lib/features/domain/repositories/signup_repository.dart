import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/signup_entity.dart';

abstract class SignupRepository {
  Future<Either<Failure, SignupEntity>> signup({
    required String email,
    required String name,
    required String division,
    required DateTime birthDate,
    required String whatsapp,
    required String password,
  });

  Future<Either<Failure, void>> logout();
  Future<Either<Failure, SignupEntity?>> getCurrentUser();
}
