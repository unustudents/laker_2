import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/constant/db_structure.dart';
import '../../../../core/errors/failures.dart' show NotFoundFailure;
import '../../models/profil_model.dart';

abstract class ProfilRemoteDataSource {
  Future<ProfilModel> profil();
}

class ProfilRemoteDataSourceImpl implements ProfilRemoteDataSource {
  /// Dapatkan instance Supabase client untuk operasi autentikasi
  final SupabaseClient _supabase;

  ProfilRemoteDataSourceImpl({required SupabaseClient supabase})
    : _supabase = supabase;

  @override
  Future<ProfilModel> profil() async {
    final response = await _supabase
        .from(Db.luTable)
        .select(
          "${Db.luName}, ${Db.luTempLahir}, ${Db.luDivisi}, ${Db.luWa}, ${Db.luEmail}",
        )
        .eq(Db.luId, _supabase.auth.currentUser!.id);
    print("[profil_remote] RESPONSE = $response");
    if (response.isEmpty) {
      throw NotFoundFailure('Tidak Ditemukan Nama Pengguna');
    }

    return ProfilModel.fromJson(response.first);
  }
}
