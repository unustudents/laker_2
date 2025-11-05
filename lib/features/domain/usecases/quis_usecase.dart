import 'package:fpdart/fpdart.dart';

import '../../../core/errors/failures.dart';
import '../entities/quis_entity.dart';
import '../repositories/quis_repository.dart';

class QuisUseCase {
  final QuisRepository repository;

  QuisUseCase(this.repository);

  Future<Either<Failure, List<QuisEntity>>> call({
    required String uid,
    required String collection,
  }) async {
    return await repository.getQuizzes(uid: uid, collection: collection);
  }
}
