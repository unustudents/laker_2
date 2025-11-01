import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import 'features/data/datasources/remote/signin_remote.dart';
import 'features/data/datasources/remote/signup_remote.dart';
import 'features/data/repositories/signin_repoimpl.dart';
import 'features/data/repositories/signup_repoimpl.dart';
import 'features/domain/repositories/signin_repository.dart'
    show SigninRepository;
import 'features/domain/repositories/signup_repository.dart';
import 'features/domain/usecases/signin_usecase.dart' show SigninUsecase;
import 'features/domain/usecases/signup_usecase.dart';
import 'features/presentation/cubit/materi_cubit.dart';
import 'features/presentation/cubit/post_test_cubit.dart';
import 'features/presentation/cubit/pre_test_cubit.dart';
import 'features/presentation/cubit/profile_cubit.dart';
import 'features/presentation/cubit/signin_cubit.dart';
import 'features/presentation/cubit/signup_cubit.dart';
import 'features/presentation/cubit/splash_cubit.dart';
import 'supabase_config.dart';

var dI = GetIt.instance;

Future<void> init() async {
  //  CUBITS
  dI.registerFactory(() => SigninCubit(signinUsecase: dI<SigninUsecase>()));

  dI.registerFactory(() => SignupCubit(signupUsecase: dI<SignupUsecase>()));

  dI.registerFactory(() => SplashCubit());

  dI.registerFactory(() => ProfileCubit());

  dI.registerFactory(() => PreTestCubit());

  dI.registerFactory(() => PostTestCubit());

  dI.registerFactory(() => MateriCubit());

  // USECASE
  dI.registerLazySingleton(() => SignupUsecase(dI<SignupRepository>()));

  dI.registerLazySingleton(() => SigninUsecase(dI<SigninRepository>()));

  // REPOSITORY
  dI.registerLazySingleton<SigninRepository>(
    () => SigninRepositoryImpl(remoteDataSource: dI<SigninRemoteDataSource>()),
  );

  dI.registerLazySingleton<SignupRepository>(
    () => SignupRepositoryImpl(remoteDataSource: dI<SignupRemoteDataSource>()),
  );

  // DATA SOURCE
  dI.registerLazySingleton<SigninRemoteDataSource>(
    () => SigninRemoteDataSourceImpl(supabaseClient: dI()),
  );

  dI.registerLazySingleton<SignupRemoteDataSource>(
    () => SignupRemoteDataSourceImpl(client: dI()),
  );

  // FIREBASE AUTH
  dI.registerLazySingleton(() => FirebaseAuth.instance);

  dI.registerLazySingleton(() => Supabase.instance.client);
}
