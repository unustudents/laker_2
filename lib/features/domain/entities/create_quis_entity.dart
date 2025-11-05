import 'package:equatable/equatable.dart';

class CreateQuizParamEntity extends Equatable {
  final String question; // Pertanyaan soal
  final String optionTrue; // Opsi yang benar
  final String option2; // Opsi 2
  final String option3; // Opsi 3
  final String option4; // Opsi 4

  const CreateQuizParamEntity({
    required this.question,
    required this.optionTrue,
    required this.option2,
    required this.option3,
    required this.option4,
  });

  @override
  List<Object?> get props => [question, optionTrue, option2, option3, option4];
}
