import 'package:fpdart/fpdart.dart';

import '../../../core/errors/failures.dart';
import '../entities/pretest_entity.dart';
import '../repositories/pretest_repository.dart';

class PretestUseCase {
  final PretestRepository repository;

  PretestUseCase(this.repository);

  Future<Either<Failure, List<PretestEntity>>> call({
    required int idKategori,
  }) async {
    return await repository.readSoal(idKategori: idKategori);
  }
}

class SubmitAnswerUsecase {
  final PretestRepository repository;

  SubmitAnswerUsecase(this.repository);

  Future<Either<Failure, UserAnswerEntity>> call({
    required PretestOptionEntity data,
  }) async {
    return await repository.submitJawabanPretest(data: data);
  }
}
