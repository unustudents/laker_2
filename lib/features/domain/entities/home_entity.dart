import 'package:equatable/equatable.dart';

class HomeEntity extends Equatable {
  final String nama;
  final String? imgProfil;

  const HomeEntity({this.imgProfil, required this.nama});

  @override
  List<Object?> get props {
    return [nama, imgProfil];
  }
}
