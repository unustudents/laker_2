import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/constant/db_structure.dart';
import '../../models/signup_model.dart';

/// Abstract class untuk remote data source signup
abstract class SignupRemoteDataSource {
  /// Register user baru dengan email dan password
  Future<AuthResponse> signup(SignupModel model);
}

/// Implementation dari SignupRemoteDataSource menggunakan Supabase
class SignupRemoteDataSourceImpl implements SignupRemoteDataSource {
  final SupabaseClient _supabaseClient;

  SignupRemoteDataSourceImpl({required SupabaseClient client})
    : _supabaseClient = client;

  @override
  Future<AuthResponse> signup(SignupModel model) async {
    final response = await _supabaseClient.auth.signUp(
      email: model.email,
      password: model.password,
    );
    final userId = response.user?.id;
    if (userId != null) {
      await _supabaseClient.from(DbStructure.luTable).insert({
        DbStructure.luName: model.name,
        DbStructure.luEmail: model.email,
        DbStructure.luDivisi: model.divisi,
        DbStructure.luTempLahir: model.tempLahir,
        DbStructure.luWa: model.wa,
      });
    }
    return response;
  }
}
