import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../entities/profil_entity.dart';

abstract class ProfilRepository {
  Future<Either<Failure, ProfilEntity>> profil();
  Future<Either<Failure, ProfilEntity>> updateProfil({
    required String nama,
    required String tempLahir,
    required String divisi,
    required String wa,
  });
}
