import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String email;
  final String name;
  final String division;
  final DateTime birthDate;
  final String whatsapp;

  const UserEntity({required this.email, required this.name, required this.division, required this.birthDate, required this.whatsapp});

  @override
  List<Object> get props {
    return [email, name, division, birthDate, whatsapp];
  }
}
