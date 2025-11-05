import 'package:fpdart/fpdart.dart';

import '../../../core/errors/failures.dart';
import '../../domain/entities/home_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/remote/home_remote.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource _remoteDataSource;

  HomeRepositoryImpl({required HomeRemoteDataSource remoteDataSource})
    : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, HomeEntity>> home() async {
    print(" HomeRepositoryImpl: Memulai pengambilan data home");
    try {
      final homeModel = await _remoteDataSource.home();
      return Right(homeModel.toEntity());
    } catch (e) {
      return Left(ServerFailure("Gagal mengambil data home: ${e.toString()}"));
    }
  }
}
