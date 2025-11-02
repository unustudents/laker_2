import 'package:fpdart/fpdart.dart';

import '../../../core/errors/failures.dart';
import '../entities/pretest_entity.dart';

abstract class PretestRepository {
  Future<Either<Failure, List<PretestEntity>>> readSoal({
    required int idKategori,
  });
}
