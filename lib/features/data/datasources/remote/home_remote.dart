import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/constant/db_structure.dart';
import '../../../../core/errors/failures.dart' show NotFoundFailure;
import '../../models/home_model.dart';

abstract class HomeRemoteDataSource {
  Future<HomeModel> home();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  /// Dapatkan instance Supabase client untuk operasi autentikasi
  final SupabaseClient _supabase;

  HomeRemoteDataSourceImpl({required SupabaseClient supabase})
    : _supabase = supabase;

  @override
  Future<HomeModel> home() async {
    final response = await _supabase
        .from(Db.luTable)
        .select(Db.luName)
        .eq(Db.luId, _supabase.auth.currentUser!.id);

    if (response.isEmpty) {
      throw NotFoundFailure('Tidak Ditemukan Nama Pengguna');
    }

    return HomeModel.fromJson(response.first);
  }
}
