import 'package:equatable/equatable.dart';

class PretestEntity extends Equatable {
  final int id;
  final String soal;
  final int kategori;
  final List<PretestOptionEntity> options;

  const PretestEntity({
    required this.id,
    required this.soal,
    required this.kategori,
    required this.options,
  });

  @override
  List<Object?> get props => [id, soal, kategori, options];
}

class PretestOptionEntity extends Equatable {
  final int id;
  final int idPretest;
  final String pilihan;
  final bool isCorrect;
  final String label;

  const PretestOptionEntity({
    required this.id,
    required this.idPretest,
    required this.pilihan,
    required this.isCorrect,
    required this.label,
  });

  @override
  List<Object?> get props => [id, idPretest, pilihan, isCorrect, label];
}

class UserAnswerEntity extends Equatable {
  final String? id;
  final String idUser;
  final int idPretest;
  final String option;
  final bool isCorrect;

  const UserAnswerEntity({
    this.id,
    required this.idUser,
    required this.idPretest,
    required this.option,
    required this.isCorrect,
  });

  @override
  List<Object?> get props => [id, idUser, idPretest, option, isCorrect];
}
