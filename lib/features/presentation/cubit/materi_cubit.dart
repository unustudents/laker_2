// ============================================================================
// KONVERSI DARI GETX KE CUBIT
// ============================================================================
// Perubahan:
// 1. MateriController extends GetxController → MateriCubit extends Cubit
// 2. Rx<T> (reactive) → State management dengan emit()
// 3. readData.obs → state.materi
// 4. youtube.value & materi.value → TextEditingController dari hooks
// 5. ytPlayer → YoutubePlayerController initialization di hooks
// 6. funReadMateri() → loadMateri()
// 7. funCreateMateri() → createMateri()
// 8. funUpdateMateri() → updateMateri()
// 9. onInit/onReady → initialize()
// 10. onClose() → handled by hooks disposal
// ============================================================================

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'materi_state.dart';

// TODO: Import YouTube player dan Firebase provider
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
// import '../../../domain/provider/materi_provider.dart';
// import '../../../domain/model/model_model.dart';

class MateriCubit extends Cubit<MateriState> {
  MateriCubit() : super(const MateriInitial());

  late String uid;
  // ignore: unused_field
  static const String _collectionName = "materi";

  /// Initialize dengan uid dari navigasi
  void initialize(String userId) {
    uid = userId;
    loadMateri();
  }

  /// Load materi dari Firebase Firestore
  Future<void> loadMateri() async {
    try {
      emit(const MateriLoading());

      // TODO: Ganti dengan actual Firebase provider
      // var data = await readMateri(uid);
      // if (data.isNotEmpty) {
      //   String youtubeId = data["youtube"] ?? "";
      //   emit(MateriLoaded(
      //     materi: data,
      //     youtubeId: youtubeId,
      //   ));
      // } else {
      //   emit(const MateriLoaded(
      //     materi: {},
      //     youtubeId: "",
      //   ));
      // }

      // Placeholder: empty materi untuk testing
      emit(const MateriLoaded(materi: {}, youtubeId: ""));
    } catch (e) {
      emit(MateriError(message: e.toString()));
    }
  }

  /// Buat materi baru
  Future<void> createMateri({
    required String youtubeId,
    required String materiContent,
  }) async {
    try {
      emit(const MateriCreating());

      // TODO: Ganti dengan actual Firebase provider
      // bool result = await createMateri(
      //   uid: uid,
      //   data: Materi(
      //     youtube: youtubeId,
      //     materi: materiContent,
      //   ),
      // );

      // Placeholder: selalu true untuk testing
      bool result = true;

      if (result) {
        // Reload materi setelah berhasil
        await loadMateri();
      }
    } catch (e) {
      emit(MateriError(message: e.toString()));
    }
  }

  /// Update materi yang sudah ada
  Future<void> updateMateri({
    required String youtubeId,
    required String materiContent,
  }) async {
    try {
      emit(const MateriUpdating());

      // TODO: Ganti dengan actual Firebase provider
      // bool result = await updateMateri(
      //   uid: uid,
      //   data: Materi(
      //     youtube: youtubeId,
      //     materi: materiContent,
      //   ),
      // );

      // Placeholder: selalu true untuk testing
      bool result = true;

      if (result) {
        // Reload materi setelah berhasil
        await loadMateri();
      }
    } catch (e) {
      emit(MateriError(message: e.toString()));
    }
  }

  /// Helper: Check apakah materi kosong
  bool isMateriEmpty() {
    final currentState = state;
    if (currentState is! MateriLoaded) return true;
    return currentState.materi.isEmpty;
  }

  /// Helper: Get materi content
  String getMateriContent() {
    final currentState = state;
    if (currentState is! MateriLoaded) return "";
    return currentState.materi["materi"] ?? "";
  }

  /// Helper: Get youtube ID
  String getYoutubeId() {
    final currentState = state;
    if (currentState is! MateriLoaded) return "";
    return currentState.youtubeId;
  }
}
