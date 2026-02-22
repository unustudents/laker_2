import 'package:equatable/equatable.dart';

import '../../domain/entities/profil_entity.dart';

/// Model untuk Profil (Data Layer)
class ProfilModel extends Equatable {
  final String nama;
  final String tempLahir;
  final String divisi;
  final String wa;
  final String email;

  const ProfilModel({
    required this.nama,
    required this.tempLahir,
    required this.divisi,
    required this.wa,
    required this.email,
  });

  /// Convert dari JSON ke ProfilModel
  factory ProfilModel.fromJson(Map<String, dynamic> json) => ProfilModel(
    nama: json['name'] as String,
    tempLahir: json['temp_lahir'] as String,
    divisi: json['divisi'] as String,
    wa: json['wa'] as String,
    email: json['email'] as String,
  );

  /// Convert ProfilModel ke ProfilEntity (Domain Layer)
  ProfilEntity toEntity() => ProfilEntity(
    nama: nama,
    tempLahir: tempLahir,
    divisi: divisi,
    wa: wa,
    email: email,
  );

  /// Convert dari ProfilEntity ke ProfilModel
  factory ProfilModel.fromEntity(ProfilEntity entity) => ProfilModel(
    nama: entity.nama,
    tempLahir: entity.tempLahir,
    divisi: entity.divisi,
    wa: entity.wa,
    email: entity.email,
  );

  @override
  List<Object?> get props => [nama, tempLahir, divisi, wa, email];
}
