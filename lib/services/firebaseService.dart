import 'dart:developer';
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
    Person? ConvertPerson;
    var person = await FirebaseFirestore.instance
        .collection('users')
        // .doc('staniuchi')
        .get()
        .then((event) async {
      for (var doc in event.docs) {
        // 取得したuserデータをPersonの形に置き換える
        if (doc.id == 'staniuchi') {
          ConvertPerson = await PersonConverter.convert(doc);
        }
      }
    });
    return ConvertPerson;
  }

  // saveを作る
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
}
