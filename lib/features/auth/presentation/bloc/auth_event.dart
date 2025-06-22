part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthEventSignIn extends AuthEvent {
  final String email;
  final String passwd;

  const AuthEventSignIn(this.email, this.passwd);
  @override
  List<String> get props => [email, passwd];
}

class AuthEventSignUp extends AuthEvent {
  final UserEntity data;
  final String passwd;

  const AuthEventSignUp(this.data, this.passwd);
  @override
  List<Object> get props => [data, passwd];
}
