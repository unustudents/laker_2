class DbStructure {
  // Table Names
  static const String luTable = 'l_users';
  static const String puaTable = 'p_user_answer';
  static const String pqTable = 'p_quis';
  static const String pqcTable = 'p_quis_category';
  static const String pqoTable = 'p_quis_options';

  // Users Table Columns
  static const String luId = 'id';
  static const String luEmail = 'email';
  static const String luName = 'name';
  static const String luCreatedAt = 'created_at';
  static const String luTempLahir = 'temp_lahir';
  static const String luDivisi = 'divisi';
  static const String luWa = 'wa';

  // User Answer Table Columns
  static const String puaId = 'id';
  static const String puaUserId = 'user_id';
  static const String puaQuisId = 'quis_id';
  static const String puaSelected = 'selected_option';
  static const String puaCorrect = 'is_correct';
  static const String puaScore = 'score';
  static const String puaCreatedAt = 'created_at';

  // Quis Table Columns
  static const String pqId = 'id';
  static const String pqQuestion = 'question';
  static const String pqCategory = 'category_id';
  static const String pqPoints = 'points';
  static const String pqImage = 'image';
  static const String pqCreatedAt = 'created_at';

  // Quis Category Table Columns
  static const String pqcId = 'id';
  static const String pqcName = 'name';
  static const String pqcCreatedAt = 'created_at';

  // Quis Options Table Columns
  static const String pqoId = 'id';
  static const String pqoQuisId = 'quis_id';
  static const String pqoLabel = 'label';
  static const String pqoText = 'text';
  static const String pqoIsCorrect = 'is_correct';
  static const String pqoCreatedAt = 'created_at';

  // User Score Table Columns
  static const String rpcSumUserScore = 'sum_user_score';
  static const String rpcSUSuserId = 'user_uuid';
  static const String rpcSumAllUserScores = 'sum_all_user_scores';
}
