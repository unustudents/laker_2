# laker_2

Versi bloc

## domain
- entities/: Tentukan entitas inti atau model data untuk aplikasi Anda. Entitas ini harus berupa kelas Dart murni tanpa ketergantungan pada kerangka kerja eksternal.
- repositories/: (abstrak) Buat kelas yang menangani logika bisnis dan komunikasi dengan lapisan data. Repositori ini akan bertindak sebagai perantara antara entitas dan sumber data eksternal.
- use_cases/: Definisikan use case atau interaksi pengguna dengan aplikasi. Setiap use case harus berupa kelas yang melakukan satu tugas spesifik dan menggunakan repositori untuk mendapatkan atau memperbarui data.
- providers/: Buat penyedia data yang akan menangani komunikasi dengan sumber data eksternal seperti API, database, atau layanan lainnya. Penyedia ini harus diimplementasikan sebagai kelas yang dapat digunakan oleh repositori.

## data
- models/:
- datasource/:
- repositories/: (implementasi)