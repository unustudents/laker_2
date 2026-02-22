import 'package:fpdart/fpdart.dart';

import '../../../core/errors/failures.dart';
import '../../domain/entities/profil_entity.dart';
import '../../domain/repositories/profil_repository.dart';
import '../datasources/remote/profil_remote.dart';

class ProfilRepositoryImpl implements ProfilRepository {
  final ProfilRemoteDataSource _remoteDataSource;

  ProfilRepositoryImpl({required ProfilRemoteDataSource remoteDataSource})
    : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, ProfilEntity>> profil() async {
    print(" ProfilRepositoryImpl: Memulai pengambilan data profil");
    print(" DATA = ${await _remoteDataSource.profil()}");
    try {
      final profilModel = await _remoteDataSource.profil();
      return Right(profilModel.toEntity());
    } catch (e) {
      return Left(
        ServerFailure("Gagal mengambil data profil: ${e.toString()}"),
      );
    }
  }
}
