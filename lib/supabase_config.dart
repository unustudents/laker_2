import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/constant/env_config.dart';

export 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static Future<void> initialize() async {
    try {
      await Supabase.initialize(
        url: EnvConfig.supabaseUrl,
        anonKey: EnvConfig.supabaseAnonKey,
      );
    } catch (e) {
      // print("Error initializing Supabase: $e");
      // kalo engga dapet, maka lari ke tampilan blank putih dan ada tulisan server sedang dalam perbaikan
      rethrow;
    }
  }

  static SupabaseClient get client => Supabase.instance.client;
}
