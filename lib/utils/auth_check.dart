/// システム管理者以上を許可
bool allowSystemAdmin(userstate) {
  return 1 == userstate["authority"];
}

/// 管理者以上を許可
bool allowAdmin(userstate) {
  return 1 == userstate["authority"] || 2 == userstate["authority"];
}

/// ユーザ以上を許可
bool allowUser(userstate) {
  return 1 == userstate["authority"] ||
      2 == userstate["authority"] ||
      3 == userstate["authority"];
}

/// （システム管理者と）ユーザを許可
bool allowUserOnly(userstate) {
  return 1 == userstate["authority"] || 3 == userstate["authority"];
}
