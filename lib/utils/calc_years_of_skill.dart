class CalcMonth {
  static String calcMonth(int month) {
    var experienceYear = (month / 12).floor();
    var experienceMonth = (month - (experienceYear * 12)).floor();

    if (experienceYear == 0) {
      return '${experienceMonth}ヶ月';
    }

    if (experienceMonth.floor() == 0) {
      return '${experienceYear}年';
    }

    return '${experienceYear}年 ${experienceMonth}ヶ月';
  }
}
