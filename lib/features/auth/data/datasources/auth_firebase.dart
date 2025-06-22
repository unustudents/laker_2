import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:laker_2/features/auth/data/models/auth_models.dart';

import '../../../../core/errors/failures.dart';

abstract class AuthFirebase {
  Future<void> signInWithEmailAndPassword(String email, String password);
  Future<UserModels> signUpWithEmailAndPassword({required String password, required UserModels data});
  Future<void> signOut();
  Future<void> sendPasswordResetEmail(String email);
  Future<bool> isSignedIn();
  Future<String> getUserId();
  Future<String> getUserEmail();
  Future<void> deleteUser();
}

class FirebaseImplementasi extends AuthFirebase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // FirebaseImplementasi({required FirebaseAuth firebaseAuth}) : _firebaseAuth = firebaseAuth;

  @override
  Future<void> deleteUser() async => await _firebaseAuth.currentUser!.delete();

  @override
  Future<String> getUserEmail() async => _firebaseAuth.currentUser!.email!;

  @override
  Future<String> getUserId() async => _firebaseAuth.currentUser!.uid;

  @override
  Future<bool> isSignedIn() async => _firebaseAuth.currentUser != null;

  @override
  Future<void> sendPasswordResetEmail(String email) async => await _firebaseAuth.sendPasswordResetEmail(email: email);

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
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
  Future<void> signOut() async => await _firebaseAuth.signOut();

  @override
  Future<UserModels> signUpWithEmailAndPassword({required String password, required UserModels data}) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(email: data.email, password: password);
      await _firestore.collection('user').doc(credential.user!.uid).set(data.toJson());
      await _firebaseAuth.currentUser!.sendEmailVerification();
      await _firebaseAuth.signOut();
      return data;
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
}

// class AuthFirebaseImpl implements AuthFirebase {
//   final FirebaseAuth _firebaseAuth;

//   AuthFirebaseImpl({required FirebaseAuth firebaseAuth}) : _firebaseAuth = firebaseAuth;

//   @override
//   Future<void> signInWithEmailAndPassword(String email, String password) async {
//     try {
//       await _firebaseAuth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//     } on FirebaseAuthException catch (e) {
//       switch (e.code) {
//         case 'user-not-found':
//           // throw Exception('Error 404: User not found');
//           throw const NotFoundFailure('Error 404: User not found');
//         case 'wrong-password':
//           throw Exception('Error 401: Wrong password');
//         case 'invalid-email':
//           throw Exception('Error 400: Invalid email');
//         default:
//           // throw Exception('Error 500: Internal server error');
//           throw const ServerFailure('Error 500: Internal server error');
//       }
//     }
//   }

//   @override
//   Future<void> signUpWithEmailAndPassword(String email, String password) async {
//     try {
//       await _firebaseAuth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//     } on FirebaseAuthException catch (e) {
//       switch (e.code) {
//         case 'user-not-found':
//           // throw Exception('Error 404: User not found');
//           throw const NotFoundFailure('Error 404: User not found');
//         case 'wrong-password':
//           throw Exception('Error 401: Wrong password');
//         case 'invalid-email':
//           throw Exception('Error 400: Invalid email');
//         default:
//           // throw Exception('Error 500: Internal server error');
//           throw const ServerFailure('Error 500: Internal server error');
//       }
//     }
//   }

//   @override
//   Future<void> signOut() async {
//     await _firebaseAuth.signOut();
//   }

//   @override
//   Future<void> sendPasswordResetEmail(String email) async {
//     await _firebaseAuth.sendPasswordResetEmail(email: email);
//   }

//   @override
//   Future<bool> isSignedIn() async {
//     final currentUser = _firebaseAuth.currentUser;
//     return currentUser != null;
//   }

//   @override
//   Future<String> getUserId() async {
//     final currentUser = _firebaseAuth.currentUser;
//     return currentUser!.uid;
//   }

//   @override
//   Future<String> getUserEmail() async {
//     final currentUser = _firebaseAuth.currentUser;
//     return currentUser!.email!;
//   }

//   @override
//   Future<void> deleteUser() async {
//     final currentUser = _firebaseAuth.currentUser;
//     await currentUser!.delete();
//   }
// }
