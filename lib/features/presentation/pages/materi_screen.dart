// ============================================================================
// KONVERSI KE FLUTTER MODERN (DARI GETX KE CUBIT + FLUTTER HOOKS)
// ============================================================================
// Perubahan:
// 1. GetView<MateriController> → StatelessWidget + BlocBuilder
// 2. Obx → BlocBuilder untuk reactive state
// 3. controller.readData → state.materi
// 4. controller.ytPlayer → YoutubePlayerController di HookWidget
// 5. Get.defaultDialog() → showDialog()
// 6. Get.bottomSheet() → showModalBottomSheet()
// 7. Get.snackbar() → ScaffoldMessenger.showSnackBar()
// 8. Get.offAllNamed() → Navigator.pushNamedAndRemoveUntil()
// 9. StatefulWidget dengan GlobalKey → StatefulHookWidget dengan hooks
// 10. useTextEditingController() untuk form field
// 11. useEffect() untuk YouTube player initialization
// File: lib/features/presentation/cubit/materi_cubit.dart
// State: lib/features/presentation/cubit/materi_state.dart
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// TODO: Uncomment saat Firebase provider ready
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
// import '../../../routes/app_routes.dart';

import '../cubit/materi_cubit.dart';

class MateriScreen extends StatelessWidget {
  const MateriScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        (ModalRoute.of(context)?.settings.arguments as String?) ??
        '';

    return BlocBuilder<MateriCubit, MateriState>(
      builder: (context, state) {
        // Initialize Cubit dengan uid dari arguments
        if (state is MateriInitial) {
          context.read<MateriCubit>().initialize(args);
        }

        return Scaffold(
          appBar: AppBar(title: const Text('Materi'), centerTitle: true),
          body: _buildBody(context, state, args),
          floatingActionButton: _FloatingActionButtonWidget(
            uid: args,
            isMateriEmpty: context.read<MateriCubit>().isMateriEmpty(),
          ),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, MateriState state, String uid) {
    if (state is MateriLoading) {
      return Center(
        child: CircularProgressIndicator(color: Theme.of(context).primaryColor),
      );
    }

    if (state is MateriError) {
      return Center(child: Text("Error: ${state.message}"));
    }

    if (state is! MateriLoaded) {
      return const Center(child: Text('Unknown state'));
    }

    final loadedState = state;

    if (loadedState.materi.isEmpty) {
      return const Center(
        child: Text('Materi is empty ! 😩', textAlign: TextAlign.center),
      );
    }

    String materiContent = loadedState.materi["materi"] ?? "";
    String youtubeId = loadedState.youtubeId;

    return Column(
      children: [
        // TODO: Uncomment saat YouTube player siap
        // YoutubePlayer(
        //   controller: YoutubePlayerController(
        //     initialVideoId: youtubeId,
        //     flags: const YoutubePlayerFlags(autoPlay: false),
        //   ),
        //   showVideoProgressIndicator: true,
        //   progressIndicatorColor: Colors.pink,
        // ),
        Container(
          height: 200,
          color: Colors.black,
          child: Center(
            child: Text(
              'YouTube: $youtubeId',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            children: [
              const Text(
                "Materi",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(materiContent, textAlign: TextAlign.justify),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Lanjut Test"),
                      content: const Text(
                        "Apakah anda yakin ingin lanjut Test ? \nPikirkan baik-baik sebelum anda menekan tombol ok !",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            // TODO: Navigate ke Pre-Test dengan uid dan test='postest'
                            // Navigator.pushNamedAndRemoveUntil(
                            //   context,
                            //   RouteName.pretest,
                            //   (route) => false,
                            //   arguments: {'uid': uid, 'test': 'postest'},
                            // );
                          },
                          child: const Text("Ok"),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text("Next"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Custom FAB Widget dengan Flutter Hooks untuk Add/Edit Materi
class _FloatingActionButtonWidget extends HookWidget {
  final String uid;
  final bool isMateriEmpty;

  const _FloatingActionButtonWidget({
    required this.uid,
    required this.isMateriEmpty,
  });

  @override
  Widget build(BuildContext context) {
    // Form key dan controllers menggunakan Flutter Hooks
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final youtubeController = useTextEditingController();
    final materiController = useTextEditingController();

    // Effect untuk pre-fill form jika materi sudah ada
    useEffect(() {
      if (!isMateriEmpty) {
        final cubit = context.read<MateriCubit>();
        youtubeController.text = cubit.getYoutubeId();
        materiController.text = cubit.getMateriContent();
      }
      return null;
    }, [isMateriEmpty]);

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
                      Text(
                        isMateriEmpty ? "Tambah Materi" : "Edit Materi",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: youtubeController,
                        decoration: const InputDecoration(
                          labelText: "ID Youtube",
                          hintText: "Contoh: dQw4w9WgXcQ",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return "YouTube ID tidak boleh kosong";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: materiController,
                        decoration: const InputDecoration(
                          labelText: "Materi",
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 5,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return "Materi tidak boleh kosong";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      BlocBuilder<MateriCubit, MateriState>(
                        builder: (context, state) {
                          bool isLoading =
                              state is MateriCreating ||
                              state is MateriUpdating;

                          return SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: isLoading
                                  ? null
                                  : () {
                                      if (formKey.currentState!.validate()) {
                                        if (isMateriEmpty) {
                                          context
                                              .read<MateriCubit>()
                                              .createMateri(
                                                youtubeId:
                                                    youtubeController.text,
                                                materiContent:
                                                    materiController.text,
                                              );
                                        } else {
                                          context
                                              .read<MateriCubit>()
                                              .updateMateri(
                                                youtubeId:
                                                    youtubeController.text,
                                                materiContent:
                                                    materiController.text,
                                              );
                                        }

                                        if (!isLoading) {
                                          formKey.currentState!.reset();
                                          Navigator.pop(context);

                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                isMateriEmpty
                                                    ? "Berhasil menambah materi"
                                                    : "Berhasil mengedit materi",
                                              ),
                                              duration: const Duration(
                                                seconds: 2,
                                              ),
                                            ),
                                          );
                                        }
                                      }
                                    },
                              child: isLoading
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : Text(isMateriEmpty ? "TAMBAH" : "UPDATE"),
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
