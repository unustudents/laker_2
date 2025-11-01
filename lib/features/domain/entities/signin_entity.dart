import 'package:equatable/equatable.dart';

class SigninEntity extends Equatable {
  final String email;
  final String name;

  const SigninEntity({required this.email, required this.name});

  @override
  List<Object> get props {
    return [email, name];
  }
}
