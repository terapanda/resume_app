import 'package:resume_app/model/job_career.dart';
import 'package:resume_app/model/technical_db.dart';
import 'package:resume_app/model/technical_os.dart';
import 'package:resume_app/model/technical_skill.dart';

class Person {
  /// 社員番号
  final int id;

  /// 名前
  final String name;

  /// かな
  final String ruby;

  /// 得意言語
  final List<String> excelsAt;

  /// イニシャル
  final String initial;

  /// 性別
  final int sex;

  /// 年齢
  final int age;

  /// 契約形態
  final int contractType;

  /// 概要・自己PR
  final String description;

  /// 駅
  final String station;

  /// 写真
  final String image;

  /// 経験年数
  final int experience;

  /// 最終更新時刻
  final DateTime lastUpdateDate;

  /// OS経歴
  final List<TechnicalOS>? technicalOSList;

  /// 言語経歴
  final List<TechnicalSkill>? technicalSkillList;

  /// DB経歴
  final List<TechnicalDB>? technicalDBList;

  /// 職務経歴
  final List<JobCareer>? jobCareerList;

  const Person({
    required this.id,
    required this.name,
    required this.ruby,
    required this.excelsAt,
    required this.initial,
    required this.sex,
    required this.age,
    required this.contractType,
    required this.description,
    required this.station,
    required this.image,
    required this.experience,
    required this.lastUpdateDate,
    this.technicalOSList,
    this.technicalSkillList,
    this.technicalDBList,
    this.jobCareerList,
  });
}
