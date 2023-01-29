import 'package:intl/intl.dart';

// 日付の形を整形
String formatString(DateTime time) {
  DateFormat outputFormat = DateFormat('yyyyMMdd');
  String date = outputFormat.format(time);
  return date;
}
