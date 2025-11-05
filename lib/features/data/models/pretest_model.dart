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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_pretest': idPretest,
      'pilihan': pilihan,
      'is_correct': isCorrect,
      'label': label,
    };
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

class UserAnswerModel extends Equatable {
  // final String? id;
  final String idUser;
  final int idPretest;
  final String option;
  final bool isCorrect;

  const UserAnswerModel({
    // this.id,
    required this.idUser,
    required this.idPretest,
    required this.option,
    required this.isCorrect,
  });

  factory UserAnswerModel.fromJson(Map<String, dynamic> json) {
    return UserAnswerModel(
      // id: json['id'] as String?,
      idUser: json['id_user'] as String? ?? '',
      idPretest: json['id_pretest'] as int? ?? 0,
      option: json['option'] as String? ?? '',
      isCorrect: json['is_correct'] as bool? ?? false,
    );
  }

  // TODO: Aktifkan jika perlu
  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'id_user': idUser,
  //     'id_pretest': idPretest,
  //     'option': option,
  //     'is_correct': isCorrect,
  //   };
  // }

  factory UserAnswerModel.fromEntity(UserAnswerEntity entity) {
    return UserAnswerModel(
      // id: entity.id,
      idUser: entity.idUser,
      idPretest: entity.idPretest,
      option: entity.option,
      isCorrect: entity.isCorrect,
    );
  }

  UserAnswerEntity toEntity() {
    return UserAnswerEntity(
      // id: id,
      idUser: idUser,
      idPretest: idPretest,
      option: option,
      isCorrect: isCorrect,
    );
  }

  @override
  List<Object?> get props => [idUser, idPretest, option, isCorrect];
}
