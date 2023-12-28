import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:resume_app/screens/home_screen.dart';
import 'package:resume_app/screens/image_picker.dart';
import 'package:resume_app/utils/use_shared_preferences.dart';
import '../model/userInfo_model.dart';
import '../provider/person_provider.dart';
import '../provider/user_state.dart';
import '../services/firebaseService.dart';
import '../utils/auth_check.dart';
import '../utils/date_format.dart';
import '../utils/input_form.dart';
import '../utils/replace_profile_data.dart';
import '../utils/size_config.dart';

class ProfileAddScreen extends ConsumerStatefulWidget {
  const ProfileAddScreen({super.key});

  @override
  ConsumerState<ProfileAddScreen> createState() => _ProfileAddScreenState();
}

class _ProfileAddScreenState extends ConsumerState<ProfileAddScreen> {
  final nameFirstController = TextEditingController();
  final nameLastController = TextEditingController();
  final rubyFirstController = TextEditingController();
  final rubyLastController = TextEditingController();
  final initialController = TextEditingController();
  final stationController = TextEditingController();
  final birthdayController = TextEditingController();

  late Map<dynamic, String> developLanguageOSMaster;
  late Map<dynamic, String> developLanguageSkillMaster;
  late Map<dynamic, String> developLanguageDBMaster;
  Map<dynamic, String> departmentMaster = {};
  Map<dynamic, String> branchOfficeMaster = {};
  List<String> departmentMasterList = [];
  List<String> branchOfficeMasterList = [];

  late DateTime birthday;
  late int sex;
  late int branchOffice;
  late int department;
  late String branchOfficeVal;
  late String departmentVal;
  late bool isProgramer;
  late String? personImage = "";

  @override
  void initState() {
    super.initState();

    nameFirstController.text = '';
    nameLastController.text = '';
    rubyFirstController.text = '';
    rubyLastController.text = '';
    initialController.text = '';
    stationController.text = '';
    birthdayController.text = '';
  }

  @override
  void dispose() {
    super.dispose();
  }

