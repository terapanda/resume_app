import 'package:resume_app/utils/use_shared_preferences.dart';

class ReplaceProfileData {
  String replaceSex(int val) {
    final masterData = UseSharedPreferences.getUserDefaults('master');
    final encodeData = UseSharedPreferences.decodeMasterMap(masterData);
    return encodeData["sex"]?.keys.firstWhere(
        (key) => encodeData["sex"]?[key] == val,
        orElse: () => "その他") as String;
  }

  String replaceContractType(int contractType) {
    final masterData = UseSharedPreferences.getUserDefaults('master');
    final encodeData = UseSharedPreferences.decodeMasterMap(masterData);
    return encodeData["contractForm"]?.keys.firstWhere(
        (key) => encodeData["contractForm"]?[key] == contractType,
        orElse: () => "その他") as String;
  }

  String replaceRole(int roleType) {
    final masterData = UseSharedPreferences.getUserDefaults('master');
    final encodeData = UseSharedPreferences.decodeMasterMap(masterData);
    return encodeData["role"]?.keys.firstWhere(
        (key) => masterData["role"]?[key] == roleType,
        orElse: () => "その他") as String;
  }
}
