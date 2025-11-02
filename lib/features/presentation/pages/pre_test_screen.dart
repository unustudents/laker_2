import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/pre_test_cubit.dart';

class PreTestScreen extends StatefulWidget {
  const PreTestScreen({super.key});

  @override
  State<PreTestScreen> createState() => _PreTestScreenState();
}

class _PreTestScreenState extends State<PreTestScreen> {
  static const List<String> _optionLabels = ["A", "B", "C", "D"];
  final Map<int, String?> _selectedAnswers = {};
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreTestCubit, PreTestState>(
      builder: (context, state) {
        return Scaffold(
          appBar: _buildAppBar(context, state),
          body: _buildBody(context, state),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, PreTestState state) {
    int total = 0;
    if (state is PreTestLoaded) {
      total = state.soals.length;
    }

    return AppBar(
      backgroundColor: Colors.white,
      foregroundColor: Theme.of(context).primaryColor,
      centerTitle: true,
      title: Text(
        "Question ${_currentIndex + 1} / $total",
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

  Widget _buildBody(BuildContext context, PreTestState state) {
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

    final soal = state.soals[_currentIndex];
    final options = [...soal.options];
    // options.shuffle();

    return Padding(
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
                    final index = entry.key;
                    final option = entry.value;
                    final isSelected =
                        _selectedAnswers[_currentIndex] == option.pilihan;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedAnswers[_currentIndex] = option.pilihan;
                          });
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
                                  ).primaryColor.withOpacity(0.1)
                                : Colors.transparent,
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 18,
                                backgroundColor: Theme.of(context).primaryColor,
                                child: Text(
                                  _optionLabels[index],
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
                  }).toList(),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: _currentIndex > 0
                    ? () {
                        setState(() => _currentIndex--);
                      }
                    : null,
                child: const Text("Previous"),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_currentIndex < state.soals.length - 1) {
                    setState(() => _currentIndex++);
                  } else {
                    _showFinishDialog(context);
                  }
                },
                child: Text(
                  _currentIndex == state.soals.length - 1 ? "Finish" : "Next",
                ),
              ),
            ],
          ),
        ],
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
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Kuis telah diselesaikan!"),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: const Text("Yakin"),
          ),
        ],
      ),
    );
  }
}
