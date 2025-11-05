import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:laker_2/routes/app_router.dart';

import '../cubit/pre_test_cubit.dart';

class PreTestScreen extends HookWidget {
  const PreTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // State lokal menggunakan Flutter Hooks
    final selectedAnswers = useState<Map<int, String?>>({});
    final currentIndex = useState(0);

    return BlocBuilder<PreTestCubit, PreTestState>(
      builder: (context, state) {
        return Scaffold(
          appBar: _buildAppBar(context, state, currentIndex.value),
          body: _buildBody(context, state, currentIndex, selectedAnswers),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar(
    BuildContext context,
    PreTestState state,
    int currentIndex,
  ) {
    int total = 0;
    if (state is PreTestLoaded) {
      total = state.soals.length;
    }

    return AppBar(
      backgroundColor: Colors.white,
      foregroundColor: Theme.of(context).primaryColor,
      centerTitle: true,
      title: Text(
        "Question ${currentIndex + 1} / $total",
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

  Widget _buildBody(
    BuildContext context,
    PreTestState state,
    ValueNotifier<int> currentIndex,
    ValueNotifier<Map<int, String?>> selectedAnswers,
  ) {
    if (state is PreTestLoading) {
      return Center(
        child: CircularProgressIndicator(color: Theme.of(context).primaryColor),
      );
    }

    if (state is PreTestError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Error: ${state.message}"),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final args =
                    (ModalRoute.of(context)?.settings.arguments
                        as Map<String, dynamic>?) ??
                    {};
                final idKategori = args['idKategori'] as int? ?? 1;
                context.read<PreTestCubit>().readSoal(idKategori: idKategori);
              },
              child: const Text("Retry"),
            ),
          ],
        ),
      );
    }

    if (state is! PreTestLoaded) {
      return const Center(child: Text('Unknown state'));
    }

    if (state.soals.isEmpty) {
      return const Center(
        child: Text('Tidak ada soal ! 😩', textAlign: TextAlign.center),
      );
    }

    final soal = state.soals[currentIndex.value];
    final options = [...soal.options];

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      soal.soal,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ...options.asMap().entries.map((entry) {
                      final option = entry.value;
                      final isSelected =
                          selectedAnswers.value[currentIndex.value] ==
                          option.pilihan;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: GestureDetector(
                          onTap: () {
                            selectedAnswers.value = {
                              ...selectedAnswers.value,
                              currentIndex.value: option.pilihan,
                            };
                            context.read<PreTestCubit>().submitJawabanPretest(
                              data: option,
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: isSelected
                                    ? Theme.of(context).primaryColor
                                    : Colors.grey.shade300,
                                width: isSelected ? 2 : 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                              color: isSelected
                                  ? Theme.of(
                                      context,
                                    ).primaryColor.withValues(alpha: 0.1)
                                  : Colors.transparent,
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 18,
                                  backgroundColor: Theme.of(
                                    context,
                                  ).primaryColor,
                                  child: Text(
                                    option.label,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    option.pilihan,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              spacing: 12,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (currentIndex.value > 0)
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        currentIndex.value--;
                      },
                      child: const Text("Previous"),
                    ),
                  ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (currentIndex.value < state.soals.length - 1) {
                        currentIndex.value++;
                      } else {
                        _showFinishDialog(context);
                      }
                    },
                    child: Text(
                      currentIndex.value == state.soals.length - 1
                          ? "Finish"
                          : "Next",
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showFinishDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Selesaikan Kuis"),
        content: const Text(
          "Apakah kamu sudah yakin ingin menyelesaikan kuis ini?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          TextButton(
            onPressed: () => HomeRoute().go(context),
            child: const Text("Yakin"),
          ),
        ],
      ),
    );
  }
}
