import 'package:fpdart/fpdart.dart';
import 'package:laker_2/features/data/models/pretest_model.dart';

import '../../../core/errors/failures.dart';
import '../../domain/entities/pretest_entity.dart';
import '../../domain/repositories/pretest_repository.dart';
import '../datasources/remote/pretest_remote.dart';

class PretestRepositoryImpl implements PretestRepository {
  final PretestRemoteDataSource _remoteDataSource;

  PretestRepositoryImpl({required PretestRemoteDataSource remoteDataSource})
    : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, List<PretestEntity>>> readSoal({
    required int idKategori,
  }) async {
    try {
      final models = await _remoteDataSource.readSoal(idKategori: idKategori);
      final entities = models.map((model) => model.toEntity()).toList();
      return Right(entities);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserAnswerEntity>> submitJawabanPretest({
    required PretestOptionEntity data,
  }) async {
    try {
      final answerModel = await _remoteDataSource.submitAnswer(
        data: PretestOptionModel.fromEntity(data),
      );
      final resultEntity = answerModel.toEntity();
      return Right(resultEntity);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
