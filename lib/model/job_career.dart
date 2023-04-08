import 'package:resume_app/model/technical_db.dart';
import 'package:resume_app/model/technical_os.dart';
import 'package:resume_app/model/technical_skill.dart';

class JobCareer {
  /// 職務経歴ID
  late int careerId;

  /// 参画期間From
  late DateTime careerPeriodFrom;

  /// 参画期間To
  late DateTime careerPeriodTo;

  /// 作業内容
  late String content;

  /// 担当フェーズ
  late List<String> phase;

  /// 役割
  late String role;

  /// OS経歴
  late List<TechnicalOS>? usedTechnicalOSList;

  /// 使用言語
  late List<TechnicalSkill>? usedTechnicalSkillList;

  /// DB経歴
  late List<TechnicalDB>? usedTechnicalDBList;

  JobCareer({
    required this.careerId,
    required this.careerPeriodFrom,
    required this.careerPeriodTo,
    required this.content,
    required this.phase,
    required this.role,
    this.usedTechnicalOSList,
    this.usedTechnicalSkillList,
    this.usedTechnicalDBList,
  });
}
