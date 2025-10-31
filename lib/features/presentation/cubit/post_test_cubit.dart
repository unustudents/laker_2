// ============================================================================
// KONVERSI DARI GETX KE CUBIT
// ============================================================================
// Perubahan:
// 1. PostTestController extends GetxController → PostTestCubit extends Cubit
// 2. Rx<T> (reactive) → State management dengan emit()
// 3. readData.bindStream() → loadQuestions() method
// 4. record.obs → state.answers
// 5. funOption() → selectOption()
// 6. funCreateQuis() → createQuiz()
// 7. funDeleteQuis() → deleteQuiz()
// 8. persen() → calculateScore()
// ============================================================================

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'post_test_state.dart';

// TODO: Import Firebase provider (readStream, createQuis, deleteQuis, readQuis)
// import '../../../domain/provider/quis_test.provider.dart';
// TODO: Import model (Quiz)
// import '../../../domain/model/model_model.dart';

class PostTestCubit extends Cubit<PostTestState> {
  PostTestCubit() : super(const PostTestInitial());

  // UID dari argument navigasi
  late String uid;
  // Collection name di Firestore (gunakan di Firebase provider nanti)
  // ignore: unused_field
  static const String _collectionName = "postest";

  /// Initialize dengan uid dari navigasi
  void initialize(String userId) {
    uid = userId;
    loadQuestions();
  }

  /// Load soal dari Firebase Firestore dengan stream
  void loadQuestions() async {
    try {
      emit(const PostTestLoading());

      // TODO: Ganti dengan actual Firebase provider
      // readStream(uid: uid, collection: _collection)
      //   .listen((questions) {
      //     final currentState = state;
      //     if (currentState is PostTestLoaded) {
      //       emit(PostTestLoaded(
      //         questions: questions,
      //         answers: currentState.answers,
      //       ));
      //     } else {
      //       emit(PostTestLoaded(
      //         questions: questions,
      //         answers: {},
      //       ));
      //     }
      //   });

      // Placeholder: hardcoded data untuk testing
      final questions = <Map<String, dynamic>>[];
      emit(PostTestLoaded(questions: questions, answers: {}));
    } catch (e) {
      emit(PostTestError(message: e.toString()));
    }
  }

  /// Handle pemilihan option jawaban
  void selectOption({
    required String quizId,
    required String selectedOption,
    required String correctAnswer,
  }) {
    final currentState = state;
    if (currentState is PostTestLoaded) {
      bool isCorrect = selectedOption == correctAnswer;
      final updatedAnswers = Map<String, dynamic>.from(currentState.answers);
      updatedAnswers[quizId] = {'current': selectedOption, 'status': isCorrect};

      emit(
        PostTestLoaded(
          questions: currentState.questions,
          answers: updatedAnswers,
        ),
      );
    }
  }

  /// Buat soal baru (hanya untuk panitia)
  Future<void> createQuiz({
    required String uid,
    required String question,
    required String correctAnswer,
    required String answer2,
    required String answer3,
    required String answer4,
  }) async {
    try {
      emit(const PostTestCreating());

      // TODO: Ganti dengan actual Firebase provider
      // bool result = await createQuis(
      //   uid: uid,
      //   data: Quiz(
      //     question: question,
      //     options: [correctAnswer, answer2, answer3, answer4],
      //     trueAnswer: correctAnswer,
      //   ),
      //   collection: _collection,
      // );

      // Placeholder: selalu true untuk testing
      bool result = true;

      if (result) {
        // Reload questions setelah berhasil menambah
        loadQuestions();
      }
    } catch (e) {
      emit(PostTestError(message: e.toString()));
    }
  }

  /// Hapus soal
  Future<void> deleteQuiz({required String uid, required String quizId}) async {
    try {
      emit(const PostTestDeleting());

      // TODO: Ganti dengan actual Firebase provider
      // bool result = await deleteQuis(
      //   uid: uid,
      //   idQuis: quizId,
      //   collection: _collection,
      // );

      // Placeholder: selalu true untuk testing
      bool result = true;

      if (result) {
        // Remove dari answers jika ada
        final currentState = state;
        if (currentState is PostTestLoaded) {
          final updatedAnswers = Map<String, dynamic>.from(
            currentState.answers,
          );
          updatedAnswers.remove(quizId);

          // Reload questions setelah berhasil menghapus
          loadQuestions();
        }
      }
    } catch (e) {
      emit(PostTestError(message: e.toString()));
    }
  }

  /// Calculate persentase jawaban benar
  int calculateScore() {
    final currentState = state;
    if (currentState is! PostTestLoaded) return 0;

    if (currentState.questions.isEmpty) return 0;

    int correctAnswers = 0;
    for (var answer in currentState.answers.values) {
      if (answer['status'] == true) {
        correctAnswers++;
      }
    }

    int percentage = ((correctAnswers / currentState.questions.length) * 100)
        .toInt();
    return percentage;
  }

  /// Helper: Cek apakah semua soal sudah dijawab
  bool isAllAnswered() {
    final currentState = state;
    if (currentState is! PostTestLoaded) return false;

    if (currentState.questions.isEmpty) return false;

    return currentState.answers.length == currentState.questions.length;
  }

  /// Helper: Get jumlah soal yang sudah dijawab
  int getAnsweredCount() {
    final currentState = state;
    if (currentState is! PostTestLoaded) return 0;

    return currentState.answers.length;
  }

  /// Helper: Get total soal
  int getTotalQuestions() {
    final currentState = state;
    if (currentState is! PostTestLoaded) return 0;

    return currentState.questions.length;
  }
}
