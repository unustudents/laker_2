import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../entities/profil_entity.dart';
import '../repositories/profil_repository.dart';

class UpdateProfilUsecase {
  final ProfilRepository _repo;

  UpdateProfilUsecase(this._repo);

  Future<Either<Failure, ProfilEntity>> call({
    required String nama,
    required String tempLahir,
    required String divisi,
    required String wa,
  }) async {
    return await _repo.updateProfil(
      nama: nama,
      tempLahir: tempLahir,
      divisi: divisi,
      wa: wa,
    );
  }
}
