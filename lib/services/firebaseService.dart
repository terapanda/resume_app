import 'dart:collection';
import 'dart:developer';
import 'dart:ffi';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:resume_app/model/technical_db.dart';
import 'package:resume_app/model/technical_skill.dart';
import 'package:resume_app/utils/replace_profile_data.dart';
import '../../model/userInfo_model.dart' as userInfoModel;

import '../model/job_career.dart';
import '../model/person.dart';
import '../model/person_converter.dart';
import '../model/technical_os.dart';
import '../utils/deep_copy.dart';

class FirebaseService {
  // personデータに整形したデータを取得
  static Future fetchConvertPerson({userId}) async {
    var person =
        await FirebaseFirestore.instance.collection('search').doc(userId).get();
    if (!person.exists) {
      return Person;
    }
    return await PersonConverter.convert(person);
  }

  // saveを作る

  /// user delete
  static Future deletePerson(String userId) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .delete()
        .then(
          (doc) => print("Document deleted"),
          onError: (e) => print("Error updating document $e"),
        );
  }

  static Future fetchUserData(userId) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get();
  }

  static Future fetchUserDataForSearch(userId) async {
    return await FirebaseFirestore.instance
        .collection('search')
        .doc(userId)
        .get();
  }

  static Future fetchJobCareer(String userId) async {
    final aaa = await FirebaseFirestore.instance
        .collection('/users/$userId/jobCareer')
        .get();
    return aaa;
  }

  static Future savePersonProfile(userId, user) async {
    inspect(user);
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final doc = _firestore.doc('users/$userId');
    await doc.set({
      'birthDay': user.birthDay,
      'contractType': user.contractType,
      'description': user.description,
      'favoriteSkill': user.favoriteSkill,
      'initial': user.initial,
      'nameFirst': user.nameFirst,
      'nameLast': user.nameLast,
      'rubyFirst': user.rubyFirst,
      'rubyLast': user.rubyLast,
      'sex': user.sex,
      'station': user.station,
      'image': user.image,
      'updateDate': DateTime.now(),
    });
  }

  static Future saveBasicPersonProfile(userId, user) async {
    inspect(user);
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final doc = _firestore.doc('users/$userId');
    await doc.set({
      'authority': user.authority,
      'nameFirst': user.nameFirst,
      'nameLast': user.nameLast,
      'rubyFirst': user.rubyFirst,
      'rubyLast': user.rubyLast,
      'birthDay': user.birthDay,
      'sex': user.sex,
      'isProgrammer': user.isProgrammer,
      'updateDate': DateTime.now(),
    });
  }

  static Future saveProject(userId, userInfoModel.JobCareer projectInfo) async {
    inspect(projectInfo);
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final doc =
        _firestore.doc('users/$userId/jobCareer/${projectInfo.careerId}');
    await doc.set({
      'careerPeriodFrom': projectInfo.careerPeriodFrom,
      'careerPeriodTo': projectInfo.careerPeriodTo,
      'content': projectInfo.content,
      'phase': projectInfo.phase,
      'role': projectInfo.role,
    });
    for (var listItem in projectInfo.usedTechnicalOSList!) {
      final osDoc = _firestore.doc(
          'users/$userId/jobCareer/${projectInfo.careerId}/technicalOS/${listItem.osId}');
      osDoc.set({'month': listItem.month});
    }
    for (var listItem in projectInfo.usedTechnicalSkillList!) {
      final skillDoc = _firestore.doc(
          'users/$userId/jobCareer/${projectInfo.careerId}/technicalSkill/${listItem.skillId}');
      skillDoc.set({'month': listItem.month});
    }
    for (var listItem in projectInfo.usedTechnicalDBList!) {
      final dbDoc = _firestore.doc(
          'users/$userId/jobCareer/${projectInfo.careerId}/technicalDB/${listItem.dbId}');
      dbDoc.set({'month': listItem.month});
    }
  }

  static Future saveProjectForSearch(userId, JobCareer projectInfo) async {
    inspect(projectInfo);
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    final doc =
        _firestore.doc('search/$userId/jobCareer/${projectInfo.careerId}');
    await doc.set({
      'careerPeriodFrom': projectInfo.careerPeriodFrom,
      'careerPeriodTo': projectInfo.careerPeriodTo,
      'content': projectInfo.content,
      'phase': projectInfo.phase,
      'role': projectInfo.role,
    });
    List<TechnicalOS>? osList = projectInfo.usedTechnicalOSList;
    for (var listItem in osList!) {
      final osDoc = _firestore.doc(
          'search/$userId/jobCareer/${projectInfo.careerId}/technicalOS/${listItem.osId}');
      osDoc.set({'month': listItem.month});
    }
    List<TechnicalSkill>? skillList = projectInfo.usedTechnicalSkillList;
    for (var listItem in skillList!) {
      final skillDoc = _firestore.doc(
          'search/$userId/jobCareer/${projectInfo.careerId}/technicalSkill/${listItem.skillId}');
      skillDoc.set({'month': listItem.month});
    }
    List<TechnicalDB>? dbList = projectInfo.usedTechnicalDBList;
    for (var listItem in dbList!) {
      final dbDoc = _firestore.doc(
          'search/$userId/jobCareer/${projectInfo.careerId}/technicalDB/${listItem.dbId}');
      dbDoc.set({'month': listItem.month});
    }
  }

  static Future<Person> saveAddingUpList(Person person) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    Person newPerson = await fetchConvertPerson(userId: person.id);
    newPerson.jobCareerList =
        await PersonConverter.fetchJobCareerList(person.id);

    List<TechnicalOS> technicalOSList =
        PersonConverter.getAddingUpTechnicalOSList(person);
    for (var listItem in technicalOSList) {
      final osDoc = _firestore
          .doc('search/${person.id}/totalTechnicalOS/${listItem.osId}');
      osDoc.set({'month': listItem.month});
    }
    List<TechnicalSkill> technicalSkillList =
        PersonConverter.getAddingUpTechnicalSkillList(person);
    for (var listItem in technicalSkillList) {
      final skillDoc = _firestore
          .doc('search/${person.id}/totalTechnicalSkill/${listItem.skillId}');
      skillDoc.set({'month': listItem.month});
    }
    List<TechnicalDB> technicalDBList =
        PersonConverter.getAddingUpTechnicalDBList(person);
    for (var listItem in technicalDBList) {
      final dbDoc = _firestore
          .doc('search/${person.id}/totalTechnicalDB/${listItem.dbId}');
      dbDoc.set({'month': listItem.month});
    }

    newPerson.technicalOSList = technicalOSList;
    newPerson.technicalSkillList = technicalSkillList;
    newPerson.technicalDBList = technicalDBList;

    return newPerson;
  }

  static Future saveAuthority(userId, authority) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final docUsers = _firestore.doc('users/$userId');
    await docUsers.update({
      'authority': authority,
    });
    final docSearch = _firestore.doc('search/$userId');
    await docSearch.update({
      'authority': authority,
    });
  }

  static Future saveIsProgrammer(userId, isProgrammer) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final docUsers = _firestore.doc('users/$userId');
    await docUsers.update({
      'isProgrammer': isProgrammer,
    });
    final docSearch = _firestore.doc('search/$userId');
    await docSearch.update({
      'isProgrammer': isProgrammer,
    });
  }

  static Future saveContractType(userId, contractType) async {
    ReplaceProfileData replaceProfileData = ReplaceProfileData();
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final docUsers = _firestore.doc('users/$userId');
    await docUsers.update({
      'contractType': contractType,
    });
    final docSearch = _firestore.doc('search/$userId');
    final replaceContractType =
        await replaceProfileData.replaceContractType(contractType);
    await docSearch.update({
      'contractType': replaceContractType,
    });
  }

  // personデータに整形したデータを取得
  static Future<Map<String, Map<dynamic, String>>> fetchMasterData() async {
    late Map<String, Map<dynamic, String>> masterMap = {};
    print("fetchMasterData");
    final departmentData = await FirebaseFirestore.instance
        .collection('master')
        .doc('department')
        .get();
    masterMap['department'] = replaceDocData(departmentData.data());

    final branchOfficeData = await FirebaseFirestore.instance
        .collection('master')
        .doc('branchOffice')
        .get();
    masterMap['branchOffice'] = replaceDocData(branchOfficeData.data());

    final authorityData = await FirebaseFirestore.instance
        .collection('master')
        .doc('authority')
        .get();
    masterMap['authority'] = replaceDocData(authorityData.data());

    final contractFormData = await FirebaseFirestore.instance
        .collection('master')
        .doc('contractForm')
        .get();
    masterMap['contractForm'] = replaceDocData(contractFormData.data());

    final phaseData = await FirebaseFirestore.instance
        .collection('master')
        .doc('phase')
        .get();
    masterMap['phase'] = replaceDocData(phaseData.data());

    final roleData =
        await FirebaseFirestore.instance.collection('master').doc('role').get();
    masterMap['role'] = replaceDocData(roleData.data());

    final sexData =
        await FirebaseFirestore.instance.collection('master').doc('sex').get();
    masterMap['sex'] = replaceDocData(sexData.data());

    final developLanguageSkillData = await FirebaseFirestore.instance
        .collection('master')
        .doc('developLanguageSkill')
        .get();

    late Map<String, String> replaceSkillMap = {};
    developLanguageSkillData.data()?.forEach((key, value) {
      replaceSkillMap[key] = value.toString();
    });

    masterMap['developLanguageSkill'] = replaceSkillMap;

    final developLanguageDBData = await FirebaseFirestore.instance
        .collection('master')
        .doc('developLanguageDB')
        .get();

    late Map<String, String> replaceDBMap = {};
    developLanguageDBData.data()?.forEach((key, value) {
      replaceDBMap[key] = value.toString();
    });

    masterMap['developLanguageDB'] = replaceDBMap;

    final developLanguageOSData = await FirebaseFirestore.instance
        .collection('master')
        .doc('developLanguageOS')
        .get();

    late Map<String, String> replaceOSMap = {};
    developLanguageOSData.data()?.forEach((key, value) {
      replaceOSMap[key] = value.toString();
    });

    masterMap['developLanguageOS'] = replaceOSMap;

    return masterMap;
  }

  static Map<int, String> replaceDocData(Map<String, dynamic>? docData) {
    // これをreturnしたい。
    late Map<int, String> replaceMap = {};

    // 回して型変換してreplaceMapに詰めていく。
    docData?.forEach((key, value) {
      replaceMap[int.parse(key)] = value.toString();
    });

    // ソート
    replaceMap = SplayTreeMap.from(replaceMap, (a, b) => a.compareTo(b));

    return replaceMap;
  }

  /// jobCarrer delete
  static Future deletejobCareer(String userId, int careerId) async {
    await FirebaseFirestore.instance
        .collection("users/$userId/jobCareer")
        .doc(careerId.toString())
        .delete()
        .then(
          (doc) => print("Document deleted"),
          onError: (e) => print("Error updating document $e"),
        );
  }
}
