import 'dart:developer';

import 'package:bloc/bloc.dart';

class MainObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log("Bloc run : $bloc --> $change");
  }
}
