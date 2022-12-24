import 'package:resume_app/model/technical_db.dart';
import 'package:resume_app/model/technical_os.dart';
import 'package:resume_app/model/technical_skill.dart';

class JobCareer {
  /// 職務経歴ID
  final int careerId;

  /// 参画期間From
  final DateTime careerPeriodFrom;

  /// 参画期間To
  final DateTime careerPeriodTo;

  /// 作業内容
  final String content;

  /// 担当フェーズ
  final String phaseInCharge;

  /// 役割
  final int role;

  /// OS経歴
  final List<TechnicalOS>? usedTechnicalOSList;

  /// 使用言語
  final List<TechnicalSkill>? usedTechnicalSkillList;

  /// DB経歴
  final List<TechnicalDB>? usedTechnicalDBList;

  const JobCareer({
    required this.careerId,
    required this.careerPeriodFrom,
    required this.careerPeriodTo,
    required this.content,
    required this.phaseInCharge,
    required this.role,
    this.usedTechnicalOSList,
    this.usedTechnicalSkillList,
    this.usedTechnicalDBList,
  });
}
