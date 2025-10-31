// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../domain/utils/form_field.dart';
// import '../../domain/widget/form_bottom.dart';
// import '../../domain/widget/option_quis.dart';
// import '../status.dart';
// import 'controllers/post_test.controller.dart';

// class PostTestScreen extends GetView<PostTestController> {
//   const PostTestScreen({super.key});

//   static const List<String> _option = ["A", "B", "C", "D"];
//   @override
//   Widget build(BuildContext context) {
//     final formkeyAddQuiz = GlobalKey<FormState>();
//     final soal = TextEditingController();
//     final jawabTrue = TextEditingController();
//     final jawab2 = TextEditingController();
//     final jawab3 = TextEditingController();
//     final jawab4 = TextEditingController();
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         foregroundColor: Theme.of(context).primaryColor,
//         centerTitle: true,
//         title: Obx(
//           () => Text(
//             "Question ${controller.record.length} / ${controller.readData.length}",
//             style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w500),
//           ),
//         ),
//         bottom: const PreferredSize(
//           preferredSize: Size.zero,
//           child: Divider(indent: 15.0, endIndent: 15.0),
//         ),
//       ),
//       body: Center(
//         child: Obx(
//           () {
//             // JIKA LOADING
//             if (controller.statusSoal.value == Status.loading) {
//               return CircularProgressIndicator(color: Theme.of(context).primaryColor);
//             }

//             // JIKA ERROR
//             if (controller.statusSoal.value == Status.error) {
//               return const Text("Error punten 👏🏻");
//             }

//             // JIKA DATANYA KOSONG
//             if (controller.readData.isEmpty) {
//               return const Text('Quiz is empty ! 😩', textAlign: TextAlign.center);
//             }

//             // JIKA DATANYA ADA
//             return ListView.separated(
//               padding: const EdgeInsets.all(15.0),
//               itemBuilder: (context, index) {
//                 // TOMBOL NEXT TO MATERI PAGE
//                 if (index == controller.readData.length) {
//                   return Obx(
//                     () => ElevatedButton(
//                       onPressed: controller.record.length != controller.readData.length
//                           ? null
//                           : () {
//                               Get.snackbar("Finish", "Selesai 🏁");
//                               // Get.offAllNamed(Routes.HOME);
//                               controller.persen();
//                             },
//                       child: const Text("Next"),
//                     ),
//                   );
//                 }

//                 // GET DATA
//                 Map<String, dynamic> item = controller.readData[index];
//                 List<dynamic> options = item["options"];
//                 options.shuffle(); // agar optionsnya teracak

//                 // VARIABLE
//                 String title = item["question"].toString();
//                 String uid = item["uid"].toString();
//                 String trueOption = item["trueAnswer"].toString();

