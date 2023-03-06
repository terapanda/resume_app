import 'package:resume_app/provider/user_state.dart';

const String systemAdmin = "システム管理者";
const String admin = "管理者";
const String user = "システム管理者";

/// システム管理者以上を許可
bool allowSystemAdmin(ref) {
  final personData = ref.read(personStreamProvider);
  final masterData = ref.read(masterDataProvider);
  var systemAdminKey = masterData.value["authority"].keys.firstWhere(
      (key) => masterData.value["authority"][key] == systemAdmin,
      orElse: () => 3);

  return [systemAdminKey].contains(personData.value.authority);
}

/// 管理者以上を許可
bool allowAdmin(ref) {
  final personData = ref.read(personStreamProvider);
  final masterData = ref.read(masterDataProvider);
  var systemAdminKey = masterData.value["authority"].keys.firstWhere(
      (key) => masterData.value["authority"][key] == systemAdmin,
      orElse: () => 3);
  var adminKey = masterData.value["authority"].keys.firstWhere(
      (key) => masterData.value["authority"][key] == admin,
      orElse: () => 3);

  return [systemAdminKey, adminKey].contains(personData.value.authority);
}

/// ユーザ以上を許可
bool allowUser(ref) {
  final personData = ref.read(personStreamProvider);
  final masterData = ref.read(masterDataProvider);
  var systemAdminKey = masterData.value["authority"].keys.firstWhere(
      (key) => masterData.value["authority"][key] == systemAdmin,
      orElse: () => 3);
  var adminKey = masterData.value["authority"].keys.firstWhere(
      (key) => masterData.value["authority"][key] == admin,
      orElse: () => 3);
  var userKey = masterData.value["authority"].keys.firstWhere(
      (key) => masterData.value["authority"][key] == user,
      orElse: () => 3);

  return [systemAdminKey, adminKey, userKey]
      .contains(personData.value.authority);
}

/// （システム管理者と）ユーザを許可
bool allowUserOnly(ref) {
  final personData = ref.read(personStreamProvider);
  final masterData = ref.read(masterDataProvider);
  var systemAdminKey = masterData.value["authority"].keys.firstWhere(
      (key) => masterData.value["authority"][key] == systemAdmin,
      orElse: () => 3);
  var userKey = masterData.value["authority"].keys.firstWhere(
      (key) => masterData.value["authority"][key] == user,
      orElse: () => 3);

  return [systemAdminKey, userKey].contains(personData.value.authority);
}
