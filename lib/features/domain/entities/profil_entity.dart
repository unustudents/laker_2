import 'package:equatable/equatable.dart';

class ProfilEntity extends Equatable {
  final String nama;
  final String tempLahir;
  final String divisi;
  final String wa;
  final String email;

  const ProfilEntity({
    required this.tempLahir,
    required this.nama,
    required this.divisi,
    required this.wa,
    required this.email,
  });

  @override
  List<Object?> get props {
    return [nama, tempLahir, divisi, wa, email];
  }
}
