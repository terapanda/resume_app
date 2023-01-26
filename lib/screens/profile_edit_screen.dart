import 'dart:convert';
import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:resume_app/model/person.dart';
import 'package:resume_app/provider/user_state.dart';
import 'mypage_screen.dart';
import 'package:resume_app/utils/input_form.dart';
import 'package:resume_app/utils/unfocus_keybord.dart';
import 'package:resume_app/utils/search_choices.dart';
import 'package:resume_app/utils/hex_color.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:resume_app/screens/image_picker.dart';

class ProfileEditScreen extends ConsumerWidget {
  ProfileEditScreen({super.key});

  int sex = 1;
  List __selectVal = [];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var userInfo = ref.watch(userProvider);

    final focusNode = FocusNode();
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        title: Text('プロフィールを編集'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              // // var username = ref.watch(personProvider);
              // // print(username.id);
              // // print(username.name);
              // var name = ref.watch(userProvider);
              // print(name);
              // // ref.read(userProvider.notifier).update((state) => state = 'asu');
              // ref.read(userProvider.notifier).state = 'asu';
              // var wame = ref.watch(userProvider);
              // print(wame);

              // var username = ref.watch(personProvider);
              // print(username.id);
              // ref.read(personProvider.notifier).state = 3;

              var use = ref.watch(userProvider);
              print(use);

              Person username = ref.watch(personProvider);
              // username.id = 3;
              print(username.name);
              username.name = '4';
              print(username.name);
              ref.read(personProvider.notifier).state = username;
              Person user2 = ref.watch(personProvider);
              print(user2.name);
            },
          )
        ],
      ),
      body: UnfocusKeybord(
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          // color: Colors.amber,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ImagePickerWidget(),
                      ),
                    ),
                    child: Container(
                      margin: EdgeInsets.only(top: 5),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        // color: Colors.yellow,
                      ),
                      child: Icon(
                        Icons.account_circle,
                        size: 110,
                      ),
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
                  child: Text("姓名")),
              Row(
                children: [
                  InputForm(
                    inputType: 'name',
                    hintText: '姓を入力',
                    isHalf: true,
                  ),
                  InputForm(
                    inputType: 'name',
                    hintText: '名を入力',
                    isHalf: true,
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
                  ),
                  InputForm(
                    inputType: 'name',
                    hintText: 'メイを入力',
                    isHalf: true,
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
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: EdgeInsets.only(top: 5, bottom: 5),
                          child: Text("性別")),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.448,
                        padding: const EdgeInsets.all(3),
                        child: DropdownButtonFormField2(
                          decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 2))),
                          // isExpanded: false,
                          hint: const Text(
                            '性別',
                            style: TextStyle(fontSize: 14),
                          ),
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black45,
                          ),
                          iconSize: 30,
                          buttonHeight: 46,
                          buttonPadding:
                              const EdgeInsets.only(left: 20, right: 10),
                          dropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.red, width: 2),
                          ),
                          items: [
                            DropdownMenuItem(
                              value: 1,
                              child: Text(
                                '男性',
                                style: TextStyle(color: Colors.black54),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 2,
                              child: Text('女性'),
                            ),
                            DropdownMenuItem(
                              value: 3,
                              child: Text('その他'),
                            ),
                          ],
                          onChanged: (int? value) {
                            // setState(() {
                            //   sex = value!;
                            // });
                          },
                          value: sex,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Container(
                  margin: EdgeInsets.only(top: 5, bottom: 5),
                  child: Text("最寄駅")),
              InputForm(
                hintText: '最寄駅を入力',
              ),
              Container(
                  margin: EdgeInsets.only(top: 5, bottom: 5),
                  child: Text("得意な言語")),
              SelectDevelopMentLanguage(),
              ViewSelectDevelopMentLanguage(__selectVal),
            ],
          ),
        ),
      ),
    );
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
            child: Text(lang['text'].toString()),
          ),
      ],
    );
  }

  Widget SelectDevelopMentLanguage() {
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
      padding: EdgeInsets.all(0),
      fieldDecoration: BoxDecoration(
        border: Border.all(
          color: Color.fromARGB(255, 137, 137, 132),
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      onChanged: (value) {
        // setState(() {
        //   // __selectVal = value;
        // });
      },
      doneButton: (selectedItemsDone, doneContext) {
        return (ElevatedButton(
            onPressed: selectedItemsDone.length > 0
                ? () {
                    print("doneContext");
                    print(selectedItemsDone);
                    Navigator.pop(doneContext);
                    // setState(() {
                    //   __selectVal = selectedItemsDone;
                    // });
                  }
                : null,
            child: Text("決定")));
      },
      closeButton: (selectedItemsClose) {
        return ("キャンセル");
      },
      isExpanded: true,
    );
  }
}
