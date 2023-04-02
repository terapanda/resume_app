import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

// * どういうデータを保存するか？
//   プリミティブ型を使用してアプリのユーザーの設定やユーザー体験を向上させるようなデータを保存するのに向いています。
//   メモリに展開されるのであまり大きなデータを保存してしまうと端末メモリを圧迫してしまいます。

// * 保存したデータはいつ削除されるか？
//   アプリが削除されると消えます。

// * 注意点
//   UserDefaultsは値をそのまま保存しておりplistの中身を書き変えされてしまうリスクもあります。
//   そのため個人を特定できるようなセキュアな値を保存してはいけません。(emailアドレスやパスワードなど)

/// Androidでいうところの SharedPreferences
/// iOSでいうところの UserDefaults
/// のデータにアクセスする
class UseSharedPreferences {
  /// 保存
  static saveUserDefaults(String key, String value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(key, value);
  }

  /// 取得
  static getUserDefaults(key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.get(key);
  }

  /// 削除
  static removeUserDefaults(String key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove(key);
  }

  /// masterDataをUseSharedPreferencesに保存するために文字列のマップに変換
  static Map<String, Map<String, String>> encodeMasterMap(
      Map<String, Map<dynamic, String>> masterData) {
    Map<String, Map<String, String>> collectionMap = {};
    for (var entry in masterData.entries) {
      Map<String, String> documentMap = {};
      for (var entry2 in entry.value.entries) {
        documentMap[entry2.key.toString()] = entry2.value.toString();
      }
      collectionMap[entry.key.toString()] = documentMap;
    }
    return collectionMap;
  }

  /// masterDataをUseSharedPreferencesから取得後に変換前の型に戻す
  static Map<String, Map<dynamic, String>> decodeMasterMap(String masterData) {
    var dataSp = masterData.split(',');

    Map<String, Map<dynamic, String>> collectionMap = {};
    Map<dynamic, String> documentMap = {};
    var collectionKey = "";
    var documentKey;
    for (var dataSpItem in dataSp) {
      if (dataSpItem.split(':').length == 3) {
        documentMap = Map();
        collectionKey = replaceMapItem('{', dataSpItem.split(':')[0]);

        if (collectionKey == "developLanguage") {
          documentKey = replaceMapItem('{', dataSpItem.split(':')[1]);
        } else {
          documentKey =
              int.parse(replaceMapItem('{', dataSpItem.split(':')[1]));
        }
        documentMap[documentKey] =
            replaceMapItem('}', dataSpItem.split(':')[2]);
        collectionMap[collectionKey] = documentMap;
      } else {
        if (collectionKey == "developLanguage") {
          documentKey = replaceMapItem('{', dataSpItem.split(':')[0]);
        } else {
          documentKey =
              int.parse(replaceMapItem('{', dataSpItem.split(':')[0]));
        }
        documentMap[documentKey] =
            replaceMapItem('}', dataSpItem.split(':')[1]);
        collectionMap[collectionKey] = documentMap;
      }
    }

    return collectionMap;
  }

  static String replaceMapItem(String replaceString, String item) {
    return item.replaceAll(replaceString, "").replaceAll(' ', "");
  }
}