  // Future型は非同期処理（時間のかかる処理）
  Future<String> initialize() async {
    final masterData = await UseSharedPreferences.getUserDefaults('master');
    final encodeData = UseSharedPreferences.decodeMasterMap(masterData);
    departmentMaster = encodeData['department']!;
    branchOfficeMaster = encodeData['branchOffice']!;
    developLanguageOSMaster = encodeData['developLanguageOS']!;
    developLanguageSkillMaster = encodeData['developLanguageSkill']!;
    developLanguageDBMaster = encodeData['developLanguageDB']!;
    departmentMasterList = [];
    branchOfficeMasterList = [];
    for (var departmentItem in departmentMaster.entries) {
      departmentMasterList.add(departmentItem.value);
    }
    for (var branchOfficeItem in branchOfficeMaster.entries) {
      branchOfficeMasterList.add(branchOfficeItem.value);
    }

    birthday = DateTime.now();
    sex = 1;
    branchOffice = 1;
    department = 1;
    isProgramer = false;

    return 'Data Loaded';
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    final userstate = ref.read(userStateProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('プロフィールの登録'),
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder<void>(
          future: initialize(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // 値が存在する場合の処理
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("基本情報の登録を行います。"),
                      const Padding(padding: EdgeInsets.only(top: 12)),
                      const Text(
                          "まず初めにプログラマーの場合は以下のスイッチをオンにしてください。スイッチがオンの場合はプログラマーとみなし、経歴書の作成対象となります。"),
                      const Padding(padding: EdgeInsets.only(top: 16)),
                      Row(children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Tooltip(
                            message: '主にプログラマーである場合にtrueとする。',
                            child: Text(
                              isProgramer ? "プログラマーである" : "プログラマー以外",
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Center(
                          child: CupertinoSwitch(
                            value: isProgramer,
                            activeColor: CupertinoColors.activeOrange,
                            onChanged: (bool? value) async {
                              setState(() {
                                isProgramer = value ?? false;
                              });
                            },
                          ),
                        ),
                      ]),
                      if (isProgramer)
                        const Padding(padding: EdgeInsets.only(top: 16)),
                      if (isProgramer)
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
                                child: selectImage(personImage),
                              ),
                            ),
                          ],
                        ),
                      if (isProgramer)
                        const Padding(padding: EdgeInsets.only(top: 8)),
                      if (isProgramer)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Text('経歴書画像の編集')],
                        ),
                      const Padding(padding: EdgeInsets.only(top: 32)),
                      // Container(
                      //   width: MediaQuery.of(context).size.width * 0.6,
                      //   // height: MediaQuery.of(context).size.height * 0.08,
                      //   child: DropdownMenu<String>(
                      //     inputDecorationTheme: InputDecorationTheme(
                      //         isDense: true,
                      //         contentPadding: EdgeInsets.zero,
                      //         border: OutlineInputBorder(
                      //           borderRadius: BorderRadius.circular(4),
                      //         ),
                      //         focusedBorder: const OutlineInputBorder(
                      //             borderSide: BorderSide(
                      //                 color: Colors.pinkAccent, width: 2))),
                      //     hintText: '部署',
                      //     leadingIcon: const Icon(
                      //       textDirection: TextDirection.ltr,
                      //       size: 30,
                      //       Icons.arrow_drop_down,
                      //       color: Colors.black45,
                      //     ),
                      //     onSelected: (String? value) async {
                      //       // This is called when the user selects an item.
                      //       setState(() {
                      //         departmentVal = value.toString();
                      //       });
                      //       int departmentKey = await ReplaceProfileData()
                      //           .replaceDepartmentForVal(value.toString());
                      //       department = departmentKey;
                      //     },
                      //     dropdownMenuEntries: departmentMasterList
                      //         .map<DropdownMenuEntry<String>>((String value) {
                      //       return DropdownMenuEntry<String>(
                      //           value: value, label: value);
                      //     }).toList(),
                      //   ),
                      // ),
                      // Container(
                      //   width: MediaQuery.of(context).size.width * 0.6,
                      //   // height: MediaQuery.of(context).size.height * 0.08,
                      //   child: DropdownButtonFormField2(
                      //     decoration: InputDecoration(
                      //         isDense: true,
                      //         contentPadding: EdgeInsets.zero,
                      //         border: OutlineInputBorder(
                      //           borderRadius: BorderRadius.circular(4),
                      //         ),
                      //         focusedBorder: const OutlineInputBorder(
                      //             borderSide: BorderSide(
                      //                 color: Colors.pinkAccent, width: 2))),
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
                      //         MediaQuery.of(context).size.height * 0.07,
                      //     dropdownDecoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(15),
                      //       border: Border.all(color: Colors.black45, width: 1),
                      //     ),
                      //     value: departmentVal,
                      //     items: (departmentMasterList)
                      //         .map((String item) => DropdownMenuItem<String>(
                      //               value: item,
                      //               child: Text(
                      //                 item,
                      //                 style: const TextStyle(
                      //                   fontSize: 14,
                      //                   color: Colors.black,
                      //                 ),
                      //                 overflow: TextOverflow.ellipsis,
                      //               ),
                      //             ))
                      //         .toList(),
                      //     onChanged: (value) async {
                      //       departmentVal = value.toString();
                      //       int departmentKey = await ReplaceProfileData()
                      //           .replaceDepartmentForVal(value.toString());
                      //       department = departmentKey;
                      //     },
                      //     onSaved: (value) async {
                      //       departmentVal = value.toString();
                      //       int departmentKey = await ReplaceProfileData()
                      //           .replaceDepartmentForVal(value.toString());
                      //       department = departmentKey;
                      //     },
                      //   ),
                      // ),
                      const Padding(padding: EdgeInsets.only(top: 16)),
                      // Container(
                      //   width: MediaQuery.of(context).size.width * 0.6,
                      //   // height: MediaQuery.of(context).size.height * 0.08,
                      //   padding: const EdgeInsets.all(0),
                      //   child: DropdownButtonFormField2(
                      //     key: const Key("branchOffice"),
                      //     decoration: InputDecoration(
                      //         isDense: true,
                      //         contentPadding: EdgeInsets.zero,
                      //         border: OutlineInputBorder(
                      //           borderRadius: BorderRadius.circular(4),
                      //         ),
                      //         focusedBorder: const OutlineInputBorder(
                      //             borderSide: BorderSide(
                      //                 color: Colors.pinkAccent, width: 2))),
                      //     // isExpanded: false,
                      //     hint: const Text(
                      //       '支社名',
                      //       style: TextStyle(fontSize: 14),
                      //     ),
                      //     icon: const Icon(
                      //       Icons.arrow_drop_down,
                      //       color: Colors.black45,
                      //     ),
                      //     iconSize: 30,
                      //     buttonHeight:
                      //         MediaQuery.of(context).size.height * 0.07,
                      //     buttonPadding: const EdgeInsets.only(right: 10),
                      //     dropdownDecoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(15),
                      //       border: Border.all(color: Colors.black45, width: 1),
                      //     ),
                      //     value: branchOfficeVal,
                      //     items: (branchOfficeMasterList)
                      //         .map((String item) => DropdownMenuItem<String>(
                      //               value: item,
                      //               child: Text(
                      //                 item,
                      //                 style: const TextStyle(
                      //                   fontSize: 14,
                      //                   color: Colors.black,
                      //                 ),
                      //                 overflow: TextOverflow.ellipsis,
                      //               ),
                      //             ))
                      //         .toList(),
                      //     onChanged: (value) async {
                      //       branchOfficeVal = value.toString();
                      //       int branchOfficeKey = await ReplaceProfileData()
                      //           .replaceBranchOfficeForVal(value.toString());
                      //       branchOffice = branchOfficeKey;
                      //     },
                      //     onSaved: (value) async {
                      //       branchOfficeVal = value.toString();
                      //       int branchOfficeKey = await ReplaceProfileData()
                      //           .replaceBranchOfficeForVal(value.toString());
                      //       branchOffice = branchOfficeKey;
                      //     },
                      //   ),
                      // ),
                      const Padding(padding: EdgeInsets.only(top: 16)),
                      Row(children: [
                        Flexible(
                          child: TextField(
                            textInputAction: TextInputAction.done,
                            controller: nameFirstController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black54,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.pinkAccent,
                                ),
                              ),
                              labelText: '姓',
                              labelStyle: TextStyle(
                                color: Colors.black54,
                              ),
                              prefixIconColor: Colors.black54,
                              // prefixIcon: Icon(Icons.edit),
                            ),
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(left: 8)),
                        Flexible(
                          child: TextField(
                            textInputAction: TextInputAction.done,
                            controller: nameLastController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black54,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.pinkAccent,
                                ),
                              ),
                              labelText: '名',
                              labelStyle: TextStyle(
                                color: Colors.black54,
                              ),
                              prefixIconColor: Colors.black54,
                              // prefixIcon: Icon(Icons.edit),
                            ),
                          ),
                        ),
                      ]),
                      const Padding(padding: EdgeInsets.only(top: 32)),
                      Row(children: [
                        Flexible(
                          child: TextField(
                            textInputAction: TextInputAction.done,
                            controller: rubyFirstController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black54,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.pinkAccent,
                                ),
                              ),
                              labelText: 'セイ',
                              labelStyle: TextStyle(
                                color: Colors.black54,
                              ),
                              prefixIconColor: Colors.black54,
                              // prefixIcon: Icon(Icons.edit),
                            ),
                          ),
                        ),
                        Padding(padding: const EdgeInsets.only(left: 8)),
                        Flexible(
                          child: TextField(
                            textInputAction: TextInputAction.done,
                            controller: rubyLastController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black54,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.pinkAccent,
                                ),
                              ),
                              labelText: 'メイ',
                              labelStyle: TextStyle(
                                color: Colors.black54,
                              ),
                              prefixIconColor: Colors.black54,
                              // prefixIcon: Icon(Icons.edit),
                            ),
                          ),
                        ),
                      ]),
                      const Padding(padding: EdgeInsets.only(top: 32)),
                      Row(children: [
                        Flexible(
                          child: TextField(
                            textInputAction: TextInputAction.done,
                            controller: initialController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black54,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.pinkAccent,
                                ),
                              ),
                              labelText: 'イニシャル',
                              labelStyle: TextStyle(
                                color: Colors.black54,
                              ),
                              helperText: '例） A.A',
                              helperStyle: TextStyle(
                                color: Colors.black38,
                              ),
                              prefixIconColor: Colors.black54,
                              // prefixIcon: Icon(Icons.edit),
                            ),
                          ),
                        ),
                        Padding(padding: const EdgeInsets.only(left: 8)),
                        Flexible(
                          child: TextField(
                            textInputAction: TextInputAction.done,
                            controller: stationController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black54,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.pinkAccent,
                                ),
                              ),
                              labelText: '最寄駅',
                              labelStyle: TextStyle(
                                color: Colors.black54,
                              ),
                              helperText: '例） 新大阪',
                              helperStyle: TextStyle(
                                color: Colors.black38,
                              ),
                              prefixIconColor: Colors.black54,
                              // prefixIcon: Icon(Icons.edit),
                            ),
                          ),
                        ),
                      ]),
                      const Padding(padding: EdgeInsets.only(top: 16)),
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.448,
                            child: TextField(
                              style: const TextStyle(fontSize: 14),
                              readOnly: true,
                              textInputAction: TextInputAction.done,
                              controller: birthdayController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black54,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.pinkAccent,
                                  ),
                                ),
                                labelText: '誕生日',
                                labelStyle: TextStyle(
                                  color: Colors.black54,
                                ),
                              ),
                              onTap: () {
                                var tempBirthday = birthdayController.text;
                                var d = birthday;

                                DatePicker.showDatePicker(context,
                                    showTitleActions: true,
                                    minTime: DateTime(1900, 1, 1),
                                    maxTime: DateTime.now(), onChanged: (date) {
                                  print('change $date');
                                  birthdayController.text = ReplaceProfileData()
                                      .replaceYMDforJp(date);
                                  birthday = date;
                                }, onConfirm: (date) {
                                  print('confirm $date');
                                  print(date);
                                  birthdayController.text = ReplaceProfileData()
                                      .replaceYMDforJp(date);
                                  birthday = date;
                                }, onCancel: () {
                                  birthdayController.text = tempBirthday;
                                  birthday = d;
                                }, locale: LocaleType.jp);
                              },
                            ),
                          ),
                          Padding(padding: const EdgeInsets.only(left: 6)),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.455,
                            // height: MediaQuery.of(context).size.height * 0.08,
                            padding: const EdgeInsets.all(3),
                            child: DropdownButtonFormField2(
                              decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.pinkAccent, width: 2))),
                              // isExpanded: false,
                              hint: const Text(
                                '性別',
                                style: TextStyle(fontSize: 14),
                              ),
                              iconStyleData: const IconStyleData(
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black45,
                                ),
                                iconSize: 30,
                              ),
                              // buttonHeight:
                              //     MediaQuery.of(context).size.height * 0.07,
                              // buttonPadding: const EdgeInsets.only(right: 10),
                              dropdownStyleData: DropdownStyleData(
                                // maxHeight: 200,
                                // width: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                      color: Colors.black45, width: 1),
                                ),
                                // offset: const Offset(-20, 0),
                                // scrollbarTheme: ScrollbarThemeData(
                                //   radius: const Radius.circular(40),
                                //   thickness: MaterialStateProperty.all(6),
                                //   thumbVisibility:
                                //       MaterialStateProperty.all(true),
                                // ),
                              ),

                              items: const [
                                DropdownMenuItem(
                                  value: 1,
                                  child: Text('男性'),
                                ),
                                DropdownMenuItem(
                                  value: 2,
                                  child: Text('女性'),
                                ),
                                DropdownMenuItem(
                                  value: 3,
                                  child: Text('回答しない'),
                                ),
                              ],
                              onChanged: (value) {
                                sex = int.parse(value.toString());
                              },
                              onSaved: (value) {
                                sex = int.parse(value.toString());
                              },
                            ),
                          ),
                        ],
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 100)),
                    ],
                  ),
                ),
              );
            } else {
              // 値が存在しない場合の処理
              return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('Awaiting result...'),
                    ),
                  ]);
            }
          }),
      floatingActionButton: ButtonBar(
        children: [
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(primary: Colors.orange),
            icon: const Icon(Icons.save),
            label: const Text('保存'),
            onPressed: () {
              SaveUserInfo();
            },
          )
        ],
      ),
    );
  }

  /// ユーザ画像
  Widget selectImage(imageUrl) {
    if (imageUrl == "") {
      return const Icon(
        Icons.account_circle,
        size: 110,
      );
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(45),
        child: Image.network(
          imageUrl,
          width: 90,
          height: 90,
        ),
      );
    }
  }

  /// モーダルボトムシート表示処理
  Column bottomMenu(BuildContext context) {
    final googleUserInfo = ref.read(GoogleUserInfoProvider);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
            leading: Icon(Icons.photo),
            title: Text('ギャラリーから画像を取得'),
            onTap: () async => {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ImagePickerWidget(
                        pickImageType: 'gallery',
                      ),
                    ),
                  ).then((value) async => {
                        // すぐに画像が撮れなかったので１秒待つ
                        await Future.delayed(Duration(seconds: 1), () async {
                          personImage = await FirebaseStorage.instance
                              .ref(
                                  "users/${googleUserInfo["id"]}/profile_image.png") // TODO ユーザ情報から取得するよう変更
                              .getDownloadURL();
                          setState(() {});
                        })
                      })
                }
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
                // すぐに画像が撮れなかったので１秒待つ
                await Future.delayed(Duration(seconds: 1), () async {
                  personImage = await FirebaseStorage.instance
                      .ref(
                          "users/${googleUserInfo["id"]}/profile_image.png") // TODO ユーザ情報から取得するよう変更
                      .getDownloadURL();
                  setState(() {});
                })
              }),
        ),
      ],
    );
  }

  // データ保存
  void SaveUserInfo() {
    final googleUserInfo = ref.read(GoogleUserInfoProvider);

    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            content: Text('入力いただいた情報で登録処理を行います。'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  /// キャンセルを押した時の処理
                  Navigator.pop(context);
                },
                child: Text('キャンセル', style: TextStyle(color: Colors.red)),
              ),
              TextButton(
                onPressed: () async {
                  UserInfo userInfo = UserInfo(
                    authority: 3,
                    nameFirst: nameFirstController.text,
                    nameLast: nameLastController.text,
                    rubyFirst: rubyFirstController.text,
                    rubyLast: rubyLastController.text,
                    initial: initialController.text,
                    station: stationController.text,
                    birthDay: birthday,
                    sex: sex,
                    image: personImage,
                    isProgrammer: isProgramer,
                    updateDate: DateTime.now(),
                  );
                  await FirebaseService.saveBasicPersonProfile(
                      googleUserInfo["id"], userInfo);

                  if (isProgramer) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ),
                    );
                  }

                  final snackBar = SnackBar(
                    /// need to set following properties for best effect of awesome_snackbar_content
                    elevation: 0,
                    duration: Duration(seconds: 10),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: '登録完了',
                      message: '基本情報の登録処理が完了しました。',

                      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                      contentType: ContentType.success,
                    ),
                  );

                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(snackBar);
                },
                child: Text('登録する', style: TextStyle(color: Colors.blue)),
              ),
            ],
          );
        });
  }
}
