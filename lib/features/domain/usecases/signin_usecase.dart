import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/signin_repository.dart';

class SigninUsecase {
  final SigninRepository _repository;

  SigninUsecase(this._repository);

  Future<Either<Failure, Unit>> call({
    required String email,
    required String passwd,
  }) async {
    return await _repository.signin(email: email, password: passwd);
  }
}
