import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/home_entity.dart';
import '../../domain/usecases/home_usecase.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeUsecase _homeUsecase;

  HomeCubit({required HomeUsecase homeUsecase})
    : _homeUsecase = homeUsecase,
      super(HomeInitial()) {
    _getData();
  }

  Future<void> _getData() async {
    emit(HomeLoading());
    final result = await _homeUsecase.call();
    result.fold(
      (failure) => emit(HomeError(failure.msg)),
      (home) => emit(HomeLoaded(home: home)),
    );
  }
}
