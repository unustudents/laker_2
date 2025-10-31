import 'package:get_it/get_it.dart';

import 'features/presentation/cubit/signin_cubit.dart';
import 'features/presentation/cubit/signup_cubit.dart';
import 'features/presentation/cubit/splash_cubit.dart';
import 'features/domain/usecases/signup_usecase.dart';

var mainInjection = GetIt.instance;

init() async {
  // CUBIT
  mainInjection.registerFactory(
    () => SigninCubit(signinUsecase: mainInjection()),
  );

  mainInjection.registerFactory(
    () => SignupCubit(signupUsecase: mainInjection()),
  );

  mainInjection.registerFactory(() => SplashCubit());

  // USECASE
  mainInjection.registerLazySingleton(() => SignupUsecase(mainInjection()));

  // // BLOC
  // mainInjection.registerFactory(
  //   () => AuthBloc(registerUseCase: mainInjection(), loginUseCase: mainInjection()),
  // );

  // // USECASE
  // mainInjection.registerLazySingleton(() => RegisterUseCase(mainInjection()));
  // mainInjection.registerLazySingleton(() => LoginUseCase(mainInjection()));

  // // REPOSITORY IMPLEMENTATION
  // mainInjection.registerLazySingleton<AuthRepository>(() => AuthRepoImpl(authFirebase: mainInjection()));

  // // DATASOURCE
  // mainInjection.registerLazySingleton<AuthFirebase>(() => FirebaseImplementasi());
}
