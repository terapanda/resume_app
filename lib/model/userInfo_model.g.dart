// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userInfo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserInfo _$$_UserInfoFromJson(Map<String, dynamic> json) => _$_UserInfo(
      nameFirst: json['nameFirst'] as String,
      nameLast: json['nameLast'] as String,
      rubyFirst: json['rubyFirst'] as String,
      rubyLast: json['rubyLast'] as String,
      favoriteSkill: (json['favoriteSkill'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      initial: json['initial'] as String?,
      sex: json['sex'] as int,
      birthDay: DateTime.parse(json['birthDay'] as String),
      contractType: json['contractType'] as int?,
      description: json['description'] as String?,
      station: json['station'] as String?,
      image: json['image'] as String?,
      branchOffice: json['branchOffice'] as int?,
      department: json['department'] as int?,
      experience: json['experience'] as int?,
      authority: json['authority'] as int,
      isProgrammer: json['isProgrammer'] as bool,
      updateDate: DateTime.parse(json['updateDate'] as String),
      technicalOSList: (json['technicalOSList'] as List<dynamic>?)
          ?.map((e) => TechnicalOS.fromJson(e as Map<String, dynamic>))
          .toList(),
      technicalSkillList: (json['technicalSkillList'] as List<dynamic>?)
          ?.map((e) => TechnicalSkill.fromJson(e as Map<String, dynamic>))
          .toList(),
      technicalDBList: (json['technicalDBList'] as List<dynamic>?)
          ?.map((e) => TechnicalDB.fromJson(e as Map<String, dynamic>))
          .toList(),
      jobCareerList: (json['jobCareerList'] as List<dynamic>?)
          ?.map((e) => JobCareer.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_UserInfoToJson(_$_UserInfo instance) =>
    <String, dynamic>{
      'nameFirst': instance.nameFirst,
      'nameLast': instance.nameLast,
      'rubyFirst': instance.rubyFirst,
      'rubyLast': instance.rubyLast,
      'favoriteSkill': instance.favoriteSkill,
      'initial': instance.initial,
      'sex': instance.sex,
      'birthDay': instance.birthDay.toIso8601String(),
      'contractType': instance.contractType,
      'description': instance.description,
      'station': instance.station,
      'image': instance.image,
      'branchOffice': instance.branchOffice,
      'department': instance.department,
      'experience': instance.experience,
      'authority': instance.authority,
      'isProgrammer': instance.isProgrammer,
      'updateDate': instance.updateDate.toIso8601String(),
      'technicalOSList': instance.technicalOSList,
      'technicalSkillList': instance.technicalSkillList,
      'technicalDBList': instance.technicalDBList,
      'jobCareerList': instance.jobCareerList,
    };

_$_TechnicalOS _$$_TechnicalOSFromJson(Map<String, dynamic> json) =>
    _$_TechnicalOS(
      osId: json['osId'] as String?,
      month: json['month'] as int?,
    );

Map<String, dynamic> _$$_TechnicalOSToJson(_$_TechnicalOS instance) =>
    <String, dynamic>{
      'osId': instance.osId,
      'month': instance.month,
    };

_$_TechnicalSkill _$$_TechnicalSkillFromJson(Map<String, dynamic> json) =>
    _$_TechnicalSkill(
      skillId: json['skillId'] as String?,
      month: json['month'] as int?,
    );

Map<String, dynamic> _$$_TechnicalSkillToJson(_$_TechnicalSkill instance) =>
    <String, dynamic>{
      'skillId': instance.skillId,
      'month': instance.month,
    };

_$_TechnicalDB _$$_TechnicalDBFromJson(Map<String, dynamic> json) =>
    _$_TechnicalDB(
      dbId: json['dbId'] as String?,
      month: json['month'] as int?,
    );

Map<String, dynamic> _$$_TechnicalDBToJson(_$_TechnicalDB instance) =>
    <String, dynamic>{
      'dbId': instance.dbId,
      'month': instance.month,
    };

_$_JobCareer _$$_JobCareerFromJson(Map<String, dynamic> json) => _$_JobCareer(
      careerId: json['careerId'] as int?,
      careerPeriodFrom: json['careerPeriodFrom'] == null
          ? null
          : DateTime.parse(json['careerPeriodFrom'] as String),
      careerPeriodTo: json['careerPeriodTo'] == null
          ? null
          : DateTime.parse(json['careerPeriodTo'] as String),
      content: json['content'] as String?,
      phase: (json['phase'] as List<dynamic>?)?.map((e) => e as int).toList(),
      role: json['role'] as int?,
      usedTechnicalOSList: (json['usedTechnicalOSList'] as List<dynamic>?)
          ?.map((e) => TechnicalOS.fromJson(e as Map<String, dynamic>))
          .toList(),
      usedTechnicalSkillList: (json['usedTechnicalSkillList'] as List<dynamic>?)
          ?.map((e) => TechnicalSkill.fromJson(e as Map<String, dynamic>))
          .toList(),
      usedTechnicalDBList: (json['usedTechnicalDBList'] as List<dynamic>?)
          ?.map((e) => TechnicalDB.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_JobCareerToJson(_$_JobCareer instance) =>
    <String, dynamic>{
      'careerId': instance.careerId,
      'careerPeriodFrom': instance.careerPeriodFrom?.toIso8601String(),
      'careerPeriodTo': instance.careerPeriodTo?.toIso8601String(),
      'content': instance.content,
      'phase': instance.phase,
      'role': instance.role,
      'usedTechnicalOSList': instance.usedTechnicalOSList,
      'usedTechnicalSkillList': instance.usedTechnicalSkillList,
      'usedTechnicalDBList': instance.usedTechnicalDBList,
    };
