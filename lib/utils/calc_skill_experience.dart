class CalcSkillExperience {
  static String calcSkillExperience(double skillExperience) {
    var experienceYear = (skillExperience / 12).floor();
    var experienceMonth = (skillExperience - (experienceYear * 12)).floor();

    if (experienceYear == 0) {
      return '${experienceMonth}ヶ月';
    }

    if (experienceMonth.floor() == 0) {
      return '${experienceYear}年';
    }

    return '${experienceYear}年 ${experienceMonth}ヶ月';
  }
}
