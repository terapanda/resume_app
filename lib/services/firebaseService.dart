import 'dart:collection';
import 'dart:developer';
import 'dart:ffi';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/person.dart';
import '../model/person_converter.dart';

class FirebaseService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  // FirebaseFirestore _database = FirebaseFirestore.instance;

  // FirebaseService();

  // personデータに整形したデータを取得
  static Future fetchConvertPerson() async {
    print("fetchperson");
    var person = await FirebaseFirestore.instance
        .collection('users')
        .doc('staniuchi')
        .get();

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

  static Future savePersonProfile(userId, person) async {
    inspect(person);
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final doc = _firestore.doc('users/$userId');
    await doc.update({
      'birthDay': person.birthDay,
      'contractType': person.contractType,
      'description': person.description,
      'favoriteSkill': person.favoriteSkill,
      'initial': person.initial,
      'nameFirst': person.nameFirst,
      'nameLast': person.nameLast,
      'rubyFirst': person.rubyFirst,
      'rubyLast': person.rubyLast,
      'sex': person.sex,
      'station': person.station,
    });
  }

  static Future saveAuthority(userId, authority) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final doc = _firestore.doc('users/$userId');
    await doc.update({
      'authority': authority,
    });
  }

  // personデータに整形したデータを取得
  static Future fetchMasterData() async {
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
    print(masterMap);

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
}