//                 // KUIS
//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           title,
//                           style: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w500),
//                         ),
//                         IconButton(
//                           onPressed: () {
//                             Get.defaultDialog(
//                               title: "Hapus",
//                               middleText: "Apakah anda yakin ingin menghapus kuis ?",
//                               contentPadding: const EdgeInsets.all(20.0),
//                               onConfirm: () {
//                                 controller.funDeleteQuis(idQuis: uid, title: title);
//                               },
//                               onCancel: () {
//                                 Get.back();
//                               },
//                             );
//                           },
//                           icon: const Icon(Icons.more_vert),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 10),
//                     ...options.asMap().entries.map<Widget>(
//                           (e) => Obx(
//                             () => OptionQuis(
//                               abjad: _option[e.key],
//                               selected: controller.record[uid]?['current'] == e.value.toString(),
//                               options: e.value.toString(),
//                               onTap: () {
//                                 controller.funOption(
//                                   uid: uid,
//                                   option: e.value.toString(),
//                                   optionTrue: trueOption,
//                                 );
//                               },
//                             ),
//                           ),
//                         )
//                   ],
//                 );
//               },
//               separatorBuilder: (context, index) => const SizedBox(height: 35),
//               itemCount: controller.readData.length + 1,
//             );
//           },
//         ),
//       ),
//       // --HANYA UNTUK PANITIA
//       // TOMBOL TAMBAH SOAL
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Get.bottomSheet(
//             FormBottomSheet(
//               formkey: formkeyAddQuiz,
//               children: [
//                 Formulir.formReguler(controller: soal, labelText: "Soal"),
//                 const SizedBox(height: 15),
//                 Formulir.formReguler(controller: jawabTrue, labelText: "Jawaban Benar"),
//                 const SizedBox(height: 15),
//                 Formulir.formReguler(controller: jawab2, labelText: "Jawaban ke 2"),
//                 const SizedBox(height: 15),
//                 Formulir.formReguler(controller: jawab3, labelText: "Jawaban ke 3"),
//                 const SizedBox(height: 15),
//                 Formulir.formReguler(controller: jawab4, labelText: "Jawaban ke 4"),
//                 const SizedBox(height: 15),
//                 Obx(
//                   () => ElevatedButton(
//                     onPressed: () async {
//                       if (formkeyAddQuiz.currentState!.validate()) {
//                         bool data = await controller.funCreateQuis(
//                             question: soal.text, optionTrue: jawabTrue.text, option2: jawab2.text, option3: jawab3.text, option4: jawab4.text);
//                         data ? formkeyAddQuiz.currentState!.reset() : null;
//                       }
//                     },
//                     child: controller.statusButton.value == Status.loading
//                         ? const CircularProgressIndicator(
//                             backgroundColor: Colors.amber,
//                             color: Colors.white,
//                           )
//                         : const Text("TAMBAH"),
//                   ),
//                 )
//               ],
//             ),
//           );
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

// import 'package:get/get.dart';

// import '../../../domain/model/model_model.dart';
// import '../../../domain/provider/quis_test.provider.dart';
// import '../../status.dart';

// class PostTestController extends GetxController {
//   // VARIABEL
//   final String uid = Get.arguments;
//   final record = <String, dynamic>{}.obs;
//   final readData = <Map<String, dynamic>>[].obs;
//   var statusSoal = Status.success.obs;
//   var statusButton = Status.success.obs;
//   static const _collection = "postest";

//   @override
//   void onInit() {
//     super.onInit();
//     statusSoal.value = Status.loading;
//     readData.bindStream(readStream(uid: uid, collection: _collection));
//     ever(readData, (callback) => statusSoal.value = Status.success);
//   }

//   persen() {
//     int totalJawaban = record.length;
//     int jawabanBenar = 0;

//     for (var value in record.values) {
//       if (value['status'] == true) {
//         jawabanBenar++;
//       }
//     }

//     double persenJawabanBenar = (jawabanBenar / totalJawaban) * 100;
//     print('Total jawaban: $totalJawaban');
//     print('Jawaban benar: $jawabanBenar');
//     print('Persentase jawaban benar: $persenJawabanBenar%');
//   }

//   Future<void> funReadQuis(String uid) async {
//     statusSoal.value = Status.loading;
//     var data = await readQuis(uid: uid, collection: _collection);
//     readData.value = data;
//     statusSoal.value = Status.success;
//   }

//   Future<bool> funCreateQuis({
//     required String question,
//     required String optionTrue,
//     required String option2,
//     required String option3,
//     required String option4,
//   }) async {
//     statusButton.value = Status.loading;
//     bool data = await createQuis(
//       uid: uid,
//       data: Quiz(
//         question: question,
//         options: [optionTrue, option2, option3, option4],
//         trueAnswer: optionTrue,
//       ),
//       collection: _collection,
//     );
//     if (data) {
//       onReady();
//       statusButton.value = Status.success;
//       Get.back();
//       Get.snackbar("Success", "Berhasil menambah data");
//       return data;
//     } else {
//       Get.back();
//       Get.snackbar("Error", "Tidak dapat menambah soal");
//       return data;
//     }
//   }

//   void funOption({required String uid, required String option, required String optionTrue}) {
//     bool status = option == optionTrue;
//     record[uid] = {'current': option, 'status': status}.obs;
//   }

//   Future<bool> funDeleteQuis({required String idQuis, required String title}) async {
//     statusSoal.value = Status.loading;
//     bool data = await deleteQuis(uid: uid, idQuis: idQuis, collection: _collection);
//     if (data) {
//       onReady();
//       record.remove(title);
//       Get.back();
//       Get.snackbar("Success", "Berhasil menghapus soal");
//       return data;
//     } else {
//       Get.back();
//       Get.snackbar("Error", "Tidak dapat menghapus soal");
//       return data;
//     }
//   }

//   bool validateUniqueAnswers(String answerTrue, String answer2, String answer3, String answer4) {
//     return !(answerTrue == answer2 ||
//         answerTrue == answer3 ||
//         answerTrue == answer4 ||
//         answer2 == answer3 ||
//         answer2 == answer4 ||
//         answer3 == answer4);
//   }
// }

// ============================================================================
// KONVERSI KE FLUTTER MODERN (DARI GETX KE CUBIT + FLUTTER HOOKS)
// ============================================================================
// Perubahan:
// 1. GetView<PostTestController> → StatefulHookWidget + BlocBuilder
// 2. Obx → BlocBuilder untuk reactive state
// 3. controller.readData → state.questions
// 4. controller.record → state.answers
// 5. Get.toNamed() → Navigator.pushNamed()
// 6. Get.snackbar() → ScaffoldMessenger.showSnackBar()
// 7. Get.defaultDialog() → showDialog()
// 8. Get.bottomSheet() → showModalBottomSheet()
// 9. StatefulWidget dengan GlobalKey → StatefulHookWidget dengan useTextEditingController()
// File: lib/features/presentation/cubit/post_test_cubit.dart
// State: lib/features/presentation/cubit/post_test_state.dart
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../cubit/post_test_cubit.dart';

class PostTestScreen extends StatelessWidget {
  const PostTestScreen({super.key});
  static const List<String> _option = ["A", "B", "C", "D"];

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as String? ?? '';

    return BlocBuilder<PostTestCubit, PostTestState>(
      builder: (context, state) {
        // Initialize Cubit dengan uid dari arguments
        if (state is PostTestInitial) {
          context.read<PostTestCubit>().initialize(arguments);
        }

        return Scaffold(
          appBar: _AppBarWidget(state: state),
          body: _buildBody(context, state),
          floatingActionButton: _FloatingActionButtonWidget(uid: arguments),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, PostTestState state) {
    if (state is PostTestLoading) {
      return Center(
        child: CircularProgressIndicator(color: Theme.of(context).primaryColor),
      );
    }

    if (state is PostTestError) {
      return Center(child: Text("Error: ${state.message}"));
    }

    if (state is! PostTestLoaded) {
      return const Center(child: Text('Unknown state'));
    }

    final loadedState = state;

    if (loadedState.questions.isEmpty) {
      return const Center(
        child: Text('Quiz is empty ! 😩', textAlign: TextAlign.center),
      );
    }

    return Center(
      child: ListView.separated(
        padding: const EdgeInsets.all(15.0),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          // TOMBOL NEXT
          if (index == loadedState.questions.length) {
            return BlocBuilder<PostTestCubit, PostTestState>(
              builder: (context, state) {
                final isAllAnswered = context
                    .read<PostTestCubit>()
                    .isAllAnswered();

                return ElevatedButton(
                  onPressed: !isAllAnswered
                      ? null
                      : () {
                          // Hitung score dan tampilkan snackbar
                          int score = context
                              .read<PostTestCubit>()
                              .calculateScore();

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Finish - Score: $score%"),
                              duration: const Duration(seconds: 2),
                            ),
                          );

                          // TODO: Navigate ke home atau result page
                          // Navigator.pushNamedAndRemoveUntil(
                          //   context,
                          //   RouteName.home,
                          //   (route) => false,
                          // );
                        },
                  child: const Text("Next"),
                );
              },
            );
          }

          // GET DATA
          Map<String, dynamic> question = loadedState.questions[index];
          List<dynamic> options = List.from(question["options"] ?? []);
          options.shuffle();

          String questionText = question["question"].toString();
          String questionId = question["uid"].toString();
          String correctAnswer = question["trueAnswer"].toString();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      questionText,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Hapus"),
                          content: const Text(
                            "Apakah anda yakin ingin menghapus kuis ?",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                context.read<PostTestCubit>().deleteQuiz(
                                  uid:
                                      ModalRoute.of(context)?.settings.arguments
                                          as String? ??
                                      '',
                                  quizId: questionId,
                                );
                              },
                              child: const Text("Okey"),
                            ),
                          ],
                        ),
                      );
                    },
                    icon: const Icon(Icons.more_vert),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ...options.asMap().entries.map<Widget>((e) {
                String optionText = e.value.toString();
                bool isSelected =
                    loadedState.answers[questionId]?['current'] == optionText;

                return GestureDetector(
                  onTap: () {
                    context.read<PostTestCubit>().selectOption(
                      quizId: questionId,
                      selectedOption: optionText,
                      correctAnswer: correctAnswer,
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isSelected
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
                        width: isSelected ? 2 : 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      color: isSelected
                          ? Theme.of(context).primaryColor.withOpacity(0.1)
                          : Colors.transparent,
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Theme.of(context).primaryColor,
                          child: Text(
                            _option[e.key],
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(child: Text(optionText)),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ],
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 35),
        itemCount: loadedState.questions.length + 1,
      ),
    );
  }
}

