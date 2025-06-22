import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/auth_entity.dart';
import '../repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository _repository;

  RegisterUseCase(this._repository);

  Future<Either<Failure, UserEntity>> call({required UserEntity params, required String passwd}) async {
    return await _repository.registerUser(
      email: params.email,
      name: params.name,
      division: params.division,
      birthDate: params.birthDate,
      whatsapp: params.whatsapp,
      password: passwd,
    );
  }
}

class LoginUseCase {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  Future<Either<Failure, UserEntity>> call({required String email, required String passwd}) async {
    return await _repository.login(
      email: email,
      password: passwd,
    );
  }
}
