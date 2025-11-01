import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../supabase_config.dart';
import '../entities/signup_entity.dart';

abstract class SignupRepository {
  Future<Either<Failure, AuthResponse>> signup(SignupEntity data);

  // TODO: Delete unused methods later
  Future<Either<Failure, SignupEntity?>> getCurrentUser();
}
