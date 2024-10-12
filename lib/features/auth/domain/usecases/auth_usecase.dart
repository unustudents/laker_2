import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/auth_entity.dart';
import '../repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository _repository;

  RegisterUseCase(this._repository);

  Future<Either<Failure, UserEntity>> call(UserEntity params) async {
    return await _repository.registerUser(
      email: params.email,
      name: params.name,
      division: params.division,
      birthDate: params.birthDate,
      whatsapp: params.whatsapp,
      password: params.password,
    );
  }
}

class LoginUseCase {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  Future<Either<Failure, UserEntity>> call(UserEntity params) async {
    return await _repository.login(
      email: params.email,
      password: params.password,
    );
  }
}
