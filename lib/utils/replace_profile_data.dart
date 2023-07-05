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

  Future<int> replaceRoleForVal(String roleVal) async {
    final masterData = await UseSharedPreferences.getUserDefaults('master');
    final encodeData = UseSharedPreferences.decodeMasterMap(masterData);
    final entrySkill = (encodeData["role"])?.entries.firstWhere(
        (entry) => entry.value == roleVal,
        orElse: () => MapEntry(roleVal, '5'));
    return entrySkill!.key;
  }

  Future<String> replacePhase(int roleType) async {
    final masterData = await UseSharedPreferences.getUserDefaults('master');
    final encodeData = UseSharedPreferences.decodeMasterMap(masterData);
    final entrySkill = (encodeData["phase"])?.entries.firstWhere(
        (entry) => entry.key == roleType,
        orElse: () => MapEntry(roleType, "その他"));
    return entrySkill!.value;
  }

  Future<int> replacePhaseForVal(String roleVal) async {
    final masterData = await UseSharedPreferences.getUserDefaults('master');
    final encodeData = UseSharedPreferences.decodeMasterMap(masterData);
    final entrySkill = (encodeData["phase"])?.entries.firstWhere(
        (entry) => entry.value == roleVal,
        orElse: () => MapEntry(roleVal, '10'));
    return entrySkill!.key;
  }

  String replaceYMDforJp(DateTime careerPeriod) {
    return '${careerPeriod.year}年${careerPeriod.month}月${careerPeriod.day}日';
  }

  Future<String> replaceOS(String os) async {
    final masterData = await UseSharedPreferences.getUserDefaults('master');
    final encodeData = UseSharedPreferences.decodeMasterMap(masterData);
    final entrySkill = (encodeData["developLanguageOS"])?.entries.firstWhere(
        (entry) => entry.key == os,
        orElse: () => MapEntry(os, "その他"));
    return entrySkill!.value;
  }

  Future<String> replaceOSForVal(String os) async {
    final masterData = await UseSharedPreferences.getUserDefaults('master');
    final encodeData = UseSharedPreferences.decodeMasterMap(masterData);
    final entrySkill = (encodeData["developLanguageOS"])?.entries.firstWhere(
        (entry) => entry.value == os,
        orElse: () => MapEntry(os, "その他"));
    return entrySkill!.key;
  }

  Future<String> replaceDB(String db) async {
    final masterData = await UseSharedPreferences.getUserDefaults('master');
    final encodeData = UseSharedPreferences.decodeMasterMap(masterData);
    final entrySkill = (encodeData["developLanguageDB"])?.entries.firstWhere(
        (entry) => entry.key == db,
        orElse: () => MapEntry(db, "その他"));
    return entrySkill!.value;
  }

  Future<String> replaceDBForVal(String db) async {
    final masterData = await UseSharedPreferences.getUserDefaults('master');
    final encodeData = UseSharedPreferences.decodeMasterMap(masterData);
    final entrySkill = (encodeData["developLanguageDB"])?.entries.firstWhere(
        (entry) => entry.value == db,
        orElse: () => MapEntry(db, "その他"));
    return entrySkill!.key;
  }

  Future<String> replaceSkill(String skill) async {
    final masterData = await UseSharedPreferences.getUserDefaults('master');
    final encodeData = UseSharedPreferences.decodeMasterMap(masterData);
    final entrySkill = (encodeData["developLanguageSkill"])?.entries.firstWhere(
        (entry) => entry.key == skill,
        orElse: () => MapEntry(skill, "その他"));
    return entrySkill!.value;
  }

  Future<String> replaceSkillForVal(String skill) async {
    final masterData = await UseSharedPreferences.getUserDefaults('master');
    final encodeData = UseSharedPreferences.decodeMasterMap(masterData);
    final entrySkill = (encodeData["developLanguageSkill"])?.entries.firstWhere(
        (entry) => entry.value == skill,
        orElse: () => MapEntry(skill, "その他"));
    return entrySkill!.key;
  }
}
