import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'update_pass_state.dart';

class UpdatePassCubit extends Cubit<UpdatePassState> {
  UpdatePassCubit() : super(UpdatePassInitial());
}
