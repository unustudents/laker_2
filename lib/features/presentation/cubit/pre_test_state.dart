part of 'pre_test_cubit.dart';

/// Abstract base class for all PreTestCubit states
abstract class PreTestState extends Equatable {
  const PreTestState();

  @override
  List<Object?> get props => [];
}

/// Initial state when PreTestCubit is created
class PreTestInitial extends PreTestState {
  const PreTestInitial();
}

/// Loading state saat fetch questions dari Firebase
class PreTestLoading extends PreTestState {
  const PreTestLoading();
}

/// Loaded state dengan semua questions dan user answers
class PreTestLoaded extends PreTestState {
  final List<Map<String, dynamic>> questions;
  final Map<String, dynamic> answers;

  const PreTestLoaded({required this.questions, required this.answers});

  @override
  List<Object?> get props => [questions, answers];
}

/// State saat creating (menambah) quiz baru
class PreTestCreating extends PreTestState {
  const PreTestCreating();
}

/// State saat deleting quiz
class PreTestDeleting extends PreTestState {
  const PreTestDeleting();
}

/// Error state dengan error message
class PreTestError extends PreTestState {
  final String message;

  const PreTestError(this.message);

  @override
  List<Object> get props => [message];
}
