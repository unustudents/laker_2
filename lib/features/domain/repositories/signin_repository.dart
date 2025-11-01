import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';

abstract class SigninRepository {
  Future<Either<Failure, Unit>> signin({
    required String email,
    required String password,
  });
}
