import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/usecases/signin_usecase.dart';

part 'signin_state.dart';

/// SigninCubit - Handles sign-in business logic and state management
///
/// This cubit manages the user authentication flow for sign-in operations.
/// It uses the LoginUseCase from the domain layer to handle authentication.
///
/// States:
/// - [SigninInitial]: Initial state when cubit is created
/// - [SigninLoading]: Loading state during authentication
/// - [SigninSuccess]: Successful authentication with user data
/// - [SigninError]: Failed authentication with error message
class SigninCubit extends Cubit<SigninState> {
  final SigninUsecase _signinUsecase;

  SigninCubit({required SigninUsecase signinUsecase})
    : _signinUsecase = signinUsecase,
      super(SigninInitial());

  /// Sign in with email and password
  ///
  /// Parameters:
  /// - [email]: User email address
  /// - [password]: User password
  ///
  /// Emits states: Loading -> Success/Error
  Future<void> signin({required String email, required String password}) async {
    // Validate inputs
    if (!_validateInputs(email, password)) {
      emit(SigninError('Email dan password harus diisi'));
      return;
    }

    emit(SigninLoading());

    // Call login use case
    final result = await _signinUsecase(email: email, passwd: password);

    // Handle result using fold pattern (Either)
    result.fold(
      // On failure (left side)
      (failure) => emit(SigninError(failure.msg)),
      // On success (right side)
      (user) => emit(SigninSuccess(user.email, user.name)),
    );
  }

  /// Validate email and password inputs
  bool _validateInputs(String email, String password) {
    final isEmailValid = email.isNotEmpty && _isValidEmail(email);
    final isPasswordValid = password.isNotEmpty && password.length >= 8;

    return isEmailValid && isPasswordValid;
  }

  /// Check if email format is valid
  bool _isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    );
    return emailRegex.hasMatch(email);
  }

  /// Reset state to initial
  void reset() {
    emit(SigninInitial());
  }
}
