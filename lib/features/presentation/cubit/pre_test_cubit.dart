import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'pre_test_state.dart';

/// PreTestCubit - Handles pre-test quiz management and state
///
/// Manages loading quiz questions, handling user answers, creating/deleting quizzes
/// Methods:
/// - loadQuestions(uid, collection) - Load quiz questions from Firebase
/// - selectOption(uid, option, correctAnswer) - Handle user's quiz answer
/// - createQuiz(...) - Add new quiz question
/// - deleteQuiz(uid, quizId) - Delete quiz question
/// - calculateScore() - Calculate percentage score
class PreTestCubit extends Cubit<PreTestState> {
  // DataProvider atau service untuk Firebase operations
  // Assume sudah ada provider: readStream, createQuis, deleteQuis

  PreTestCubit() : super(PreTestInitial());

  /// Load questions dari Firebase stream
  /// [uid] - User ID
  /// [collection] - Firebase collection name
  Future<void> loadQuestions({
    required String uid,
    required String collection,
  }) async {
    try {
      emit(PreTestLoading());

      // TODO: Replace dengan actual readStream dari provider
      // var questionsStream = readStream(uid: uid, collection: collection);
      // questionsStream.listen((data) {
      //   emit(PreTestLoaded(
      //     questions: data,
      //     answers: {},
      //   ));
      // });

      // Placeholder - akan diganti dengan stream implementation
      emit(PreTestLoaded(questions: [], answers: {}));
    } catch (e) {
      emit(PreTestError('Error loading questions: $e'));
    }
  }

  /// Handle user's option selection
  /// [quizId] - Question ID
  /// [selectedOption] - User's selected answer
  /// [correctAnswer] - Correct answer
  void selectOption({
    required String quizId,
    required String selectedOption,
    required String correctAnswer,
  }) {
    if (state is PreTestLoaded) {
      final currentState = state as PreTestLoaded;
      final updatedAnswers = Map<String, dynamic>.from(currentState.answers);

      bool isCorrect = selectedOption == correctAnswer;
      updatedAnswers[quizId] = {'current': selectedOption, 'status': isCorrect};

      emit(
        PreTestLoaded(
          questions: currentState.questions,
          answers: updatedAnswers,
        ),
      );
    }
  }

  /// Create new quiz question
  Future<bool> createQuiz({
    required String uid,
    required String question,
    required String correctAnswer,
    required String answer2,
    required String answer3,
    required String answer4,
    required String collection,
  }) async {
    try {
      emit(PreTestCreating());

      // Validate unique answers
      if (!_validateUniqueAnswers(correctAnswer, answer2, answer3, answer4)) {
        emit(PreTestError('Setiap jawaban harus unik'));
        if (state is! PreTestLoaded) {
          emit(PreTestLoaded(questions: [], answers: {}));
        }
        return false;
      }

      // TODO: Replace dengan actual createQuis dari provider
      // bool result = await createQuis(
      //   uid: uid,
      //   data: Quiz(
      //     question: question,
      //     options: [correctAnswer, answer2, answer3, answer4],
      //     trueAnswer: correctAnswer,
      //   ),
      //   collection: collection,
      // );

      // Placeholder - will return success
      bool result = true;

      if (result) {
        // Reload questions setelah create berhasil
        await loadQuestions(uid: uid, collection: collection);
      }
      return result;
    } catch (e) {
      emit(PreTestError('Error creating quiz: $e'));
      return false;
    }
  }

  /// Delete quiz question
  Future<bool> deleteQuiz({
    required String uid,
    required String quizId,
    required String collection,
  }) async {
    try {
      emit(PreTestDeleting());

      // TODO: Replace dengan actual deleteQuis dari provider
      // bool result = await deleteQuis(
      //   uid: uid,
      //   idQuis: quizId,
      //   collection: collection,
      // );

      // Placeholder - will return success
      bool result = true;

      if (result) {
        // Reload questions setelah delete berhasil
        await loadQuestions(uid: uid, collection: collection);
      }
      return result;
    } catch (e) {
      emit(PreTestError('Error deleting quiz: $e'));
      return false;
    }
  }

  /// Calculate score percentage
  int calculateScore() {
    if (state is PreTestLoaded) {
      final currentState = state as PreTestLoaded;
      int correctCount = 0;

      for (var answer in currentState.answers.values) {
        if (answer['status'] == true) {
          correctCount++;
        }
      }

      if (currentState.answers.isEmpty) return 0;
      return ((correctCount / currentState.answers.length) * 100).toInt();
    }
    return 0;
  }

  /// Validate all answers are unique
  bool _validateUniqueAnswers(
    String answer1,
    String answer2,
    String answer3,
    String answer4,
  ) {
    return !(answer1 == answer2 ||
        answer1 == answer3 ||
        answer1 == answer4 ||
        answer2 == answer3 ||
        answer2 == answer4 ||
        answer3 == answer4);
  }

  /// Check if all questions answered
  bool isAllAnswered() {
    if (state is PreTestLoaded) {
      final currentState = state as PreTestLoaded;
      return currentState.answers.length == currentState.questions.length;
    }
    return false;
  }

  /// Get answered count
  int getAnsweredCount() {
    if (state is PreTestLoaded) {
      final currentState = state as PreTestLoaded;
      return currentState.answers.length;
    }
    return 0;
  }

  /// Get total questions count
  int getTotalQuestions() {
    if (state is PreTestLoaded) {
      final currentState = state as PreTestLoaded;
      return currentState.questions.length;
    }
    return 0;
  }
}
