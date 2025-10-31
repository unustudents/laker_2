import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/signin_entity.dart';
import '../repositories/signin_repository.dart';

// class RegisterUseCase {
//   final AuthRepository _repository;

//   RegisterUseCase(this._repository);

//   Future<Either<Failure, UserEntity>> call({required UserEntity params, required String passwd}) async {
//     return await _repository.registerUser(
//       email: params.email,
//       name: params.name,
//       division: params.division,
//       birthDate: params.birthDate,
//       whatsapp: params.whatsapp,
//       password: passwd,
//     );
//   }
// }

class SigninUsecase {
  final SignRepository _repository;

  SigninUsecase(this._repository);

  Future<Either<Failure, SigninEntity>> call({
    required String email,
    required String passwd,
  }) async {
    return await _repository.signin(email: email, password: passwd);
  }
}
