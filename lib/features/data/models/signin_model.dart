import 'package:equatable/equatable.dart';

import '../../domain/entities/signin_entity.dart';

/// Model untuk Sign In (Data Layer)
class SigninModel extends Equatable {
  final String email;
  final String name;
  final String uid;

  const SigninModel({
    required this.email,
    required this.name,
    required this.uid,
  });

  /// Convert SigninModel ke SigninEntity (Domain Layer)
  SigninEntity toEntity() => SigninEntity(
        email: email,
        name: name,
      );

  /// Convert dari SigninEntity ke SigninModel
  factory SigninModel.fromEntity(SigninEntity entity) => SigninModel(
        email: entity.email,
        name: entity.name,
        uid: '', // uid tidak ada di entity
      );

  @override
  List<Object> get props => [email, name, uid];
}
