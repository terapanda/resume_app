import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'userInfo_model.freezed.dart';
part 'userInfo_model.g.dart';

@freezed
abstract class UserInfo with _$UserInfo {
  const UserInfo._();

  const factory UserInfo({
    /// 社員番号
    // required String id,

    /// 名前
    required String nameFirst,
    required String nameLast,

    /// かな
    required String rubyFirst,
    required String rubyLast,

    /// 得意言語
    List<String>? favoriteSkill,

    /// イニシャル
    String? initial,

    /// 性別
    required int sex,

    /// 年齢
    required DateTime birthDay,

    /// 契約形態
    int? contractType,

    /// 概要・自己PR
    String? description,

    /// 駅
    String? station,

    /// 写真
    String? image,

    /// 支社名
    int? branchOffice,

    /// 部署名
    int? department,

    /// 経験年数
    int? experience,
    required int authority,
    required bool isProgrammer,

    /// 最終更新時刻
    required DateTime updateDate,

    /// OS経歴
    List<TechnicalOS>? technicalOSList,

    /// 言語経歴
    List<TechnicalSkill>? technicalSkillList,

    /// DB経歴
    List<TechnicalDB>? technicalDBList,

    /// 職務経歴
    List<JobCareer>? jobCareerList,
  }) = _UserInfo;

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);

  // ドキュメントのスナップショットを変換するために利用
  // factory UserInfo.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc) {
  //   final data = doc.data()!;
  //   // doc.idがitemIDのため、copyWithでIDをモデルにコピーする
  //   return UserInfo.fromJson(data).copyWith(id: doc.id);
  // }

  // アイテムモデルをMap<String, dynamic>に変換するメソッド
  Map<String, dynamic> toDocument() => toJson()..remove('id');
}

@freezed
class TechnicalOS with _$TechnicalOS {
  const factory TechnicalOS({
    /// OSID
    String? osId,

    /// OS経験年月
    int? month,
  }) = _TechnicalOS;
  factory TechnicalOS.fromJson(Map<String, dynamic> json) =>
      _$TechnicalOSFromJson(json);
}

@freezed
class TechnicalSkill with _$TechnicalSkill {
  const factory TechnicalSkill({
    /// 言語ID
    String? skillId,

    /// 経験年数
    int? month,
  }) = _TechnicalSkill;
  factory TechnicalSkill.fromJson(Map<String, dynamic> json) =>
      _$TechnicalSkillFromJson(json);
}

@freezed
class TechnicalDB with _$TechnicalDB {
  const factory TechnicalDB({
    /// データベースID
    String? dbId,

    /// データベース経験年月
    int? month,
  }) = _TechnicalDB;
  factory TechnicalDB.fromJson(Map<String, dynamic> json) =>
      _$TechnicalDBFromJson(json);
}

@freezed
class JobCareer with _$JobCareer {
  const factory JobCareer({
    /// 職務経歴ID
    int? careerId,

    /// 参画期間From
    DateTime? careerPeriodFrom,

    /// 参画期間To
    DateTime? careerPeriodTo,

    /// 作業内容
    String? content,

    /// 担当フェーズ
    List<int>? phase,

    /// 役割
    int? role,

    /// OS経歴
    List<TechnicalOS>? usedTechnicalOSList,

    /// 使用言語
    List<TechnicalSkill>? usedTechnicalSkillList,

    /// DB経歴
    List<TechnicalDB>? usedTechnicalDBList,
  }) = _JobCareer;
  factory JobCareer.fromJson(Map<String, dynamic> json) =>
      _$JobCareerFromJson(json);
}
