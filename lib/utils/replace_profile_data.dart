class ReplaceProfileData {
  static String replaceSex(int sex) {
    switch (sex) {
      case 1:
        return '男';
      case 2:
        return '女';
      case 3:
        return 'LGBTQ';
      default:
        return 'その他';
    }
  }

  static String replaceContractType(int contractType) {
    switch (contractType) {
      case 1:
        return '正社員';
      case 2:
        return '契約社員';
      default:
        return 'その他';
    }
  }

  static String replaceRole(int roleType) {
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
