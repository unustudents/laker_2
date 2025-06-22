import '../../domain/entities/auth_entity.dart';

class UserModels extends UserEntity {
  const UserModels({
    required super.email,
    required super.name,
    required super.division,
    required super.birthDate,
    required super.whatsapp,
  });
  factory UserModels.fromJson(Map<String, dynamic> json) {
    return UserModels(
      email: json['email'],
      name: json['name'],
      division: json['division'],
      birthDate: DateTime.parse(json['birthDate']),
      whatsapp: json['whatsapp'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'division': division,
      'birthDate': birthDate.toIso8601String(),
      'whatsapp': whatsapp,
    };
  }

  UserEntity get toEntity => UserEntity(
        email: email,
        name: name,
        division: division,
        birthDate: birthDate,
        whatsapp: whatsapp,
      );
}
