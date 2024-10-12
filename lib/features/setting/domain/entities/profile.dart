import 'package:equatable/equatable.dart';

class Profile extends Equatable {
  final String email;
  final String name;
  final String namaDivisi;
  final DateTime tanggalLahir;
  final String nomerWhatsapp;

  const Profile({
    required this.email,
    required this.name,
    required this.namaDivisi,
    required this.tanggalLahir,
    required this.nomerWhatsapp,
  });

  @override
  List<Object?> get props => [email, name, namaDivisi, tanggalLahir, nomerWhatsapp];
}
