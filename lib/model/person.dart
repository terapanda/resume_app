import 'package:resume_app/model/job_career.dart';
import 'package:resume_app/model/technical_db.dart';
import 'package:resume_app/model/technical_os.dart';
import 'package:resume_app/model/technical_skill.dart';

class Person {
  /// 社員番号
  late final String id;

  /// 部署
  late String department;

  /// 支社
  late String? branchOffice;

  /// 名前
  late String name;

  /// かな
  late String ruby;

  /// 得意言語
  late List<String> favoriteSkill;

  /// イニシャル
  late String initial;

  /// 性別
  late int sex;

  /// 誕生日
  late DateTime birthDay;

  /// 年齢
  late int age;

  /// 契約形態
  late int contractType;

  /// 概要・自己PR
  late String description;

  /// 駅
  late String station;

  /// 写真
  late String image;

  /// 経験年数
  late int experience;

  /// 最終更新時刻
  late DateTime updateDate;

  /// OS経歴
  late List<TechnicalOS>? technicalOSList;

  /// 言語経歴
  late List<TechnicalSkill>? technicalSkillList;

  /// DB経歴
  late List<TechnicalDB>? technicalDBList;

  /// 職務経歴
  late List<JobCareer>? jobCareerList;

  /// 権限
  late int authority;

  /// プログラマーフラグ
  late bool isProgrammer;

  Person({
    required this.id,
    required this.department,
    this.branchOffice,
    required this.name,
    required this.ruby,
    required this.favoriteSkill,
    required this.initial,
    required this.sex,
    required this.birthDay,
    required this.age,
    required this.contractType,
    required this.description,
    required this.station,
    required this.image,
    required this.experience,
    required this.updateDate,
    this.technicalOSList,
    this.technicalSkillList,
    this.technicalDBList,
    this.jobCareerList,
    required this.authority,
    required this.isProgrammer,
  });
}
