import 'package:get_it/get_it.dart';

import 'features/auth/data/datasources/auth_firebase.dart';
import 'features/auth/data/repositories/auth_repo_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/auth_usecase.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';

var mainInjection = GetIt.instance;

init() async {
  // BLOC
  mainInjection.registerFactory(
    () => AuthBloc(registerUseCase: mainInjection(), loginUseCase: mainInjection()),
  );
  // USECASE
  mainInjection.registerLazySingleton(() => RegisterUseCase(mainInjection()));
  mainInjection.registerLazySingleton(() => LoginUseCase(mainInjection()));

  // REPOSITORY IMPLEMENTATION
  mainInjection.registerLazySingleton<AuthRepository>(() => AuthRepoImpl(authFirebase: mainInjection()));

  // DATASOURCE
  mainInjection.registerLazySingleton<AuthFirebase>(() => FirebaseImplementasi());
}
