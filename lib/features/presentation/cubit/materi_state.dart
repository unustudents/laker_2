part of 'materi_cubit.dart';

abstract class MateriState extends Equatable {
  const MateriState();

  @override
  List<Object?> get props => [];
}

class MateriInitial extends MateriState {
  const MateriInitial();
}

class MateriLoading extends MateriState {
  const MateriLoading();
}

class MateriLoaded extends MateriState {
  final Map<String, dynamic> materi;
  final String youtubeId;

  const MateriLoaded({required this.materi, required this.youtubeId});

  @override
  List<Object?> get props => [materi, youtubeId];
}

class MateriCreating extends MateriState {
  const MateriCreating();
}

class MateriUpdating extends MateriState {
  const MateriUpdating();
}

class MateriError extends MateriState {
  final String message;

  const MateriError({required this.message});

  @override
  List<Object?> get props => [message];
}
