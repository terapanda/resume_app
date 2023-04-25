// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'userInfo_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) {
  return _UserInfo.fromJson(json);
}

/// @nodoc
mixin _$UserInfo {
  /// 社員番号
// required String id,
  /// 名前
  String get nameFirst => throw _privateConstructorUsedError;
  String get nameLast => throw _privateConstructorUsedError;

  /// かな
  String get rubyFirst => throw _privateConstructorUsedError;
  String get rubyLast => throw _privateConstructorUsedError;

  /// 得意言語
  List<String> get favoriteSkill => throw _privateConstructorUsedError;

  /// イニシャル
  String get initial => throw _privateConstructorUsedError;

  /// 性別
  int get sex => throw _privateConstructorUsedError;

  /// 年齢
  DateTime get birthDay => throw _privateConstructorUsedError;

  /// 契約形態
  int get contractType => throw _privateConstructorUsedError;

  /// 概要・自己PR
  String get description => throw _privateConstructorUsedError;

  /// 駅
  String get station => throw _privateConstructorUsedError;

  /// 写真
  String? get image => throw _privateConstructorUsedError;

  /// 支社名
  int? get branchOffice => throw _privateConstructorUsedError;

  /// 部署名
  int? get department => throw _privateConstructorUsedError;

  /// 経験年数
  int? get experience => throw _privateConstructorUsedError;
  int get authority => throw _privateConstructorUsedError;
  bool get isProgrammer => throw _privateConstructorUsedError;

  /// 最終更新時刻
  DateTime get updateDate => throw _privateConstructorUsedError;

  /// OS経歴
  List<TechnicalOS>? get technicalOSList => throw _privateConstructorUsedError;

  /// 言語経歴
  List<TechnicalSkill>? get technicalSkillList =>
      throw _privateConstructorUsedError;

  /// DB経歴
  List<TechnicalDB>? get technicalDBList => throw _privateConstructorUsedError;

  /// 職務経歴
  List<JobCareer>? get jobCareerList => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserInfoCopyWith<UserInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserInfoCopyWith<$Res> {
  factory $UserInfoCopyWith(UserInfo value, $Res Function(UserInfo) then) =
      _$UserInfoCopyWithImpl<$Res, UserInfo>;
  @useResult
  $Res call(
      {String nameFirst,
      String nameLast,
      String rubyFirst,
      String rubyLast,
      List<String> favoriteSkill,
      String initial,
      int sex,
      DateTime birthDay,
      int contractType,
      String description,
      String station,
      String? image,
      int? branchOffice,
      int? department,
      int? experience,
      int authority,
      bool isProgrammer,
      DateTime updateDate,
      List<TechnicalOS>? technicalOSList,
      List<TechnicalSkill>? technicalSkillList,
      List<TechnicalDB>? technicalDBList,
      List<JobCareer>? jobCareerList});
}

/// @nodoc
class _$UserInfoCopyWithImpl<$Res, $Val extends UserInfo>
    implements $UserInfoCopyWith<$Res> {
  _$UserInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nameFirst = null,
    Object? nameLast = null,
    Object? rubyFirst = null,
    Object? rubyLast = null,
    Object? favoriteSkill = null,
    Object? initial = null,
    Object? sex = null,
    Object? birthDay = null,
    Object? contractType = null,
    Object? description = null,
    Object? station = null,
    Object? image = freezed,
    Object? branchOffice = freezed,
    Object? department = freezed,
    Object? experience = freezed,
    Object? authority = null,
    Object? isProgrammer = null,
    Object? updateDate = null,
    Object? technicalOSList = freezed,
    Object? technicalSkillList = freezed,
    Object? technicalDBList = freezed,
    Object? jobCareerList = freezed,
  }) {
    return _then(_value.copyWith(
      nameFirst: null == nameFirst
          ? _value.nameFirst
          : nameFirst // ignore: cast_nullable_to_non_nullable
              as String,
      nameLast: null == nameLast
          ? _value.nameLast
          : nameLast // ignore: cast_nullable_to_non_nullable
              as String,
      rubyFirst: null == rubyFirst
          ? _value.rubyFirst
          : rubyFirst // ignore: cast_nullable_to_non_nullable
              as String,
      rubyLast: null == rubyLast
          ? _value.rubyLast
          : rubyLast // ignore: cast_nullable_to_non_nullable
              as String,
      favoriteSkill: null == favoriteSkill
          ? _value.favoriteSkill
          : favoriteSkill // ignore: cast_nullable_to_non_nullable
              as List<String>,
      initial: null == initial
          ? _value.initial
          : initial // ignore: cast_nullable_to_non_nullable
              as String,
      sex: null == sex
          ? _value.sex
          : sex // ignore: cast_nullable_to_non_nullable
              as int,
      birthDay: null == birthDay
          ? _value.birthDay
          : birthDay // ignore: cast_nullable_to_non_nullable
              as DateTime,
      contractType: null == contractType
          ? _value.contractType
          : contractType // ignore: cast_nullable_to_non_nullable
              as int,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      station: null == station
          ? _value.station
          : station // ignore: cast_nullable_to_non_nullable
              as String,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      branchOffice: freezed == branchOffice
          ? _value.branchOffice
          : branchOffice // ignore: cast_nullable_to_non_nullable
              as int?,
      department: freezed == department
          ? _value.department
          : department // ignore: cast_nullable_to_non_nullable
              as int?,
      experience: freezed == experience
          ? _value.experience
          : experience // ignore: cast_nullable_to_non_nullable
              as int?,
      authority: null == authority
          ? _value.authority
          : authority // ignore: cast_nullable_to_non_nullable
              as int,
      isProgrammer: null == isProgrammer
          ? _value.isProgrammer
          : isProgrammer // ignore: cast_nullable_to_non_nullable
              as bool,
      updateDate: null == updateDate
          ? _value.updateDate
          : updateDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      technicalOSList: freezed == technicalOSList
          ? _value.technicalOSList
          : technicalOSList // ignore: cast_nullable_to_non_nullable
              as List<TechnicalOS>?,
      technicalSkillList: freezed == technicalSkillList
          ? _value.technicalSkillList
          : technicalSkillList // ignore: cast_nullable_to_non_nullable
              as List<TechnicalSkill>?,
      technicalDBList: freezed == technicalDBList
          ? _value.technicalDBList
          : technicalDBList // ignore: cast_nullable_to_non_nullable
              as List<TechnicalDB>?,
      jobCareerList: freezed == jobCareerList
          ? _value.jobCareerList
          : jobCareerList // ignore: cast_nullable_to_non_nullable
              as List<JobCareer>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserInfoCopyWith<$Res> implements $UserInfoCopyWith<$Res> {
  factory _$$_UserInfoCopyWith(
          _$_UserInfo value, $Res Function(_$_UserInfo) then) =
      __$$_UserInfoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String nameFirst,
      String nameLast,
      String rubyFirst,
      String rubyLast,
      List<String> favoriteSkill,
      String initial,
      int sex,
      DateTime birthDay,
      int contractType,
      String description,
      String station,
      String? image,
      int? branchOffice,
      int? department,
      int? experience,
      int authority,
      bool isProgrammer,
      DateTime updateDate,
      List<TechnicalOS>? technicalOSList,
      List<TechnicalSkill>? technicalSkillList,
      List<TechnicalDB>? technicalDBList,
      List<JobCareer>? jobCareerList});
}

/// @nodoc
class __$$_UserInfoCopyWithImpl<$Res>
    extends _$UserInfoCopyWithImpl<$Res, _$_UserInfo>
    implements _$$_UserInfoCopyWith<$Res> {
  __$$_UserInfoCopyWithImpl(
      _$_UserInfo _value, $Res Function(_$_UserInfo) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nameFirst = null,
    Object? nameLast = null,
    Object? rubyFirst = null,
    Object? rubyLast = null,
    Object? favoriteSkill = null,
    Object? initial = null,
    Object? sex = null,
    Object? birthDay = null,
    Object? contractType = null,
    Object? description = null,
    Object? station = null,
    Object? image = freezed,
    Object? branchOffice = freezed,
    Object? department = freezed,
    Object? experience = freezed,
    Object? authority = null,
    Object? isProgrammer = null,
    Object? updateDate = null,
    Object? technicalOSList = freezed,
    Object? technicalSkillList = freezed,
    Object? technicalDBList = freezed,
    Object? jobCareerList = freezed,
  }) {
    return _then(_$_UserInfo(
      nameFirst: null == nameFirst
          ? _value.nameFirst
          : nameFirst // ignore: cast_nullable_to_non_nullable
              as String,
      nameLast: null == nameLast
          ? _value.nameLast
          : nameLast // ignore: cast_nullable_to_non_nullable
              as String,
      rubyFirst: null == rubyFirst
          ? _value.rubyFirst
          : rubyFirst // ignore: cast_nullable_to_non_nullable
              as String,
      rubyLast: null == rubyLast
          ? _value.rubyLast
          : rubyLast // ignore: cast_nullable_to_non_nullable
              as String,
      favoriteSkill: null == favoriteSkill
          ? _value._favoriteSkill
          : favoriteSkill // ignore: cast_nullable_to_non_nullable
              as List<String>,
      initial: null == initial
          ? _value.initial
          : initial // ignore: cast_nullable_to_non_nullable
              as String,
      sex: null == sex
          ? _value.sex
          : sex // ignore: cast_nullable_to_non_nullable
              as int,
      birthDay: null == birthDay
          ? _value.birthDay
          : birthDay // ignore: cast_nullable_to_non_nullable
              as DateTime,
      contractType: null == contractType
          ? _value.contractType
          : contractType // ignore: cast_nullable_to_non_nullable
              as int,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      station: null == station
          ? _value.station
          : station // ignore: cast_nullable_to_non_nullable
              as String,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      branchOffice: freezed == branchOffice
          ? _value.branchOffice
          : branchOffice // ignore: cast_nullable_to_non_nullable
              as int?,
      department: freezed == department
          ? _value.department
          : department // ignore: cast_nullable_to_non_nullable
              as int?,
      experience: freezed == experience
          ? _value.experience
          : experience // ignore: cast_nullable_to_non_nullable
              as int?,
      authority: null == authority
          ? _value.authority
          : authority // ignore: cast_nullable_to_non_nullable
              as int,
      isProgrammer: null == isProgrammer
          ? _value.isProgrammer
          : isProgrammer // ignore: cast_nullable_to_non_nullable
              as bool,
      updateDate: null == updateDate
          ? _value.updateDate
          : updateDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      technicalOSList: freezed == technicalOSList
          ? _value._technicalOSList
          : technicalOSList // ignore: cast_nullable_to_non_nullable
              as List<TechnicalOS>?,
      technicalSkillList: freezed == technicalSkillList
          ? _value._technicalSkillList
          : technicalSkillList // ignore: cast_nullable_to_non_nullable
              as List<TechnicalSkill>?,
      technicalDBList: freezed == technicalDBList
          ? _value._technicalDBList
          : technicalDBList // ignore: cast_nullable_to_non_nullable
              as List<TechnicalDB>?,
      jobCareerList: freezed == jobCareerList
          ? _value._jobCareerList
          : jobCareerList // ignore: cast_nullable_to_non_nullable
              as List<JobCareer>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserInfo extends _UserInfo {
  const _$_UserInfo(
      {required this.nameFirst,
      required this.nameLast,
      required this.rubyFirst,
      required this.rubyLast,
      required final List<String> favoriteSkill,
      required this.initial,
      required this.sex,
      required this.birthDay,
      required this.contractType,
      required this.description,
      required this.station,
      this.image,
      this.branchOffice,
      this.department,
      this.experience,
      required this.authority,
      required this.isProgrammer,
      required this.updateDate,
      final List<TechnicalOS>? technicalOSList,
      final List<TechnicalSkill>? technicalSkillList,
      final List<TechnicalDB>? technicalDBList,
      final List<JobCareer>? jobCareerList})
      : _favoriteSkill = favoriteSkill,
        _technicalOSList = technicalOSList,
        _technicalSkillList = technicalSkillList,
        _technicalDBList = technicalDBList,
        _jobCareerList = jobCareerList,
        super._();

  factory _$_UserInfo.fromJson(Map<String, dynamic> json) =>
      _$$_UserInfoFromJson(json);

  /// 社員番号
// required String id,
  /// 名前
  @override
  final String nameFirst;
  @override
  final String nameLast;

  /// かな
  @override
  final String rubyFirst;
  @override
  final String rubyLast;

  /// 得意言語
  final List<String> _favoriteSkill;

  /// 得意言語
  @override
  List<String> get favoriteSkill {
    if (_favoriteSkill is EqualUnmodifiableListView) return _favoriteSkill;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_favoriteSkill);
  }

  /// イニシャル
  @override
  final String initial;

  /// 性別
  @override
  final int sex;

  /// 年齢
  @override
  final DateTime birthDay;

  /// 契約形態
  @override
  final int contractType;

  /// 概要・自己PR
  @override
  final String description;

  /// 駅
  @override
  final String station;

  /// 写真
  @override
  final String? image;

  /// 支社名
  @override
  final int? branchOffice;

  /// 部署名
  @override
  final int? department;

  /// 経験年数
  @override
  final int? experience;
  @override
  final int authority;
  @override
  final bool isProgrammer;

  /// 最終更新時刻
  @override
  final DateTime updateDate;

  /// OS経歴
  final List<TechnicalOS>? _technicalOSList;

  /// OS経歴
  @override
  List<TechnicalOS>? get technicalOSList {
    final value = _technicalOSList;
    if (value == null) return null;
    if (_technicalOSList is EqualUnmodifiableListView) return _technicalOSList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// 言語経歴
  final List<TechnicalSkill>? _technicalSkillList;

  /// 言語経歴
  @override
  List<TechnicalSkill>? get technicalSkillList {
    final value = _technicalSkillList;
    if (value == null) return null;
    if (_technicalSkillList is EqualUnmodifiableListView)
      return _technicalSkillList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// DB経歴
  final List<TechnicalDB>? _technicalDBList;

  /// DB経歴
  @override
  List<TechnicalDB>? get technicalDBList {
    final value = _technicalDBList;
    if (value == null) return null;
    if (_technicalDBList is EqualUnmodifiableListView) return _technicalDBList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// 職務経歴
  final List<JobCareer>? _jobCareerList;

  /// 職務経歴
  @override
  List<JobCareer>? get jobCareerList {
    final value = _jobCareerList;
    if (value == null) return null;
    if (_jobCareerList is EqualUnmodifiableListView) return _jobCareerList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'UserInfo(nameFirst: $nameFirst, nameLast: $nameLast, rubyFirst: $rubyFirst, rubyLast: $rubyLast, favoriteSkill: $favoriteSkill, initial: $initial, sex: $sex, birthDay: $birthDay, contractType: $contractType, description: $description, station: $station, image: $image, branchOffice: $branchOffice, department: $department, experience: $experience, authority: $authority, isProgrammer: $isProgrammer, updateDate: $updateDate, technicalOSList: $technicalOSList, technicalSkillList: $technicalSkillList, technicalDBList: $technicalDBList, jobCareerList: $jobCareerList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserInfo &&
            (identical(other.nameFirst, nameFirst) ||
                other.nameFirst == nameFirst) &&
            (identical(other.nameLast, nameLast) ||
                other.nameLast == nameLast) &&
            (identical(other.rubyFirst, rubyFirst) ||
                other.rubyFirst == rubyFirst) &&
            (identical(other.rubyLast, rubyLast) ||
                other.rubyLast == rubyLast) &&
            const DeepCollectionEquality()
                .equals(other._favoriteSkill, _favoriteSkill) &&
            (identical(other.initial, initial) || other.initial == initial) &&
            (identical(other.sex, sex) || other.sex == sex) &&
            (identical(other.birthDay, birthDay) ||
                other.birthDay == birthDay) &&
            (identical(other.contractType, contractType) ||
                other.contractType == contractType) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.station, station) || other.station == station) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.branchOffice, branchOffice) ||
                other.branchOffice == branchOffice) &&
            (identical(other.department, department) ||
                other.department == department) &&
            (identical(other.experience, experience) ||
                other.experience == experience) &&
            (identical(other.authority, authority) ||
                other.authority == authority) &&
            (identical(other.isProgrammer, isProgrammer) ||
                other.isProgrammer == isProgrammer) &&
            (identical(other.updateDate, updateDate) ||
                other.updateDate == updateDate) &&
            const DeepCollectionEquality()
                .equals(other._technicalOSList, _technicalOSList) &&
            const DeepCollectionEquality()
                .equals(other._technicalSkillList, _technicalSkillList) &&
            const DeepCollectionEquality()
                .equals(other._technicalDBList, _technicalDBList) &&
            const DeepCollectionEquality()
                .equals(other._jobCareerList, _jobCareerList));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        nameFirst,
        nameLast,
        rubyFirst,
        rubyLast,
        const DeepCollectionEquality().hash(_favoriteSkill),
        initial,
        sex,
        birthDay,
        contractType,
        description,
        station,
        image,
        branchOffice,
        department,
        experience,
        authority,
        isProgrammer,
        updateDate,
        const DeepCollectionEquality().hash(_technicalOSList),
        const DeepCollectionEquality().hash(_technicalSkillList),
        const DeepCollectionEquality().hash(_technicalDBList),
        const DeepCollectionEquality().hash(_jobCareerList)
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserInfoCopyWith<_$_UserInfo> get copyWith =>
      __$$_UserInfoCopyWithImpl<_$_UserInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserInfoToJson(
      this,
    );
  }
}

abstract class _UserInfo extends UserInfo {
  const factory _UserInfo(
      {required final String nameFirst,
      required final String nameLast,
      required final String rubyFirst,
      required final String rubyLast,
      required final List<String> favoriteSkill,
      required final String initial,
      required final int sex,
      required final DateTime birthDay,
      required final int contractType,
      required final String description,
      required final String station,
      final String? image,
      final int? branchOffice,
      final int? department,
      final int? experience,
      required final int authority,
      required final bool isProgrammer,
      required final DateTime updateDate,
      final List<TechnicalOS>? technicalOSList,
      final List<TechnicalSkill>? technicalSkillList,
      final List<TechnicalDB>? technicalDBList,
      final List<JobCareer>? jobCareerList}) = _$_UserInfo;
  const _UserInfo._() : super._();

  factory _UserInfo.fromJson(Map<String, dynamic> json) = _$_UserInfo.fromJson;

  @override

  /// 社員番号
// required String id,
  /// 名前
  String get nameFirst;
  @override
  String get nameLast;
  @override

  /// かな
  String get rubyFirst;
  @override
  String get rubyLast;
  @override

  /// 得意言語
  List<String> get favoriteSkill;
  @override

  /// イニシャル
  String get initial;
  @override

  /// 性別
  int get sex;
  @override

  /// 年齢
  DateTime get birthDay;
  @override

  /// 契約形態
  int get contractType;
  @override

  /// 概要・自己PR
  String get description;
  @override

  /// 駅
  String get station;
  @override

  /// 写真
  String? get image;
  @override

  /// 支社名
  int? get branchOffice;
  @override

  /// 部署名
  int? get department;
  @override

  /// 経験年数
  int? get experience;
  @override
  int get authority;
  @override
  bool get isProgrammer;
  @override

  /// 最終更新時刻
  DateTime get updateDate;
  @override

  /// OS経歴
  List<TechnicalOS>? get technicalOSList;
  @override

  /// 言語経歴
  List<TechnicalSkill>? get technicalSkillList;
  @override

  /// DB経歴
  List<TechnicalDB>? get technicalDBList;
  @override

  /// 職務経歴
  List<JobCareer>? get jobCareerList;
  @override
  @JsonKey(ignore: true)
  _$$_UserInfoCopyWith<_$_UserInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

TechnicalOS _$TechnicalOSFromJson(Map<String, dynamic> json) {
  return _TechnicalOS.fromJson(json);
}

/// @nodoc
mixin _$TechnicalOS {
  /// OSID
  String? get osId => throw _privateConstructorUsedError;

  /// OS経験年月
  int? get month => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TechnicalOSCopyWith<TechnicalOS> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TechnicalOSCopyWith<$Res> {
  factory $TechnicalOSCopyWith(
          TechnicalOS value, $Res Function(TechnicalOS) then) =
      _$TechnicalOSCopyWithImpl<$Res, TechnicalOS>;
  @useResult
  $Res call({String? osId, int? month});
}

/// @nodoc
class _$TechnicalOSCopyWithImpl<$Res, $Val extends TechnicalOS>
    implements $TechnicalOSCopyWith<$Res> {
  _$TechnicalOSCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? osId = freezed,
    Object? month = freezed,
  }) {
    return _then(_value.copyWith(
      osId: freezed == osId
          ? _value.osId
          : osId // ignore: cast_nullable_to_non_nullable
              as String?,
      month: freezed == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TechnicalOSCopyWith<$Res>
    implements $TechnicalOSCopyWith<$Res> {
  factory _$$_TechnicalOSCopyWith(
          _$_TechnicalOS value, $Res Function(_$_TechnicalOS) then) =
      __$$_TechnicalOSCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? osId, int? month});
}

/// @nodoc
class __$$_TechnicalOSCopyWithImpl<$Res>
    extends _$TechnicalOSCopyWithImpl<$Res, _$_TechnicalOS>
    implements _$$_TechnicalOSCopyWith<$Res> {
  __$$_TechnicalOSCopyWithImpl(
      _$_TechnicalOS _value, $Res Function(_$_TechnicalOS) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? osId = freezed,
    Object? month = freezed,
  }) {
    return _then(_$_TechnicalOS(
      osId: freezed == osId
          ? _value.osId
          : osId // ignore: cast_nullable_to_non_nullable
              as String?,
      month: freezed == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TechnicalOS implements _TechnicalOS {
  const _$_TechnicalOS({this.osId, this.month});

  factory _$_TechnicalOS.fromJson(Map<String, dynamic> json) =>
      _$$_TechnicalOSFromJson(json);

  /// OSID
  @override
  final String? osId;

  /// OS経験年月
  @override
  final int? month;

  @override
  String toString() {
    return 'TechnicalOS(osId: $osId, month: $month)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TechnicalOS &&
            (identical(other.osId, osId) || other.osId == osId) &&
            (identical(other.month, month) || other.month == month));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, osId, month);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TechnicalOSCopyWith<_$_TechnicalOS> get copyWith =>
      __$$_TechnicalOSCopyWithImpl<_$_TechnicalOS>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TechnicalOSToJson(
      this,
    );
  }
}

abstract class _TechnicalOS implements TechnicalOS {
  const factory _TechnicalOS({final String? osId, final int? month}) =
      _$_TechnicalOS;

  factory _TechnicalOS.fromJson(Map<String, dynamic> json) =
      _$_TechnicalOS.fromJson;

  @override

  /// OSID
  String? get osId;
  @override

  /// OS経験年月
  int? get month;
  @override
  @JsonKey(ignore: true)
  _$$_TechnicalOSCopyWith<_$_TechnicalOS> get copyWith =>
      throw _privateConstructorUsedError;
}

TechnicalSkill _$TechnicalSkillFromJson(Map<String, dynamic> json) {
  return _TechnicalSkill.fromJson(json);
}

/// @nodoc
mixin _$TechnicalSkill {
  /// 言語ID
  String? get skillId => throw _privateConstructorUsedError;

  /// 経験年数
  int? get month => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TechnicalSkillCopyWith<TechnicalSkill> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TechnicalSkillCopyWith<$Res> {
  factory $TechnicalSkillCopyWith(
          TechnicalSkill value, $Res Function(TechnicalSkill) then) =
      _$TechnicalSkillCopyWithImpl<$Res, TechnicalSkill>;
  @useResult
  $Res call({String? skillId, int? month});
}

/// @nodoc
class _$TechnicalSkillCopyWithImpl<$Res, $Val extends TechnicalSkill>
    implements $TechnicalSkillCopyWith<$Res> {
  _$TechnicalSkillCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? skillId = freezed,
    Object? month = freezed,
  }) {
    return _then(_value.copyWith(
      skillId: freezed == skillId
          ? _value.skillId
          : skillId // ignore: cast_nullable_to_non_nullable
              as String?,
      month: freezed == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TechnicalSkillCopyWith<$Res>
    implements $TechnicalSkillCopyWith<$Res> {
  factory _$$_TechnicalSkillCopyWith(
          _$_TechnicalSkill value, $Res Function(_$_TechnicalSkill) then) =
      __$$_TechnicalSkillCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? skillId, int? month});
}

/// @nodoc
class __$$_TechnicalSkillCopyWithImpl<$Res>
    extends _$TechnicalSkillCopyWithImpl<$Res, _$_TechnicalSkill>
    implements _$$_TechnicalSkillCopyWith<$Res> {
  __$$_TechnicalSkillCopyWithImpl(
      _$_TechnicalSkill _value, $Res Function(_$_TechnicalSkill) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? skillId = freezed,
    Object? month = freezed,
  }) {
    return _then(_$_TechnicalSkill(
      skillId: freezed == skillId
          ? _value.skillId
          : skillId // ignore: cast_nullable_to_non_nullable
              as String?,
      month: freezed == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TechnicalSkill implements _TechnicalSkill {
  const _$_TechnicalSkill({this.skillId, this.month});

  factory _$_TechnicalSkill.fromJson(Map<String, dynamic> json) =>
      _$$_TechnicalSkillFromJson(json);

  /// 言語ID
  @override
  final String? skillId;

  /// 経験年数
  @override
  final int? month;

  @override
  String toString() {
    return 'TechnicalSkill(skillId: $skillId, month: $month)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TechnicalSkill &&
            (identical(other.skillId, skillId) || other.skillId == skillId) &&
            (identical(other.month, month) || other.month == month));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, skillId, month);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TechnicalSkillCopyWith<_$_TechnicalSkill> get copyWith =>
      __$$_TechnicalSkillCopyWithImpl<_$_TechnicalSkill>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TechnicalSkillToJson(
      this,
    );
  }
}

abstract class _TechnicalSkill implements TechnicalSkill {
  const factory _TechnicalSkill({final String? skillId, final int? month}) =
      _$_TechnicalSkill;

  factory _TechnicalSkill.fromJson(Map<String, dynamic> json) =
      _$_TechnicalSkill.fromJson;

  @override

  /// 言語ID
  String? get skillId;
  @override

  /// 経験年数
  int? get month;
  @override
  @JsonKey(ignore: true)
  _$$_TechnicalSkillCopyWith<_$_TechnicalSkill> get copyWith =>
      throw _privateConstructorUsedError;
}

TechnicalDB _$TechnicalDBFromJson(Map<String, dynamic> json) {
  return _TechnicalDB.fromJson(json);
}

/// @nodoc
mixin _$TechnicalDB {
  /// データベースID
  String? get dbId => throw _privateConstructorUsedError;

  /// データベース経験年月
  int? get month => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TechnicalDBCopyWith<TechnicalDB> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TechnicalDBCopyWith<$Res> {
  factory $TechnicalDBCopyWith(
          TechnicalDB value, $Res Function(TechnicalDB) then) =
      _$TechnicalDBCopyWithImpl<$Res, TechnicalDB>;
  @useResult
  $Res call({String? dbId, int? month});
}

/// @nodoc
class _$TechnicalDBCopyWithImpl<$Res, $Val extends TechnicalDB>
    implements $TechnicalDBCopyWith<$Res> {
  _$TechnicalDBCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dbId = freezed,
    Object? month = freezed,
  }) {
    return _then(_value.copyWith(
      dbId: freezed == dbId
          ? _value.dbId
          : dbId // ignore: cast_nullable_to_non_nullable
              as String?,
      month: freezed == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TechnicalDBCopyWith<$Res>
    implements $TechnicalDBCopyWith<$Res> {
  factory _$$_TechnicalDBCopyWith(
          _$_TechnicalDB value, $Res Function(_$_TechnicalDB) then) =
      __$$_TechnicalDBCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? dbId, int? month});
}

/// @nodoc
class __$$_TechnicalDBCopyWithImpl<$Res>
    extends _$TechnicalDBCopyWithImpl<$Res, _$_TechnicalDB>
    implements _$$_TechnicalDBCopyWith<$Res> {
  __$$_TechnicalDBCopyWithImpl(
      _$_TechnicalDB _value, $Res Function(_$_TechnicalDB) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dbId = freezed,
    Object? month = freezed,
  }) {
    return _then(_$_TechnicalDB(
      dbId: freezed == dbId
          ? _value.dbId
          : dbId // ignore: cast_nullable_to_non_nullable
              as String?,
      month: freezed == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TechnicalDB implements _TechnicalDB {
  const _$_TechnicalDB({this.dbId, this.month});

  factory _$_TechnicalDB.fromJson(Map<String, dynamic> json) =>
      _$$_TechnicalDBFromJson(json);

  /// データベースID
  @override
  final String? dbId;

  /// データベース経験年月
  @override
  final int? month;

  @override
  String toString() {
    return 'TechnicalDB(dbId: $dbId, month: $month)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TechnicalDB &&
            (identical(other.dbId, dbId) || other.dbId == dbId) &&
            (identical(other.month, month) || other.month == month));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, dbId, month);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TechnicalDBCopyWith<_$_TechnicalDB> get copyWith =>
      __$$_TechnicalDBCopyWithImpl<_$_TechnicalDB>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TechnicalDBToJson(
      this,
    );
  }
}

abstract class _TechnicalDB implements TechnicalDB {
  const factory _TechnicalDB({final String? dbId, final int? month}) =
      _$_TechnicalDB;

  factory _TechnicalDB.fromJson(Map<String, dynamic> json) =
      _$_TechnicalDB.fromJson;

  @override

  /// データベースID
  String? get dbId;
  @override

  /// データベース経験年月
  int? get month;
  @override
  @JsonKey(ignore: true)
  _$$_TechnicalDBCopyWith<_$_TechnicalDB> get copyWith =>
      throw _privateConstructorUsedError;
}

JobCareer _$JobCareerFromJson(Map<String, dynamic> json) {
  return _JobCareer.fromJson(json);
}

/// @nodoc
mixin _$JobCareer {
  /// 職務経歴ID
  int? get careerId => throw _privateConstructorUsedError;

  /// 参画期間From
  DateTime? get careerPeriodFrom => throw _privateConstructorUsedError;

  /// 参画期間To
  DateTime? get careerPeriodTo => throw _privateConstructorUsedError;

  /// 作業内容
  String? get content => throw _privateConstructorUsedError;

  /// 担当フェーズ
  List<int>? get phase => throw _privateConstructorUsedError;

  /// 役割
  int? get role => throw _privateConstructorUsedError;

  /// OS経歴
  List<TechnicalOS>? get usedTechnicalOSList =>
      throw _privateConstructorUsedError;

  /// 使用言語
  List<TechnicalSkill>? get usedTechnicalSkillList =>
      throw _privateConstructorUsedError;

  /// DB経歴
  List<TechnicalDB>? get usedTechnicalDBList =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $JobCareerCopyWith<JobCareer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JobCareerCopyWith<$Res> {
  factory $JobCareerCopyWith(JobCareer value, $Res Function(JobCareer) then) =
      _$JobCareerCopyWithImpl<$Res, JobCareer>;
  @useResult
  $Res call(
      {int? careerId,
      DateTime? careerPeriodFrom,
      DateTime? careerPeriodTo,
      String? content,
      List<int>? phase,
      int? role,
      List<TechnicalOS>? usedTechnicalOSList,
      List<TechnicalSkill>? usedTechnicalSkillList,
      List<TechnicalDB>? usedTechnicalDBList});
}

/// @nodoc
class _$JobCareerCopyWithImpl<$Res, $Val extends JobCareer>
    implements $JobCareerCopyWith<$Res> {
  _$JobCareerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? careerId = freezed,
    Object? careerPeriodFrom = freezed,
    Object? careerPeriodTo = freezed,
    Object? content = freezed,
    Object? phase = freezed,
    Object? role = freezed,
    Object? usedTechnicalOSList = freezed,
    Object? usedTechnicalSkillList = freezed,
    Object? usedTechnicalDBList = freezed,
  }) {
    return _then(_value.copyWith(
      careerId: freezed == careerId
          ? _value.careerId
          : careerId // ignore: cast_nullable_to_non_nullable
              as int?,
      careerPeriodFrom: freezed == careerPeriodFrom
          ? _value.careerPeriodFrom
          : careerPeriodFrom // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      careerPeriodTo: freezed == careerPeriodTo
          ? _value.careerPeriodTo
          : careerPeriodTo // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      phase: freezed == phase
          ? _value.phase
          : phase // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      role: freezed == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as int?,
      usedTechnicalOSList: freezed == usedTechnicalOSList
          ? _value.usedTechnicalOSList
          : usedTechnicalOSList // ignore: cast_nullable_to_non_nullable
              as List<TechnicalOS>?,
      usedTechnicalSkillList: freezed == usedTechnicalSkillList
          ? _value.usedTechnicalSkillList
          : usedTechnicalSkillList // ignore: cast_nullable_to_non_nullable
              as List<TechnicalSkill>?,
      usedTechnicalDBList: freezed == usedTechnicalDBList
          ? _value.usedTechnicalDBList
          : usedTechnicalDBList // ignore: cast_nullable_to_non_nullable
              as List<TechnicalDB>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_JobCareerCopyWith<$Res> implements $JobCareerCopyWith<$Res> {
  factory _$$_JobCareerCopyWith(
          _$_JobCareer value, $Res Function(_$_JobCareer) then) =
      __$$_JobCareerCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? careerId,
      DateTime? careerPeriodFrom,
      DateTime? careerPeriodTo,
      String? content,
      List<int>? phase,
      int? role,
      List<TechnicalOS>? usedTechnicalOSList,
      List<TechnicalSkill>? usedTechnicalSkillList,
      List<TechnicalDB>? usedTechnicalDBList});
}

/// @nodoc
class __$$_JobCareerCopyWithImpl<$Res>
    extends _$JobCareerCopyWithImpl<$Res, _$_JobCareer>
    implements _$$_JobCareerCopyWith<$Res> {
  __$$_JobCareerCopyWithImpl(
      _$_JobCareer _value, $Res Function(_$_JobCareer) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? careerId = freezed,
    Object? careerPeriodFrom = freezed,
    Object? careerPeriodTo = freezed,
    Object? content = freezed,
    Object? phase = freezed,
    Object? role = freezed,
    Object? usedTechnicalOSList = freezed,
    Object? usedTechnicalSkillList = freezed,
    Object? usedTechnicalDBList = freezed,
  }) {
    return _then(_$_JobCareer(
      careerId: freezed == careerId
          ? _value.careerId
          : careerId // ignore: cast_nullable_to_non_nullable
              as int?,
      careerPeriodFrom: freezed == careerPeriodFrom
          ? _value.careerPeriodFrom
          : careerPeriodFrom // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      careerPeriodTo: freezed == careerPeriodTo
          ? _value.careerPeriodTo
          : careerPeriodTo // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      phase: freezed == phase
          ? _value._phase
          : phase // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      role: freezed == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as int?,
      usedTechnicalOSList: freezed == usedTechnicalOSList
          ? _value._usedTechnicalOSList
          : usedTechnicalOSList // ignore: cast_nullable_to_non_nullable
              as List<TechnicalOS>?,
      usedTechnicalSkillList: freezed == usedTechnicalSkillList
          ? _value._usedTechnicalSkillList
          : usedTechnicalSkillList // ignore: cast_nullable_to_non_nullable
              as List<TechnicalSkill>?,
      usedTechnicalDBList: freezed == usedTechnicalDBList
          ? _value._usedTechnicalDBList
          : usedTechnicalDBList // ignore: cast_nullable_to_non_nullable
              as List<TechnicalDB>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_JobCareer implements _JobCareer {
  const _$_JobCareer(
      {this.careerId,
      this.careerPeriodFrom,
      this.careerPeriodTo,
      this.content,
      final List<int>? phase,
      this.role,
      final List<TechnicalOS>? usedTechnicalOSList,
      final List<TechnicalSkill>? usedTechnicalSkillList,
      final List<TechnicalDB>? usedTechnicalDBList})
      : _phase = phase,
        _usedTechnicalOSList = usedTechnicalOSList,
        _usedTechnicalSkillList = usedTechnicalSkillList,
        _usedTechnicalDBList = usedTechnicalDBList;

  factory _$_JobCareer.fromJson(Map<String, dynamic> json) =>
      _$$_JobCareerFromJson(json);

  /// 職務経歴ID
  @override
  final int? careerId;

  /// 参画期間From
  @override
  final DateTime? careerPeriodFrom;

  /// 参画期間To
  @override
  final DateTime? careerPeriodTo;

  /// 作業内容
  @override
  final String? content;

  /// 担当フェーズ
  final List<int>? _phase;

  /// 担当フェーズ
  @override
  List<int>? get phase {
    final value = _phase;
    if (value == null) return null;
    if (_phase is EqualUnmodifiableListView) return _phase;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// 役割
  @override
  final int? role;

  /// OS経歴
  final List<TechnicalOS>? _usedTechnicalOSList;

  /// OS経歴
  @override
  List<TechnicalOS>? get usedTechnicalOSList {
    final value = _usedTechnicalOSList;
    if (value == null) return null;
    if (_usedTechnicalOSList is EqualUnmodifiableListView)
      return _usedTechnicalOSList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// 使用言語
  final List<TechnicalSkill>? _usedTechnicalSkillList;

  /// 使用言語
  @override
  List<TechnicalSkill>? get usedTechnicalSkillList {
    final value = _usedTechnicalSkillList;
    if (value == null) return null;
    if (_usedTechnicalSkillList is EqualUnmodifiableListView)
      return _usedTechnicalSkillList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// DB経歴
  final List<TechnicalDB>? _usedTechnicalDBList;

  /// DB経歴
  @override
  List<TechnicalDB>? get usedTechnicalDBList {
    final value = _usedTechnicalDBList;
    if (value == null) return null;
    if (_usedTechnicalDBList is EqualUnmodifiableListView)
      return _usedTechnicalDBList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'JobCareer(careerId: $careerId, careerPeriodFrom: $careerPeriodFrom, careerPeriodTo: $careerPeriodTo, content: $content, phase: $phase, role: $role, usedTechnicalOSList: $usedTechnicalOSList, usedTechnicalSkillList: $usedTechnicalSkillList, usedTechnicalDBList: $usedTechnicalDBList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_JobCareer &&
            (identical(other.careerId, careerId) ||
                other.careerId == careerId) &&
            (identical(other.careerPeriodFrom, careerPeriodFrom) ||
                other.careerPeriodFrom == careerPeriodFrom) &&
            (identical(other.careerPeriodTo, careerPeriodTo) ||
                other.careerPeriodTo == careerPeriodTo) &&
            (identical(other.content, content) || other.content == content) &&
            const DeepCollectionEquality().equals(other._phase, _phase) &&
            (identical(other.role, role) || other.role == role) &&
            const DeepCollectionEquality()
                .equals(other._usedTechnicalOSList, _usedTechnicalOSList) &&
            const DeepCollectionEquality().equals(
                other._usedTechnicalSkillList, _usedTechnicalSkillList) &&
            const DeepCollectionEquality()
                .equals(other._usedTechnicalDBList, _usedTechnicalDBList));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      careerId,
      careerPeriodFrom,
      careerPeriodTo,
      content,
      const DeepCollectionEquality().hash(_phase),
      role,
      const DeepCollectionEquality().hash(_usedTechnicalOSList),
      const DeepCollectionEquality().hash(_usedTechnicalSkillList),
      const DeepCollectionEquality().hash(_usedTechnicalDBList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_JobCareerCopyWith<_$_JobCareer> get copyWith =>
      __$$_JobCareerCopyWithImpl<_$_JobCareer>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_JobCareerToJson(
      this,
    );
  }
}

abstract class _JobCareer implements JobCareer {
  const factory _JobCareer(
      {final int? careerId,
      final DateTime? careerPeriodFrom,
      final DateTime? careerPeriodTo,
      final String? content,
      final List<int>? phase,
      final int? role,
      final List<TechnicalOS>? usedTechnicalOSList,
      final List<TechnicalSkill>? usedTechnicalSkillList,
      final List<TechnicalDB>? usedTechnicalDBList}) = _$_JobCareer;

  factory _JobCareer.fromJson(Map<String, dynamic> json) =
      _$_JobCareer.fromJson;

  @override

  /// 職務経歴ID
  int? get careerId;
  @override

  /// 参画期間From
  DateTime? get careerPeriodFrom;
  @override

  /// 参画期間To
  DateTime? get careerPeriodTo;
  @override

  /// 作業内容
  String? get content;
  @override

  /// 担当フェーズ
  List<int>? get phase;
  @override

  /// 役割
  int? get role;
  @override

  /// OS経歴
  List<TechnicalOS>? get usedTechnicalOSList;
  @override

  /// 使用言語
  List<TechnicalSkill>? get usedTechnicalSkillList;
  @override

  /// DB経歴
  List<TechnicalDB>? get usedTechnicalDBList;
  @override
  @JsonKey(ignore: true)
  _$$_JobCareerCopyWith<_$_JobCareer> get copyWith =>
      throw _privateConstructorUsedError;
}
