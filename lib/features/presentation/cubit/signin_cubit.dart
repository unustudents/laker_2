import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/usecases/signin_usecase.dart';

part 'signin_state.dart';

class SigninCubit extends Cubit<SigninState> {
  final SigninUsecase _signinUsecase;

  SigninCubit({required SigninUsecase signinUsecase})
    : _signinUsecase = signinUsecase,
      super(SigninInitial());

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
      (failure) => emit(SigninError(failure.msg)),
      (user) => emit(const SigninSuccess()),
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

  // /// Reset state to initial
  // void reset() {
  //   emit(SigninInitial());
  // }
}
