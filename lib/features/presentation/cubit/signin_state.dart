part of 'signin_cubit.dart';

/// Abstract base class for all SigninCubit states
abstract class SigninState extends Equatable {
  const SigninState();

  @override
  List<Object> get props => [];
}

/// Initial state when SigninCubit is first created
class SigninInitial extends SigninState {
  const SigninInitial();
}

/// Loading state during sign-in process
class SigninLoading extends SigninState {
  const SigninLoading();
}

/// Successful sign-in state with user information
class SigninSuccess extends SigninState {
  const SigninSuccess();
}

/// Error state when sign-in fails
class SigninError extends SigninState {
  final String message;

  const SigninError(this.message);

  @override
  List<Object> get props => [message];
}
