import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class SaveHelper {
  static Future<void> save({
    required List<int> bytes,
    required String fileName,
    required TargetPlatform platform,
  }) async {
    Directory? inAppFolderDocumentDirectoryO;

    if (platform == TargetPlatform.macOS) {
      // フォルダ情報を取得
      inAppFolderDocumentDirectoryO = await getDownloadsDirectory();
    } else {
      // アプリ専用フォルダ内のフォルダ情報を取得
      inAppFolderDocumentDirectoryO = await getApplicationDocumentsDirectory();
    }

    // 上記フォルダ情報（Directory型）からパス名を取得
    final path = inAppFolderDocumentDirectoryO?.path;

    try {
      // 上記フルパスにFileクラスのインスタンスを設定
      File("$path/$fileName")
        ..createSync(recursive: true)
        ..writeAsBytesSync(bytes);

      // シェア
      _share(path, fileName);
    } catch (e) {
      print(e);
    }
  }

  static Future<void> _share(String? path, String fileName) async {
    await Share.shareFiles(['$path/$fileName']);
  }
}
