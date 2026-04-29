import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/pretest_entity.dart';
import '../../domain/usecases/pretest_usecase.dart';

part 'pre_test_state.dart';

class PreTestCubit extends Cubit<PreTestState> {
  final PretestUseCase _readSoalUseCase;
  final SubmitAnswerUsecase _submitAnswerUseCase;

  PreTestCubit({
    required PretestUseCase readSoalUseCase,
    required SubmitAnswerUsecase submitAnswerUseCase,
    required int idKategori,
  }) : _readSoalUseCase = readSoalUseCase,
       _submitAnswerUseCase = submitAnswerUseCase,
       super(const PreTestInitial()) {
    readSoal(idKategori: idKategori);
  }

  Future<void> readSoal({required int idKategori}) async {
    emit(const PreTestLoading());

    final result = await _readSoalUseCase(idKategori: idKategori);

    result.fold(
      (failure) => emit(PreTestError(failure.msg)),
      (soals) =>
          emit(PreTestLoaded(soals: soals, currentIndex: 0, userAnswers: {}, record: {})),
    );
  }

  Future<void> submitJawabanPretest({required PretestOptionEntity data}) async {
    final currentState = state;
    if (currentState is! PreTestLoaded) return;

    final updatedAnswer = Map<int, String>.from(currentState.userAnswers);
    updatedAnswer[currentState.currentIndex] = data.label;

    final updatedRecord = Map<int, Map<String, dynamic>>.from(currentState.record);
    updatedRecord[currentState.currentIndex] = {'current': data.label, 'status': data.isCorrect};

    // Emit state agar UI langsung terupdate secara lokal (optimistic update)
    emit(
      PreTestLoaded(
        soals: currentState.soals,
        currentIndex: currentState.currentIndex,
        userAnswers: updatedAnswer,
        record: updatedRecord,
      ),
    );

    final result = await _submitAnswerUseCase(data: data);

    result.fold(
      (failure) => emit(PreTestError(failure.msg)),
      (userAnswer) {
        // Jika sukses, biarkan state karena sudah terupdate secara optimis di atas
        // atau Anda bisa melakukan emit ulang bila diperlukan.
      },
    );
  }

  int hitungJawabanBenar() {
    final currentState = state;
    if (currentState is! PreTestLoaded) return 0;

    int jawabanBenar = 0;
    for (var value in currentState.record.values) {
      if (value['status'] == true) {
        jawabanBenar++;
      }
    }
    return jawabanBenar;
  }
}
