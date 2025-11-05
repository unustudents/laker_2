import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../entities/home_entity.dart';
import '../repositories/home_repository.dart';

class HomeUsecase {
  final HomeRepository _repo;

  HomeUsecase(this._repo);

  Future<Either<Failure, HomeEntity>> call() async {
    return await _repo.home();
  }
}
