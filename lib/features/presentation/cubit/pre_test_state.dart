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

  const PreTestLoaded({required this.soals});

  @override
  List<Object?> get props => [soals];
}

class PreTestError extends PreTestState {
  final String message;

  const PreTestError(this.message);

  @override
  List<Object> get props => [message];
}
