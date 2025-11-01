import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/errors/failures.dart';
import '../entities/signup_entity.dart';
import '../repositories/signup_repository.dart';

class SignupUsecase {
  final SignupRepository _repository;

  SignupUsecase(this._repository);

  Future<Either<Failure, AuthResponse>> call(SignupEntity data) async {
    return await _repository.signup(data);
  }
}