/// Custom AppBar Widget
class _AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final PostTestState state;

  const _AppBarWidget({required this.state});

  @override
  Widget build(BuildContext context) {
    int answered = 0;
    int total = 0;

    if (state is PostTestLoaded) {
      final loadedState = state as PostTestLoaded;
      answered = loadedState.answers.length;
      total = loadedState.questions.length;
    }

    return AppBar(
      backgroundColor: Colors.white,
      foregroundColor: Theme.of(context).primaryColor,
      centerTitle: true,
      title: Text(
        "Question $answered / $total",
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      bottom: const PreferredSize(
        preferredSize: Size.zero,
        child: Divider(indent: 15.0, endIndent: 15.0),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

/// Custom FAB Widget untuk Add Quiz dengan Flutter Hooks
class _FloatingActionButtonWidget extends HookWidget {
  final String uid;

  const _FloatingActionButtonWidget({required this.uid});

  @override
  Widget build(BuildContext context) {
    // Form key dan controllers menggunakan Flutter Hooks
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final soalController = useTextEditingController();
    final correctAnswerController = useTextEditingController();
    final answer2Controller = useTextEditingController();
    final answer3Controller = useTextEditingController();
    final answer4Controller = useTextEditingController();

    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) => Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Tambah Soal",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: soalController,
                        decoration: const InputDecoration(
                          labelText: "Soal",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return "Soal tidak boleh kosong";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: correctAnswerController,
                        decoration: const InputDecoration(
                          labelText: "Jawaban Benar",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return "Jawaban tidak boleh kosong";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: answer2Controller,
                        decoration: const InputDecoration(
                          labelText: "Jawaban ke 2",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return "Jawaban tidak boleh kosong";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: answer3Controller,
                        decoration: const InputDecoration(
                          labelText: "Jawaban ke 3",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return "Jawaban tidak boleh kosong";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: answer4Controller,
                        decoration: const InputDecoration(
                          labelText: "Jawaban ke 4",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return "Jawaban tidak boleh kosong";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      BlocBuilder<PostTestCubit, PostTestState>(
                        builder: (context, state) {
                          bool isCreating = state is PostTestCreating;

                          return SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: isCreating
                                  ? null
                                  : () {
                                      if (formKey.currentState!.validate()) {
                                        context
                                            .read<PostTestCubit>()
                                            .createQuiz(
                                              uid: uid,
                                              question: soalController.text,
                                              correctAnswer:
                                                  correctAnswerController.text,
                                              answer2: answer2Controller.text,
                                              answer3: answer3Controller.text,
                                              answer4: answer4Controller.text,
                                            );

                                        if (!isCreating) {
                                          formKey.currentState!.reset();
                                          Navigator.pop(context);
                                        }
                                      }
                                    },
                              child: isCreating
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Text("TAMBAH"),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
