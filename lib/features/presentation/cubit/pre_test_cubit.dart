import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/pretest_entity.dart';
import '../../domain/usecases/pretest_usecase.dart';

part 'pre_test_state.dart';

class PreTestCubit extends Cubit<PreTestState> {
  final PretestUseCase _readSoalUseCase;

  PreTestCubit({
    required PretestUseCase readSoalUseCase,
    required int idKategori,
  })  : _readSoalUseCase = readSoalUseCase,
        super(const PreTestInitial()) {
    readSoal(idKategori: idKategori);
  }

  Future<void> readSoal({required int idKategori}) async {
    emit(const PreTestLoading());

    final result = await _readSoalUseCase(idKategori: idKategori);

    result.fold(
      (failure) => emit(PreTestError(failure.msg)),
      (soals) => emit(PreTestLoaded(soals: soals)),
    );
  }
}
