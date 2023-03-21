import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../model/userInfo_model.dart';

final usersStreamProvider =
    StreamProviderFamily<dynamic, dynamic>((ref, userId) {
  final ref = FirebaseFirestore.instance.doc('users/$userId');
  // データ（Map型）を取得
  final data = ref.snapshots().map((e) => e.data());

  return data;
});
