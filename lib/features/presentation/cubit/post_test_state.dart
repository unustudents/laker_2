part of 'post_test_cubit.dart';

abstract class PostTestState extends Equatable {
  const PostTestState();

  @override
  List<Object?> get props => [];
}

class PostTestInitial extends PostTestState {
  const PostTestInitial();
}

class PostTestLoading extends PostTestState {
  const PostTestLoading();
}

class PostTestLoaded extends PostTestState {
  final List<Map<String, dynamic>> questions;
  final Map<String, dynamic> answers;

  const PostTestLoaded({required this.questions, required this.answers});

  @override
  List<Object?> get props => [questions, answers];
}

class PostTestCreating extends PostTestState {
  const PostTestCreating();
}

class PostTestDeleting extends PostTestState {
  const PostTestDeleting();
}

class PostTestError extends PostTestState {
  final String message;

  const PostTestError({required this.message});

  @override
  List<Object?> get props => [message];
}
