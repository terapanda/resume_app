import 'dart:collection';
import 'dart:developer';
import 'dart:ffi';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:resume_app/utils/replace_profile_data.dart';

import '../model/person.dart';
import '../model/person_converter.dart';

class FirebaseService {
  // personデータに整形したデータを取得
  static Future fetchConvertPerson({userId}) async {
    var person =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
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

    final developLanguageData = await FirebaseFirestore.instance
        .collection('master')
        .doc('developLanguage')
        .get();

    late Map<String, String> replaceMap = {};
    developLanguageData.data()?.forEach((key, value) {
      replaceMap[key] = value.toString();
    });

    masterMap['developLanguage'] = replaceMap;

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
