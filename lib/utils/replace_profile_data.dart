import 'package:resume_app/utils/use_shared_preferences.dart';

class ReplaceProfileData {
  String replaceSex(int val) {
    final masterData = UseSharedPreferences.getUserDefaults('master');
    return masterData["sex"]?.keys.firstWhere(
        (key) => masterData["sex"]?[key] == val,
        orElse: () => "その他");
  }

  String replaceContractType(int contractType) {
    final masterData = UseSharedPreferences.getUserDefaults('master');
    switch (contractType) {
      case 1:
        return '正社員';
      case 2:
        return '契約社員';
      default:
        return 'その他';
    }
  }

  String replaceRole(int roleType) {
    switch (roleType) {
      case 1:
        return 'PM';
      case 2:
        return 'PL';
      case 3:
        return 'SE';
      case 4:
        return 'PG';
      case 5:
        return 'テスター';
      default:
        return 'その他';
    }
  }
}
