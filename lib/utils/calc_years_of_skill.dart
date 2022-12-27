class CalcYearsOfSkill {
  static String calcYearsOfSkill(double yearsOfSkill) {
    var experienceYear = (yearsOfSkill / 12).floor();
    var experienceMonth = (yearsOfSkill - (experienceYear * 12)).floor();

    if (experienceYear == 0) {
      return '${experienceMonth}ヶ月';
    }

    if (experienceMonth.floor() == 0) {
      return '${experienceYear}年';
    }

    return '${experienceYear}年 ${experienceMonth}ヶ月';
  }
}
