import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:resume_app/model/job_career.dart';
import 'package:resume_app/model/person.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:resume_app/model/person_converter.dart';

import '../model/technical_os.dart';
import '../model/technical_skill.dart';
import '../services/firebaseService.dart';

final GoogleUserInfoProvider = StateProvider<Map<dynamic, dynamic>>(
    (ref) => {'id': '', 'email': '', 'name': ''});

final personStreamProvider = FutureProvider((ref) async {
  print("object");
  var personData = ref.read(GoogleUserInfoProvider);
  return await FirebaseService.fetchConvertPerson(userId: personData['id']);
});
