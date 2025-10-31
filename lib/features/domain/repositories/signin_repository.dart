import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/signin_entity.dart';

abstract class SignRepository {
  Future<Either<Failure, SigninEntity>> signin({
    required String email,
    required String password,
  });

  Future<Either<Failure, SigninEntity>> registerUser({
    required String email,
    required String name,
    required String division,
    required DateTime birthDate,
    required String whatsapp,
    required String password,
  });

  Future<Either<Failure, void>> logout();
  Future<Either<Failure, SigninEntity?>> getCurrentUser();
}
