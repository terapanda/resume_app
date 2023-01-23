import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ImagePickerWidget extends StatefulWidget {
  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

/// 画像の状態を定数管理する
enum AppState {
  free,
  picked,
  cropped,
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  late AppState state;
  late File imageFile;

  @override
  void initState() {
    super.initState();
    state = AppState.free;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("画像切り抜き"),
        centerTitle: true,
        actions: [
          cropItem(),
          saveItem(),
        ],
      ),
      body: selectedItem(),
    );
  }

  /// 選択画像の表示処理
  Widget selectedItem() {
    if (state != AppState.free) {
      return Center(
        child: Image.file(imageFile),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          color: Colors.blue,
          width: double.infinity,
          child: TextButton(
            onPressed: () async {
              var result = await showModalBottomSheet<int>(
                context: context,
                builder: (BuildContext context) {
                  return bottomMenu(context);
                },
              );
            },
            child: const Text("Open Pop Bottom Menu",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white)),
          ),
        ),
      );
    }
  }

  /// モーダルボトムシート表示処理
  Column bottomMenu(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.photo),
          title: Text('ギャラリーから画像を取得'),
          onTap: () => _pickImageFromGallery(),
        ),
        ListTile(
          leading: Icon(Icons.camera_alt),
          title: Text('カメラから画像を取得'),
          onTap: () => _pickImageFromCamera(),
        ),
      ],
    );
  }

  /// 「ギャラリーから画像を取得」処理
  Future<Null> _pickImageFromGallery() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    imageFile = File(pickedImage!.path);
    setState(() {
      state = AppState.picked;
    });
  }

  /// 「カメラから画像を取得」処理
  Future<Null> _pickImageFromCamera() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    imageFile = File(pickedImage!.path);
    setState(() {
      state = AppState.picked;
    });
  }

  /// 画像編集アイコン
  Widget cropItem() {
    if (state != AppState.free) {
      return IconButton(icon: Icon(Icons.crop), onPressed: () => _cropImage());
    } else {
      return Container();
    }
  }

  /// 画像編集処理
  Future<Null> _cropImage() async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(title: 'Cropper'),
        ]);
    if (croppedFile != null) {
      imageFile = File(croppedFile.path);
      setState(() {
        state = AppState.cropped;
      });
    }
  }

  /// 保存のアイコン
  Widget saveItem() {
    if (state != AppState.free) {
      return IconButton(icon: Icon(Icons.save), onPressed: () => _saveImage());
    } else {
      return Container();
    }
  }

  /// 保存処理
  void _saveImage() {
    String userId = "staniuchi"; // TODO: staniuchi の部分をログイン中のUserIdにする。
    FirebaseStorage.instance
        .ref('users/$userId/profile_image.png')
        .putFile(imageFile);
    setState(() {
      state = AppState.free;
    });
  }
}
