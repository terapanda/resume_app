import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:resume_app/model/person.dart';
import 'package:resume_app/provider/user_state.dart';
import 'package:resume_app/utils/unfocus_keybord.dart';
import 'package:resume_app/utils/date_format.dart';
import 'package:resume_app/utils/search_choices.dart';
import 'package:resume_app/utils/input_form.dart';
import 'package:resume_app/utils/hex_color.dart';
import 'package:resume_app/screens/image_picker.dart';
import 'package:resume_app/services/firebaseService.dart';
import 'package:resume_app/model/person_converter.dart';
import 'package:resume_app/model/user.dart';

import '../model/userInfo_model.dart';
import '../provider/person_provider.dart';
import '../utils/dropdown/helper_classes.dart';
import '../utils/person_utils/image_widget.dart';
import '../utils/size_config.dart';

class ProfileEditScreen extends ConsumerStatefulWidget {
  ProfileEditScreen({super.key});

  @override
  ConsumerState<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends ConsumerState<ProfileEditScreen> {
  List<String> __selectVal = [];

  final _form = GlobalKey<FormState>();
  late String? birthDay;
  late String? description;
  late String? personImage = "";
  late String? firstName;
  late String? lastName;
  late String? firstNameRuby;
  late String? lastNameRuby;
  late int? sex = 1;
  late String? station;
  late String? initial;
  late int? branchOffice;
  late int? department;

  late List? favoriteLang = [];

  var personData;

  var userData;

  late AsyncValue user;

  @override
  void initState() {
    super.initState();
    // ログインしたユーザー情報プロバイダー
    userData = ref.read(GoogleUserInfoProvider);
  }

  @override
  Widget build(BuildContext context) {
    user = ref.watch(usersStreamProvider(userData['id']));
    final focusNode = FocusNode();
    return Scaffold(
      appBar: AppBar(
        title: Text('プロフィールを編集'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () async {
              SaveUserInfo();
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: UnfocusKeybord(
          child: Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Form(
                key: _form,
                child: user.when(
                  // 処理中は `loading` で指定したWidgetが表示される
                  loading: () => const CircularProgressIndicator(),
                  // エラーが発生した場合に表示されるWidgetを指定
                  error: (error, stack) => Text('Error: $error'),
                  // 取得した `users` が `data` で使用できる
                  data: (user) {
                    final userDataJson = UserInfo.fromJson(user);

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () async {
                                await showModalBottomSheet<int>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return bottomMenu(context);
                                  },
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: 5),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  // color: Colors.yellow,
                                ),
                                child: selectImage(userDataJson.image),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Text('プロフィール画像の編集')],
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5, bottom: 5),
                          child: Text("姓名"),
                        ),
                        Row(
                          children: [
                            InputForm(
                              inputType: 'name',
                              hintText: '姓を入力',
                              isHalf: true,
                              initialValue: userDataJson.nameFirst,
                              onSaved: (value) {
                                lastName = value;
                              },
                            ),
                            InputForm(
                              inputType: 'name',
                              hintText: '名を入力',
                              isHalf: true,
                              initialValue: userDataJson.nameLast,
                              onSaved: (value) {
                                firstName = value;
                              },
                            ),
                          ],
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 5, bottom: 5),
                            child: Text("セイメイ")),
                        Row(
                          children: [
                            InputForm(
                              inputType: 'name',
                              hintText: 'セイを入力',
                              isHalf: true,
                              initialValue: userDataJson.rubyFirst,
                              onSaved: (value) {
                                lastNameRuby = value;
                              },
                            ),
                            InputForm(
                              inputType: 'name',
                              hintText: 'メイを入力',
                              isHalf: true,
                              initialValue: userDataJson.rubyLast,
                              onSaved: (value) {
                                firstNameRuby = value;
                              },
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    margin: EdgeInsets.only(top: 5, bottom: 5),
                                    child: Text("生年月日")),
                                InputForm(
                                  inputType: 'birth',
                                  hintText: '2000/04/01',
                                  isHalf: false,
                                  initialValue:
                                      formatString(userDataJson.birthDay),
                                  onSaved: (value) {
                                    print("saveaaa");

                                    birthDay = value ??
                                        formatString(userDataJson.birthDay);
                                  },
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    margin: EdgeInsets.only(top: 5, bottom: 5),
                                    child: Text("性別")),
                                // Container(
                                //   width:
                                //       MediaQuery.of(context).size.width * 0.448,
                                //   // height: MediaQuery.of(context).size.height * 0.08,
                                //   padding: const EdgeInsets.all(3),
                                //   child: DropdownButtonFormField2(
                                //     decoration: InputDecoration(
                                //         isDense: true,
                                //         contentPadding: EdgeInsets.zero,
                                //         border: OutlineInputBorder(
                                //           borderRadius:
                                //               BorderRadius.circular(4),
                                //         ),
                                //         focusedBorder: const OutlineInputBorder(
                                //             borderSide: BorderSide(
                                //                 color: Colors.blue, width: 2))),
                                //     // isExpanded: false,
                                //     hint: const Text(
                                //       '性別',
                                //       style: TextStyle(fontSize: 14),
                                //     ),

                                //     iconStyleData: const IconStyleData(
                                //       icon: Icon(
                                //         Icons.arrow_drop_down,
                                //         color: Colors.black45,
                                //       ),
                                //       iconSize: 30,
                                //     ),
                                //     buttonHeight:
                                //         MediaQuery.of(context).size.height *
                                //             0.07,
                                //     buttonPadding:
                                //         const EdgeInsets.only(right: 10),
                                //     dropdownDecoration: BoxDecoration(
                                //       borderRadius: BorderRadius.circular(15),
                                //       border: Border.all(
                                //           color: Colors.blue, width: 2),
                                //     ),
                                //     items: const [
                                //       DropdownMenuItem(
                                //         value: 1,
                                //         child: Text('男性'),
                                //       ),
                                //       DropdownMenuItem(
                                //         value: 2,
                                //         child: Text('女性'),
                                //       ),
                                //       DropdownMenuItem(
                                //         value: 3,
                                //         child: Text('その他'),
                                //       ),
                                //     ],
                                //     onChanged: (value) {
                                //       sex = int.parse(value.toString());
                                //     },
                                //     onSaved: (value) {
                                //       sex = int.parse(value.toString());
                                //     },
                                //     value: userDataJson.sex,
                                //   ),
                                // ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    margin: EdgeInsets.only(top: 5, bottom: 5),
                                    child: Text("イニシャル")),
                                InputForm(
                                  hintText: 'T,S (三 太郎)',
                                  initialValue: userDataJson.initial,
                                  isHalf: true,
                                  onSaved: (value) {
                                    initial = value;
                                  },
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    margin: EdgeInsets.only(top: 5, bottom: 5),
                                    child: Text("最寄駅")),
                                InputForm(
                                  hintText: '最寄駅を入力',
                                  initialValue: userDataJson.station,
                                  isHalf: true,
                                  onSaved: (value) {
                                    station = value;
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    margin: EdgeInsets.only(top: 5, bottom: 5),
                                    child: Text("支社名")),
                                // Container(
                                //   width:
                                //       MediaQuery.of(context).size.width * 0.448,
                                //   // height: MediaQuery.of(context).size.height * 0.08,
                                //   padding: const EdgeInsets.all(3),
                                //   child: DropdownButtonFormField2(
                                //     decoration: InputDecoration(
                                //         isDense: true,
                                //         contentPadding: EdgeInsets.zero,
                                //         border: OutlineInputBorder(
                                //           borderRadius:
                                //               BorderRadius.circular(4),
                                //         ),
                                //         focusedBorder: const OutlineInputBorder(
                                //             borderSide: BorderSide(
                                //                 color: Colors.blue, width: 2))),
                                //     // isExpanded: false,
                                //     hint: const Text(
                                //       '性別',
                                //       style: TextStyle(fontSize: 14),
                                //     ),
                                //     icon: const Icon(
                                //       Icons.arrow_drop_down,
                                //       color: Colors.black45,
                                //     ),
                                //     iconSize: 30,
                                //     buttonHeight:
                                //         MediaQuery.of(context).size.height *
                                //             0.07,
                                //     buttonPadding:
                                //         const EdgeInsets.only(right: 10),
                                //     dropdownDecoration: BoxDecoration(
                                //       borderRadius: BorderRadius.circular(15),
                                //       border: Border.all(
                                //           color: Colors.blue, width: 2),
                                //     ),
                                //     items: const [
                                //       DropdownMenuItem(
                                //         value: 1,
                                //         child: Text('北海道支社'),
                                //       ),
                                //       DropdownMenuItem(
                                //         value: 2,
                                //         child: Text('東京本社'),
                                //       ),
                                //       DropdownMenuItem(
                                //         value: 3,
                                //         child: Text('中部支社'),
                                //       ),
                                //       DropdownMenuItem(
                                //         value: 4,
                                //         child: Text('関西支社'),
                                //       ),
                                //       DropdownMenuItem(
                                //         value: 5,
                                //         child: Text('中国支社'),
                                //       ),
                                //       DropdownMenuItem(
                                //         value: 6,
                                //         child: Text('九州支社'),
                                //       ),
                                //       DropdownMenuItem(
                                //         value: 7,
                                //         child: Text('バングラデシュ'),
                                //       ),
                                //     ],
                                //     onChanged: (value) {
                                //       branchOffice =
                                //           int.parse(value.toString());
                                //     },
                                //     onSaved: (value) {
                                //       branchOffice =
                                //           int.parse(value.toString());
                                //     },
                                //     value: userDataJson.branchOffice,
                                //   ),
                                // ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    margin: EdgeInsets.only(top: 5, bottom: 5),
                                    child: Text("部署名")),
                                // Container(
                                //   width:
                                //       MediaQuery.of(context).size.width * 0.448,
                                //   // height: MediaQuery.of(context).size.height * 0.08,
                                //   padding: const EdgeInsets.all(3),
                                //   child: DropdownButtonFormField2(
                                //     decoration: InputDecoration(
                                //         isDense: true,
                                //         contentPadding: EdgeInsets.zero,
                                //         border: OutlineInputBorder(
                                //           borderRadius:
                                //               BorderRadius.circular(4),
                                //         ),
                                //         focusedBorder: const OutlineInputBorder(
                                //             borderSide: BorderSide(
                                //                 color: Colors.blue, width: 2))),
                                //     // isExpanded: false,
                                //     hint: const Text(
                                //       '部署',
                                //       style: TextStyle(fontSize: 14),
                                //     ),
                                //     icon: const Icon(
                                //       Icons.arrow_drop_down,
                                //       color: Colors.black45,
                                //     ),
                                //     iconSize: 30,
                                //     buttonHeight:
                                //         MediaQuery.of(context).size.height *
                                //             0.07,
                                //     buttonPadding:
                                //         const EdgeInsets.only(right: 10),
                                //     dropdownDecoration: BoxDecoration(
                                //       borderRadius: BorderRadius.circular(15),
                                //       border: Border.all(
                                //           color: Colors.blue, width: 2),
                                //     ),
                                //     items: const [
                                //       DropdownMenuItem(
                                //         value: 1,
                                //         child: Text('システム本部'),
                                //       ),
                                //       DropdownMenuItem(
                                //         value: 2,
                                //         child: Text('営業部'),
                                //       ),
                                //       DropdownMenuItem(
                                //         value: 3,
                                //         child: Text('経営企画部'),
                                //       ),
                                //     ],
                                //     onChanged: (value) {
                                //       sex = int.parse(value.toString());
                                //     },
                                //     onSaved: (value) {
                                //       sex = int.parse(value.toString());
                                //     },
                                //     value: userDataJson.sex,
                                //   ),
                                // ),
                              ],
                            )
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5, bottom: 5),
                          child: Text("自己PR"),
                        ),
                        InputForm(
                          hintText: '自己PR',
                          initialValue: userDataJson.description,
                          onSaved: (value) {
                            description = value;
                          },
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5, bottom: 5),
                          child: Text("得意な言語"),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.89,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ViewSelectDevelopMentLanguage(
                                  __selectVal.length > 0
                                      ? __selectVal
                                      : userDataJson.favoriteSkill),
                              SelectDevelopMentLanguage(personData),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                )),
          ),
        ),
      ),
    );
  }

  /// ユーザ画像
  Widget selectImage(imageUrl) {
    // imageUrl = "";
    final userImageUri = Uri.encodeComponent(imageUrl);
    final encodeImageUrl =
        "https://firebasestorage.googleapis.com/v0/b/resume-b3019.appspot.com/o/${userImageUri}?alt=media";
    if (imageUrl == "") {
      return const Icon(
        Icons.account_circle,
        size: 110,
      );
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(45),
        child: Image.network(
          encodeImageUrl,
          width: 90,
          height: 90,
        ),
      );
    }
  }

  Widget ViewSelectDevelopMentLanguage(selectLang) {
    return Row(
      children: [
        for (final lang in selectLang)
          Container(
            margin: const EdgeInsets.only(top: 7, bottom: 4, right: 16),
            padding:
                const EdgeInsets.only(top: 4, bottom: 4, left: 8, right: 8),
            decoration: BoxDecoration(
              border: Border.all(color: HexColor()),
              borderRadius: BorderRadius.circular(45),
            ),
            child: Text(lang.toString()),
          ),
      ],
    );
  }

  // 言語選択
  Widget SelectDevelopMentLanguage(personData) {
    List<int> selectVal = [];
    return SearchChoices.multiple(
      items: [
        DropdownMenuItem(
          value: 'java',
          child: Text('java'),
        ),
        DropdownMenuItem(
          value: 'react',
          child: Text('react'),
        ),
        DropdownMenuItem(
          value: 'vue',
          child: Text('vue'),
        ),
      ],
      autofocus: false,
      selectedItems: selectVal,
      hint: "３つ選択できます。",
      searchHint: "言語検索",
      // padding: EdgeInsets.all(0),
      fieldDecoration: BoxDecoration(
        border: Border.all(
          color: Color.fromARGB(255, 137, 137, 132),
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      onChanged: (value) {
        // setState(() {
        __selectVal = value;
        // });
      },
      doneButton: (selectedItemsDone, doneContext) {
        return (ElevatedButton(
            onPressed: selectedItemsDone.length > 0
                ? () {
                    Navigator.pop(doneContext);
                    // setState(() {
                    List<String> selectDevList = [];
                    for (var item in selectedItemsDone) {
                      selectDevList.add(item["value"]);
                    }
                    setState(() {
                      __selectVal = selectDevList;
                    });

                    // });
                  }
                : null,
            child: Text("決定")));
      },
      closeButton: (selectedItemsClose) {
        return ("キャンセル");
      },
      onSaved: (newValue) {
        favoriteLang = __selectVal;
      },
      isExpanded: true,
    );
  }

  /// モーダルボトムシート表示処理
  Column bottomMenu(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.photo),
          title: Text('ギャラリーから画像を取得'),
          onTap: () async => await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ImagePickerWidget(
                pickImageType: 'gallery',
              ),
            ),
          ).then((value) async => {
                personImage = await FirebaseStorage.instance
                    .ref(
                        "users/${userData['id']}/profile_image.png") // TODO ユーザ情報から取得するよう変更
                    .getDownloadURL()
              }),
          // onTap: () => _pickImageFromGallery(),
        ),
        ListTile(
          leading: Icon(Icons.camera_alt),
          title: Text('カメラから画像を取得'),
          onTap: () async => await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  const ImagePickerWidget(pickImageType: 'camera'),
            ),
          ).then((value) async => {
                personImage = await FirebaseStorage.instance
                    .ref(
                        "users/${userData['id']}/profile_image.png") // TODO ユーザ情報から取得するよう変更
                    .getDownloadURL()
              }),
        ),
      ],
    );
  }

  // データ保存
  void SaveUserInfo() {
    UserInfo userInfo = UserInfo(
      authority: 1,
      birthDay: DateTime.parse("20001017"),
      contractType: 1,
      department: 3,
      description: "齋藤飛鳥",
      favoriteSkill: __selectVal,
      initial: "S.T",
      isProgrammer: true,
      nameFirst: "飛鳥",
      nameLast: "齋藤",
      rubyFirst: "あすか",
      rubyLast: "さいとう",
      sex: 1,
      station: "渋谷",
      updateDate: DateTime.now(),
      experience: 2,
    );
    FirebaseService.savePersonProfile('saito', userInfo);
  }
}
