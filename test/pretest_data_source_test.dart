import 'package:flutter_test/flutter_test.dart';
import 'package:laker_2/core/constant/db_structure.dart';
import 'package:laker_2/core/constant/env_config.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 1. GANTI DENGAN IMPORT FILE 'Db' ANDA
// import 'package:YOUR_APP/path/to/db_structure.dart';

// 2. ATAU, UNTUK SEMENTARA, DEFINISIKAN KONSTANTA DI SINI
// Pastikan nilainya SAMA PERSIS dengan di database

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // 3. GANTI DENGAN URL DAN KUNCI ANDA
  const supabaseUrl = EnvConfig.supabaseUrl;
  const supabaseAnonKey = EnvConfig.supabaseAnonKey;

  late SupabaseClient supabaseClient;

  setUpAll(() async {
    print("Mencoba terhubung ke Supabase...");
    try {
      SharedPreferences.setMockInitialValues({});

      await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);

      supabaseClient = Supabase.instance.client;
      print("✅ Berhasil terhubung ke Supabase.");
    } catch (e) {
      print("❌ GAGAL inisialisasi di setUpAll: $e");
      throw Exception('Gagal setup Supabase: $e');
    }
  });

  // INI ADALAH TES YANG FOKUS PADA SATU PANGGILAN
  testWidgets('Tes panggilan SELECT ke tabel lpTable', (
    WidgetTester tester,
  ) async {
    print("\nMemulai tes SELECT ke ${Db.lpTable}...");

    try {
      // ---------------------------------------------------
      // HANYA INI KODE YANG KITA TES
      // ---------------------------------------------------
      final records = await supabaseClient
          .from(Db.lpTable)
          .select("${Db.lpId}, ${Db.lpSoal}, ${Db.lpKategori}");
      // ---------------------------------------------------

      // Jika berhasil, cetak hasilnya
      print("✅ BERHASIL! Panggilan pertama sukses.");
      print("Total data ditemukan: ${records.length}");
      if (records.isNotEmpty) {
        print("Contoh data pertama: ${records.first}");
      } else {
        print("NOTE: Panggilan sukses, tapi tabel kosong (tidak ada data).");
      }

      // Tes dianggap lolos jika tidak melempar error
      expect(records, isA<List<Map<String, dynamic>>>());
    } catch (e) {
      print("\n❌ GAGAL! Terjadi error Postgrest:");
      print("==================================================");
      print(e);
      print("==================================================");
      print("CEK KEMBALI:");
      print("1. Nama Tabel: '${Db.lpTable}' (Pastikan ada di Supabase)");
      print(
        "2. Nama Kolom: '${Db.lpId}', '${Db.lpSoal}', '${Db.lpKategori}' (Pastikan tidak typo)",
      );
      print(
        "3. RLS (Row Level Security) untuk tabel '${Db.lpTable}' (Pastikan policy SELECT ada untuk 'anon')",
      );
      fail("Tes gagal karena exception: $e");
    }
  });
}
