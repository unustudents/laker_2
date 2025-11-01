import 'package:equatable/equatable.dart';

class SignupEntity extends Equatable {
  final String email;
  final String name;
  final String divisi;
  final String tempLahir;
  final String wa;
  final String password;

  const SignupEntity({
    required this.email,
    required this.name,
    required this.divisi,
    required this.tempLahir,
    required this.wa,
    required this.password,
  });

  @override
  List<Object> get props {
    return [email, name, divisi, tempLahir, wa, password];
  }
}
