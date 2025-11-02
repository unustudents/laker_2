import 'package:fpdart/fpdart.dart';

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
}
