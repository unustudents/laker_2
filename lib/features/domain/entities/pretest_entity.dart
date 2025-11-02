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
