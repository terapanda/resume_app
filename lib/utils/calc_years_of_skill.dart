class CalcMonthOfSkill {
  static String calcMonthOfSkill(int monthOfSkill) {
    var experienceYear = (monthOfSkill / 12).floor();
    var experienceMonth = (monthOfSkill - (experienceYear * 12)).floor();

    if (experienceYear == 0) {
      return '${experienceMonth}ヶ月';
    }

    if (experienceMonth.floor() == 0) {
      return '${experienceYear}年';
    }

    return '${experienceYear}年 ${experienceMonth}ヶ月';
  }
}
