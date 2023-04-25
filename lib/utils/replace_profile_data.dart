import 'package:resume_app/utils/use_shared_preferences.dart';

class ReplaceProfileData {
  Future<String> replaceSex(int val) async {
    final masterData = await UseSharedPreferences.getUserDefaults('master');
    final encodeData = UseSharedPreferences.decodeMasterMap(masterData);
    final entrySkill = (encodeData["sex"])?.entries.firstWhere(
        (entry) => entry.key == val,
        orElse: () => MapEntry(val, "その他"));
    return entrySkill!.value;
  }

  Future<String> replaceContractType(int contractType) async {
    final masterData = await UseSharedPreferences.getUserDefaults('master');
    final encodeData = UseSharedPreferences.decodeMasterMap(masterData);
    final entrySkill = (encodeData["contractForm"])?.entries.firstWhere(
        (entry) => entry.key == contractType,
        orElse: () => MapEntry(contractType, "その他"));
    return entrySkill!.value;
  }

  Future<String> replaceRole(int roleType) async {
    final masterData = await UseSharedPreferences.getUserDefaults('master');
    final encodeData = UseSharedPreferences.decodeMasterMap(masterData);
    final entrySkill = (encodeData["role"])?.entries.firstWhere(
        (entry) => entry.key == roleType,
        orElse: () => MapEntry(roleType, "その他"));
    return entrySkill!.value;
  }

  String replaceYMDforJp(DateTime careerPeriod) {
    return '${careerPeriod.year}年${careerPeriod.month}月${careerPeriod.day}日';
  }
}
