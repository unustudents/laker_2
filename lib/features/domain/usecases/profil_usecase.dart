import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../entities/profil_entity.dart';
import '../repositories/profil_repository.dart';

class ProfilUsecase {
  final ProfilRepository _repo;

  ProfilUsecase(this._repo);

  Future<Either<Failure, ProfilEntity>> call() async {
    return await _repo.profil();
  }
}
