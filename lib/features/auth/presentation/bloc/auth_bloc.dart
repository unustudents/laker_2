import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/auth_entity.dart';
import '../../domain/usecases/auth_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RegisterUseCase registerUseCase;
  final LoginUseCase loginUseCase;

  AuthBloc({required this.registerUseCase, required this.loginUseCase}) : super(AuthInitial()) {
    on<AuthEventSignIn>((event, emit) async {
      emit(AuthStateLoading());
      Either<Failure, UserEntity> hasil = await loginUseCase(email: event.email, passwd: event.passwd);
      hasil.fold((l) => emit(const AuthStateError("Tidak dapat login")), (r) => emit(AuthStateSuccess()));
    });
    on<AuthEventSignUp>((event, emit) async {
      emit(AuthStateLoading());
      Either<Failure, UserEntity> hasil = await registerUseCase(params: event.data, passwd: event.passwd);
      hasil.fold((l) => emit(const AuthStateError("Tidak dapat membuat akun")), (r) => emit(AuthStateSuccess()));
    });
  }
}
