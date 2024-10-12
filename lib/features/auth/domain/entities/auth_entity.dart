import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String email;
  final String name;
  final String division;
  final DateTime birthDate;
  final String whatsapp;
  final String password;

  const UserEntity(
      {required this.email, required this.name, required this.division, required this.birthDate, required this.whatsapp, required this.password});

  @override
  List<Object> get props {
    return [email, name, division, birthDate, whatsapp, password];
  }
}
