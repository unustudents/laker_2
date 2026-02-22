import 'package:equatable/equatable.dart';

abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => [];
}

class SplashInitial extends SplashState {}

class SplashLoading extends SplashState {}

class SplashNavigateToSignIn extends SplashState {}

class SplashNavigateToHome extends SplashState {}

class SplashUpdateStatus extends SplashState {
  final UpdateStatus updateStatus;

  const SplashUpdateStatus(this.updateStatus);

  @override
  List<Object> get props => [updateStatus];
}

class SplashError extends SplashState {
  final String message;

  const SplashError(this.message);

  @override
  List<Object> get props => [message];
}

enum UpdateStatus {
  checking,
  available,
  notAvailable,
  downloaded,
}