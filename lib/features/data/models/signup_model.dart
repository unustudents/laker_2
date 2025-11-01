import 'package:equatable/equatable.dart';

import '../../domain/entities/signup_entity.dart';

/// Model untuk Sign Up (Data Layer)
class SignupModel extends Equatable {
  final String email;
  final String name;
  final String divisi;
  final String tempLahir;
  final String wa;
  final String password;

  const SignupModel({
    required this.email,
    required this.name,
    required this.divisi,
    required this.tempLahir,
    required this.wa,
    required this.password,
  });

  /// Convert SignupModel ke SignupEntity (Domain Layer)
  SignupEntity toEntity() => SignupEntity(
    email: email,
    name: name,
    divisi: divisi,
    tempLahir: tempLahir,
    wa: wa,
    password: password,
  );

  /// Convert dari SignupEntity ke SignupModel
  factory SignupModel.fromEntity(SignupEntity entity) => SignupModel(
    email: entity.email,
    name: entity.name,
    divisi: entity.divisi,
    tempLahir: entity.tempLahir,
    wa: entity.wa,
    password: entity.password,
  );

  @override
  List<Object> get props => [email, name, divisi, tempLahir, wa, password];
}
