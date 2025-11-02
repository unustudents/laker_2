class Kategori {
  static final List<Map<String, String>> optionKategori = [
    {"title": "MAPABA", "subtitle": "Masa Penerimaan Anggota Baru"},
    {"title": "PKD", "subtitle": "Pelatihan Kader Dasar"},
    {"title": "PKL", "subtitle": "Pelatihan Kader Lanjut"},
  ];

  static final List<Map<String, String>> optionProfil = [
    {"title": "VISI & MISI PMII", "subtitle": "Latihan Dasar Kepemimpinan"},
    {"title": "SEJARAH PMII", "subtitle": "Masa Penerimaan Anggota Baru"},
    {"title": "ARSIP", "subtitle": "Arsip PMII"},
  ];

  static final List<Map<String, dynamic>> subcategoryMapaba = [
    {"id": 1, "title": "KE - PMII - AN"},
    {"id": 2, "title": "ASWAJA MANHAJUL FIKR"},
    {"id": 3, "title": "NILAI DASAR PERGERAKAN"},
  ];
  static final List<Map<String, dynamic>> subcategoryPKD = [
    {"id": 4, "title": "ASWAJA MANHAJUL HARAKAH"},
    {"id": 5, "title": "PARADIGMA PMII"},
    {"id": 6, "title": "PETA PEMIKIRAN ISLAM"},
  ];
  static final List<Map<String, dynamic>> subcategoryPKL = [
    {"id": 7, "title": "STRATEGI PENGEMBAN PMII"},
    {"id": 8, "title": "ANSOS (ANALISIS SOSIAL)"},
    {"id": 9, "title": "STRATEGI PLANNING & STRATEGI MANAGEMENT"},
  ];
}
