import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/usecases/signup_usecase.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final SignupUsecase _signupUsecase;

  SignupCubit({required SignupUsecase signupUsecase})
    : _signupUsecase = signupUsecase,
      super(SignupInitial());

  Future<void> signup({
    required String email,
    required String name,
    required String division,
    required DateTime birthDate,
    required String whatsapp,
    required String password,
  }) async {
    if (!_validateInputs(email, name, password)) {
      emit(const SignupError('Validasi input gagal'));
      return;
    }

    emit(SignupLoading());

    final result = await _signupUsecase(
      email: email,
      name: name,
      division: division,
      birthDate: birthDate,
      whatsapp: whatsapp,
      password: password,
    );

    result.fold(
      (failure) => emit(SignupError(failure.msg)),
      (success) => emit(const SignupSuccess('Sign up berhasil')),
    );
  }

  bool _validateInputs(String email, String name, String password) {
    if (email.isEmpty || name.isEmpty || password.isEmpty) {
      return false;
    }

    if (!_isValidEmail(email)) {
      return false;
    }

    if (password.length < 8) {
      return false;
    }

    return true;
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9.!#$%&*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$',
    );
    return emailRegex.hasMatch(email);
  }

  void reset() {
    emit(SignupInitial());
  }
}
