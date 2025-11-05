part of 'pre_test_cubit.dart';

abstract class PreTestState extends Equatable {
  const PreTestState();

  @override
  List<Object?> get props => [];
}

class PreTestInitial extends PreTestState {
  const PreTestInitial();
}

class PreTestLoading extends PreTestState {
  const PreTestLoading();
}

class PreTestLoaded extends PreTestState {
  final List<PretestEntity> soals;
  final int currentIndex;
  final Map<int, String> userAnswers;

  const PreTestLoaded({
    required this.soals,
    required this.currentIndex,
    required this.userAnswers,
  });

  @override
  List<Object?> get props => [soals];
}

class PreTestError extends PreTestState {
  final String message;

  const PreTestError(this.message);

  @override
  List<Object> get props => [message];
}

class PreTestSubmit extends PreTestState {}
