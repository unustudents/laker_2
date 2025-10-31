import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/signup_entity.dart';
import '../repositories/signup_repository.dart';

class SignupUsecase {
  final SignupRepository _repository;

  SignupUsecase(this._repository);

  Future<Either<Failure, SignupEntity>> call({
    required String email,
    required String name,
    required String division,
    required DateTime birthDate,
    required String whatsapp,
    required String password,
  }) async {
    return await _repository.signup(
      email: email,
      name: name,
      division: division,
      birthDate: birthDate,
      whatsapp: whatsapp,
      password: password,
    );
  }
}
