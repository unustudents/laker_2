import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/constant/db_structure.dart';
import '../../models/pretest_model.dart';

abstract class PretestRemoteDataSource {
  Future<List<PretestModel>> readSoal({required int idKategori});
  Future<UserAnswerModel> submitAnswer({required PretestOptionModel data});
}

class PretestRemoteDataSourceImpl implements PretestRemoteDataSource {
  final SupabaseClient _supabaseClient;

  PretestRemoteDataSourceImpl({required SupabaseClient supabaseClient})
    : _supabaseClient = supabaseClient;

  @override
  Future<List<PretestModel>> readSoal({required int idKategori}) async {
    // TODO : Ubah jika mau diberi filter berdasarkan kategori
    final records = await _supabaseClient
        .from(Db.lpTable)
        .select("${Db.lpId}, ${Db.lpSoal}, ${Db.lpKategori}")
        .eq(Db.lpKategori, idKategori);
    List<PretestModel> models = [];

    for (final record in records) {
      final options = await _supabaseClient
          .from(Db.lpoTable)
          .select(
            "${Db.lpoPilihan}, ${Db.lpoIsCorrect}, ${Db.lpoId}, ${Db.lpoIdPretest}, ${Db.lpoLabel}",
          )
          .eq(Db.lpoIdPretest, record[Db.lpId] as int)
          .order(Db.lpoId, ascending: true);

      final optionsList = options
          .map((opt) => PretestOptionModel.fromJson(opt))
          .toList();

      final model = PretestModel(
        id: record['id'] as int,
        soal: record['soal'] as String,
        kategori: record['kategori'] as int,
        options: optionsList,
      );

      models.add(model);
    }
    return models;
  }

  @override
  Future<UserAnswerModel> submitAnswer({
    required PretestOptionModel data,
  }) async {
    final dataAnswer = {
      Db.luaIdPretest: data.idPretest,
      Db.luaOption: data.pilihan,
      Db.luaIsCorrect: data.isCorrect,
      Db.luaUserId: _supabaseClient.auth.currentUser!.id,
    };

    final exist = await _supabaseClient
        .from(Db.luaTable)
        .select()
        .eq(Db.luaUserId, _supabaseClient.auth.currentUser!.id)
        .eq(Db.luaIdPretest, data.idPretest)
        .maybeSingle();

    // variable
    Map<String, dynamic> respon;

    // logika
    if (exist != null) {
      // User already answered → UPDATE
      final existingId = exist[Db.luaId].toString();

      respon = await _supabaseClient
          .from(Db.luaTable)
          .update(dataAnswer)
          .eq(Db.luaId, existingId) // ✅ WHERE clause by ID
          .select()
          .single();
    } else {
      // First time answering → INSERT
      respon = await _supabaseClient
          .from(Db.luaTable)
          .insert(dataAnswer)
          .select()
          .single();
    }
    return UserAnswerModel.fromJson(respon);
  }
}
