import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

// 日付の形を整形
String formatString(DateTime time) {
  DateFormat outputFormat = DateFormat('yyyyMMdd');
  String date = outputFormat.format(time);
  return date;
}

Timestamp formatDate(String date) {
  DateTime dt = DateTime.parse(date);
  Timestamp timeStampDt = Timestamp.fromDate(dt);
  return timeStampDt;
}
