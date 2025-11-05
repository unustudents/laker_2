import 'package:equatable/equatable.dart';

import '../../domain/entities/home_entity.dart';

/// Model untuk Sign In (Data Layer)
class HomeModel extends Equatable {
  final String name;
  final String? imgProfil;

  const HomeModel({required this.name, this.imgProfil});

  /// Convert dari JSON ke SigninModel
  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
    name: json['name'] as String,
    imgProfil: json['img_profil'] as String?,
  );

  /// Convert SigninModel ke SigninEntity (Domain Layer)
  HomeEntity toEntity() => HomeEntity(nama: name, imgProfil: imgProfil);

  /// Convert dari SigninEntity ke SigninModel
  factory HomeModel.fromEntity(HomeEntity entity) =>
      HomeModel(name: entity.nama, imgProfil: entity.imgProfil);

  @override
  List<Object?> get props => [name, imgProfil];
}
