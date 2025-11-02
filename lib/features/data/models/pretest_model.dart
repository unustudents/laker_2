import 'package:equatable/equatable.dart';

import '../../domain/entities/pretest_entity.dart';

class PretestModel extends Equatable {
  final int id;
  final String soal;
  final int kategori;
  final List<PretestOptionModel> options;

  const PretestModel({
    required this.id,
    required this.soal,
    required this.kategori,
    required this.options,
  });

  factory PretestModel.fromEntity(PretestEntity entity) {
    return PretestModel(
      id: entity.id,
      soal: entity.soal,
      kategori: entity.kategori,
      options: entity.options
          .map((opt) => PretestOptionModel.fromEntity(opt))
          .toList(),
    );
  }

  PretestEntity toEntity() {
    return PretestEntity(
      id: id,
      soal: soal,
      kategori: kategori,
      options: options.map((opt) => opt.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props => [id, soal, kategori, options];
}

class PretestOptionModel extends Equatable {
  final int id;
  final int idPretest;
  final String pilihan;
  final bool isCorrect;
  final String label;

  const PretestOptionModel({
    required this.id,
    required this.idPretest,
    required this.pilihan,
    required this.isCorrect,
    required this.label,
  });

  factory PretestOptionModel.fromJson(Map<String, dynamic> json) {
    return PretestOptionModel(
      id: json['id'] as int? ?? 0,
      idPretest: json['id_pretest'] as int? ?? 0,
      pilihan: json['pilihan'] as String? ?? '',
      isCorrect: json['is_correct'] as bool? ?? false,
      label: json['label'] as String? ?? '',
    );
  }

  factory PretestOptionModel.fromEntity(PretestOptionEntity entity) {
    return PretestOptionModel(
      id: entity.id,
      idPretest: entity.idPretest,
      pilihan: entity.pilihan,
      isCorrect: entity.isCorrect,
      label: entity.label,
    );
  }

  PretestOptionEntity toEntity() {
    return PretestOptionEntity(
      id: id,
      idPretest: idPretest,
      pilihan: pilihan,
      isCorrect: isCorrect,
      label: label,
    );
  }

  @override
  List<Object?> get props => [id, idPretest, pilihan, isCorrect, label];
}
