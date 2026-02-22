import 'package:get_it/get_it.dart';
import 'package:laker_2/features/data/datasources/remote/profil_remote.dart';

import 'features/data/datasources/remote/home_remote.dart';
import 'features/data/datasources/remote/pretest_remote.dart';
import 'features/data/datasources/remote/signin_remote.dart';
import 'features/data/datasources/remote/signup_remote.dart';
import 'features/data/repositories/home_repoimpl.dart';
import 'features/data/repositories/pretest_repoimpl.dart';
import 'features/data/repositories/profil_repoimpl.dart';
import 'features/data/repositories/signin_repoimpl.dart';
import 'features/data/repositories/signup_repoimpl.dart';
import 'features/domain/repositories/home_repository.dart';
import 'features/domain/repositories/pretest_repository.dart';
import 'features/domain/repositories/profil_repository.dart';
import 'features/domain/repositories/signin_repository.dart'
    show SigninRepository;
import 'features/domain/repositories/signup_repository.dart';
import 'features/domain/usecases/home_usecase.dart';
import 'features/domain/usecases/pretest_usecase.dart'
    show PretestUseCase, SubmitAnswerUsecase;
import 'features/domain/usecases/profil_usecase.dart';
import 'features/domain/usecases/signin_usecase.dart' show SigninUsecase;
import 'features/domain/usecases/signup_usecase.dart';
import 'features/presentation/cubit/home_cubit.dart';
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

  dI.registerFactory(() => ProfileCubit(profilUsecase: dI<ProfilUsecase>()));

  dI.registerFactoryParam<PreTestCubit, int, dynamic>(
    (idKategori, _) => PreTestCubit(
      readSoalUseCase: dI<PretestUseCase>(),
      submitAnswerUseCase: dI<SubmitAnswerUsecase>(),
      idKategori: idKategori,
    ),
  );

  dI.registerFactory(() => PostTestCubit());

  dI.registerFactory(() => MateriCubit());

  dI.registerFactory(() => HomeCubit(homeUsecase: dI<HomeUsecase>()));

  // USECASE
  dI.registerLazySingleton(() => SignupUsecase(dI<SignupRepository>()));

  dI.registerLazySingleton(() => SigninUsecase(dI<SigninRepository>()));

  dI.registerLazySingleton(() => PretestUseCase(dI<PretestRepository>()));

  dI.registerLazySingleton(() => SubmitAnswerUsecase(dI<PretestRepository>()));

  dI.registerLazySingleton(() => HomeUsecase(dI<HomeRepository>()));

  dI.registerLazySingleton(() => ProfilUsecase(dI<ProfilRepository>()));

  // REPOSITORY
  dI.registerLazySingleton<SigninRepository>(
    () => SigninRepositoryImpl(remoteDataSource: dI<SigninRemoteDataSource>()),
  );

  dI.registerLazySingleton<SignupRepository>(
    () => SignupRepositoryImpl(remoteDataSource: dI<SignupRemoteDataSource>()),
  );

  dI.registerLazySingleton<PretestRepository>(
    () =>
        PretestRepositoryImpl(remoteDataSource: dI<PretestRemoteDataSource>()),
  );

  dI.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(remoteDataSource: dI<HomeRemoteDataSource>()),
  );

  dI.registerLazySingleton<ProfilRepository>(
    () => ProfilRepositoryImpl(remoteDataSource: dI<ProfilRemoteDataSource>()),
  );

  // DATA SOURCE
  dI.registerLazySingleton<SigninRemoteDataSource>(
    () => SigninRemoteDataSourceImpl(supabaseClient: dI()),
  );

  dI.registerLazySingleton<SignupRemoteDataSource>(
    () => SignupRemoteDataSourceImpl(client: dI()),
  );

  dI.registerLazySingleton<PretestRemoteDataSource>(
    () => PretestRemoteDataSourceImpl(supabaseClient: dI()),
  );

  dI.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(supabase: dI()),
  );

  dI.registerLazySingleton<ProfilRemoteDataSource>(
    () => ProfilRemoteDataSourceImpl(supabase: dI()),
  );

  // FIREBASE AUTH

  dI.registerLazySingleton(() => Supabase.instance.client);
}
