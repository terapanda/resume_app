import 'package:resume_app/model/technical_skill.dart';

class Person {
  final String id;
  final String name;
  final String ruby;
  final List<String> excelsAt;
  final String initial;
  final String sex;
  final String age;
  final String station;
  final String image;
  final int experience;
  final List<TechnicalSkill> technicalSkill;

  const Person({
    required this.id, // 社員番号
    required this.name, // 名前
    this.ruby = '', // かな
    required this.excelsAt,
    required this.initial, // イニシャル
    required this.sex, // 性別
    required this.age, // 年齢
    required this.station, // 駅
    required this.image, // 写真
    required this.experience, // 経験年数
    required this.technicalSkill, // 言語経歴
  });
}
