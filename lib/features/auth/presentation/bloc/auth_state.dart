part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthStateEmpty extends AuthState {}

class AuthStateError extends AuthState {
  final String msg;

  const AuthStateError(this.msg);
  @override
  List<String> get props => [msg];
}

class AuthStateLoading extends AuthState {}

class AuthStateSuccess extends AuthState {}
