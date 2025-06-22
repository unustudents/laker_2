import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/auth_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_firebase.dart';
import '../models/auth_models.dart';

class AuthRepoImpl extends AuthRepository {
  final AuthFirebase authFirebase;

  AuthRepoImpl({required this.authFirebase});

  @override
  Future<void> signIn(String email, String password) async {
    // Implement sign-in logic here
  }

  @override
  Future<void> signOut() async {
    // Implement sign-out logic here
  }

  @override
  Future<void> signUp(String email, String password) async {
    // Implement sign-up logic here
  }

  @override
  Future<bool> isSignedIn() async {
    // Implement check for signed-in status here
    return false;
  }

  @override
  Future<String> getUserId() async {
    // Implement get user ID logic here
    return '';
  }

  @override
  Future<Either<Failure, UserEntity?>> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserEntity>> login({required String email, required String password}) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserEntity>> registerUser(
      {required String email,
      required String name,
      required String division,
      required DateTime birthDate,
      required String whatsapp,
      required String password}) async {
    try {
      final userModel = await authFirebase.signUpWithEmailAndPassword(
          password: password, data: UserModels(email: email, name: name, division: division, birthDate: birthDate, whatsapp: whatsapp));
      print(userModel.toEntity);
      return Right(userModel.toEntity);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
