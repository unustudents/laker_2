import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/constant/db_structure.dart';
import '../../models/pretest_model.dart';

abstract class PretestRemoteDataSource {
  Future<List<PretestModel>> readSoal({required int idKategori});
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
}
