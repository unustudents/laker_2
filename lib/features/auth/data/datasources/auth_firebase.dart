import 'package:firebase_auth/firebase_auth.dart';
import 'package:laker_2/core/errors/failures.dart';

abstract class AuthFirebase {
  Future<void> signInWithEmailAndPassword(String email, String password);
  Future<void> signUpWithEmailAndPassword(String email, String password);
  Future<void> signOut();
  Future<void> sendPasswordResetEmail(String email);
  Future<bool> isSignedIn();
  Future<String> getUserId();
  Future<String> getUserEmail();
  Future<void> deleteUser();
}

class AuthFirebaseImpl implements AuthFirebase {
  final FirebaseAuth _firebaseAuth;

  AuthFirebaseImpl({required FirebaseAuth firebaseAuth}) : _firebaseAuth = firebaseAuth;

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          // throw Exception('Error 404: User not found');
          throw const NotFoundFailure('Error 404: User not found');
        case 'wrong-password':
          throw Exception('Error 401: Wrong password');
        case 'invalid-email':
          throw Exception('Error 400: Invalid email');
        default:
          // throw Exception('Error 500: Internal server error');
          throw const ServerFailure('Error 500: Internal server error');
      }
    }
  }

  @override
  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          // throw Exception('Error 404: User not found');
          throw const NotFoundFailure('Error 404: User not found');
        case 'wrong-password':
          throw Exception('Error 401: Wrong password');
        case 'invalid-email':
          throw Exception('Error 400: Invalid email');
        default:
          // throw Exception('Error 500: Internal server error');
          throw const ServerFailure('Error 500: Internal server error');
      }
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<bool> isSignedIn() async {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }

  @override
  Future<String> getUserId() async {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser!.uid;
  }

  @override
  Future<String> getUserEmail() async {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser!.email!;
  }

  @override
  Future<void> deleteUser() async {
    final currentUser = _firebaseAuth.currentUser;
    await currentUser!.delete();
  }
}
