// ============================================================================
// KONVERSI KE FLUTTER MODERN (DARI GETX KE CUBIT)
// ============================================================================
// Perubahan:
// 1. GetView<PreTestController> → StatelessWidget + BlocBuilder
// 2. Obx → BlocBuilder untuk reactive state
// 3. controller.readData → state.questions
// 4. controller.record → state.answers
// 5. Get.toNamed() → Navigator.pushNamed()
// 6. Get.dialog() → showDialog()
// 7. Get.snackbar() → ScaffoldMessenger.showSnackBar()
// File: lib/features/presentation/cubit/pre_test_cubit.dart
// State: lib/features/presentation/cubit/pre_test_state.dart
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laker_2/routes/app_router.dart';

import '../cubit/pre_test_cubit.dart';

class PreTestScreen extends StatelessWidget {
  const PreTestScreen({super.key});

  static const List<String> _option = ["A", "B", "C", "D"];

  @override
  Widget build(BuildContext context) {
    final args =
        (ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?) ??
        {};

    return BlocBuilder<PreTestCubit, PreTestState>(
      builder: (context, state) {
        return Scaffold(
          appBar: _AppBarWidget(state: state),
          body: _buildBody(context, state, args),
          floatingActionButton: _FloatingActionButtonWidget(
            state: state,
            arguments: args,
          ),
        );
      },
    );
  }

  Widget _buildBody(
    BuildContext context,
    PreTestState state,
    Map<String, dynamic> arguments,
  ) {
    if (state is PreTestLoading) {
      return Center(
        child: CircularProgressIndicator(color: Theme.of(context).primaryColor),
      );
    }

    if (state is PreTestError) {
      return Center(child: Text("Error: ${state.message}"));
    }

    if (state is! PreTestLoaded) {
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
          // TOMBOL NEXT/FINISH
          if (index == loadedState.questions.length) {
            return BlocBuilder<PreTestCubit, PreTestState>(
              builder: (context, state) {
                final isAllAnswered = context
                    .read<PreTestCubit>()
                    .isAllAnswered();

                return ElevatedButton(
                  onPressed: !isAllAnswered
                      ? null
                      : () {
                          if (arguments['test'] == null) {
                            // Calculate score
                            int score = context
                                .read<PreTestCubit>()
                                .calculateScore();

                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text("Selesaikan kuis"),
                                content: const Text(
                                  "Apakah kamu sudah yakin ingin menyelesaikan kuis ini ?\nKuis tidak dapat diulang !",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("Belum"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      // Navigator.pushNamed(
                                      //   context,
                                      //   ResultRoute().toString(),
                                      //   arguments: score,
                                      // );
                                      ResultRoute().push(context);
                                    },
                                    child: const Text("Yakin"),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            // Navigator.pushNamed(
                            //   context,
                            //   RouteName.materi,
                            //   arguments: arguments['uid'],
                            // );
                            MateriRoute().push(context);
                          }
                        },
                  child: Text(arguments['test'] != null ? "Selesai" : "Next"),
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
                          title: const Text("Hapus kuis"),
                          content: const Text(
                            "Apakah anda yakin ingin menghapus kuis ini?",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                context.read<PreTestCubit>().deleteQuiz(
                                  uid: arguments['uid'],
                                  quizId: questionId,
                                  collection: arguments['test'] ?? 'pretest',
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
                    context.read<PreTestCubit>().selectOption(
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
  final PreTestState state;

  const _AppBarWidget({required this.state});

  @override
  Widget build(BuildContext context) {
    int answered = 0;
    int total = 0;

    if (state is PreTestLoaded) {
      final loadedState = state as PreTestLoaded;
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

/// Custom FAB Widget untuk Add Quiz
class _FloatingActionButtonWidget extends StatefulWidget {
  final PreTestState state;
  final Map<String, dynamic> arguments;

  const _FloatingActionButtonWidget({
    required this.state,
    required this.arguments,
  });

  @override
  State<_FloatingActionButtonWidget> createState() =>
      _FloatingActionButtonWidgetState();
}

class _FloatingActionButtonWidgetState
    extends State<_FloatingActionButtonWidget> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _questionController;
  late TextEditingController _correctAnswerController;
  late TextEditingController _answer2Controller;
  late TextEditingController _answer3Controller;
  late TextEditingController _answer4Controller;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _questionController = TextEditingController();
    _correctAnswerController = TextEditingController();
    _answer2Controller = TextEditingController();
    _answer3Controller = TextEditingController();
    _answer4Controller = TextEditingController();
  }

  @override
  void dispose() {
    _questionController.dispose();
    _correctAnswerController.dispose();
    _answer2Controller.dispose();
    _answer3Controller.dispose();
    _answer4Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  key: _formKey,
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
                        controller: _questionController,
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
                        controller: _correctAnswerController,
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
                        controller: _answer2Controller,
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
                        controller: _answer3Controller,
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
                        controller: _answer4Controller,
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
                      BlocBuilder<PreTestCubit, PreTestState>(
                        builder: (context, state) {
                          bool isCreating = state is PreTestCreating;

                          return SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: isCreating
                                  ? null
                                  : () {
                                      if (_formKey.currentState!.validate()) {
                                        context.read<PreTestCubit>().createQuiz(
                                          uid: widget.arguments['uid'],
                                          question: _questionController.text,
                                          correctAnswer:
                                              _correctAnswerController.text,
                                          answer2: _answer2Controller.text,
                                          answer3: _answer3Controller.text,
                                          answer4: _answer4Controller.text,
                                          collection:
                                              widget.arguments['test'] ??
                                              'pretest',
                                        );

                                        if (!isCreating) {
                                          _formKey.currentState!.reset();
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
