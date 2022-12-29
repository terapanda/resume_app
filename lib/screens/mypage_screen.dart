import 'package:flutter/cupertino.dart';

import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:resume_app/component/popup_card/popup_card.dart';
import 'package:resume_app/model/person.dart';
// import 'package:resume_app/screens/create_pdf/create_pdf_screen.dart';
// import 'package:resume_app/screens/create_pdf/file_name_widget.dart';
import 'package:resume_app/services/pdf_creator.dart';
import 'package:resume_app/services/save_helper/save_helper.dart';
// import 'package:resume_app/utils/development_language.dart';
import 'package:resume_app/utils/hex_color.dart';
import 'package:resume_app/screens/project_list_screen.dart';
import 'package:resume_app/example_data/search_screen_data.dart';
import 'package:resume_app/model/technical_skill.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:resume_app/screens/home_screen.dart';
import 'package:resume_app/screens/profile_edit_screen.dart';

class MypageScreen extends StatefulWidget {
  const MypageScreen({super.key});

  @override
  State<MypageScreen> createState() => _MypageScreenState();
}

class _MypageScreenState extends State<MypageScreen> {
  @override
  Widget build(BuildContext context) {
    return _popUpItemBody(context);
  }

  Widget _popUpItemBody(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    Map Persondata = {
      'id': '1',
      'name': '渡部　悠貴',
      'ruby': 'わたなべ　ゆうき',
      'initial': 'Y.W',
      'sex': '1',
      'age': '29',
      'station': '地下鉄御堂筋線　江坂',
      'excelsAt': ['React', 'Vue', 'java'],
      'image':
          'https://static.rtrp.jp/article/131658/images/131658a327d71f-736a-4fb7-8352-29be1f6da1e9_m.jpg',
      'experience': 8,
      'technicalSkill': [
        {'skillId': 'react', 'skillName': 'React', 'skillExperience': 38},
        {'skillId': 'vue', 'skillName': 'Vue', 'skillExperience': 38},
      ],
    };
    // void _save() async {
    //   final pdf = await PdfCreator.create();
    //   final bytes = await pdf.save();
    //   final fileName = '技術経歴書Y.W.pdf';
    //   await SaveHelper.save(
    //     bytes: bytes,
    //     fileName: fileName,
    //     platform: Theme.of(context).platform,
    //   );
    // }

    return Scaffold(
        body: CupertinoScaffold(
      body: Builder(
        builder: (context) => CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            transitionBetweenRoutes: false,
            middle: Text('エンジニア'),
            trailing: TextButton(
              onPressed: () => CupertinoScaffold.showCupertinoModalBottomSheet(
                context: context,
                backgroundColor: const Color(0xFAFAFAFA),
                builder: (context) => Stack(
                  children: <Widget>[ProfileEditScreen()],
                ),
              ),
              child: Text('編集',
                  style: TextStyle(color: Colors.black, fontSize: 18)),
            ),
          ),
          child: SizedBox.expand(
            child: SafeArea(
              bottom: false,
              child: PopUpItem(
                height: deviceHeight,
                outerPadding: EdgeInsets.all(0),
                innerPadding: EdgeInsets.all(16),
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
                elevation: 2,
                tag: 'tag1',
                child: Column(
                  children: [
                    Row(children: [
                      image(Persondata, 88),
                      Expanded(
                        child: SizedBox(
                          height: 88,
                          child: Column(children: [
                            name(Persondata, 24),
                            experience(true, Persondata),
                          ]),
                        ),
                      )
                    ]),
                    headline('プロフィール'),
                    Padding(padding: EdgeInsets.only(top: 8)),
                    Row(children: [
                      age(false, Persondata),
                      sex(false, Persondata),
                    ]),
                    const Divider(),
                    station(false, Persondata),
                    excelsAt(false, Persondata),
                    const Divider(),
                    Padding(padding: EdgeInsets.only(top: 8)),
                    headline('言語経歴'),
                    // technicalSkill(personList[index]),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ));
  }
}

// 見出し
Widget headline(String headName) {
  return Padding(
    padding: EdgeInsets.only(top: 8),
    child: Align(
      alignment: Alignment.centerLeft,
      child: Text(
        headName,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    ),
  );
}

// 写真
Widget image(Map personItem, double size) {
  return Padding(
    padding: EdgeInsets.only(right: 16),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(45),
      child: Image.network(
        personItem['image'],
        width: size,
        height: size,
      ),
    ),
  );
}

// 名前
Widget ruby(Map personItem) {
  return Flexible(
    child: Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(bottom: 4),
        child: Text(
          personItem['ruby'],
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ),
  );
}

// 名前
Widget name(Map personItem, double fontSize) {
  return Flexible(
    child: Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(bottom: 4),
        child: Text(
          personItem['name'],
          style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ),
  );
}

// 年齢
Widget age(bool isCard, Map personItem) {
  if (isCard) {
    return Row(
      // Property
      children: [
        Icon(FontAwesomeIcons.addressCard, size: 20, color: HexColor()),
        Padding(
          padding: EdgeInsets.only(left: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              personItem['age'] + '歳',
              style: TextStyle(fontSize: 16, color: HexColor()),
            ),
          ),
        ),
      ],
    );
  } else {
    return Expanded(
      flex: 1, // 1 要素分の横幅
      child: Row(
        // Property
        children: [
          Icon(FontAwesomeIcons.addressCard, size: 30, color: HexColor()),
          Padding(
              padding: EdgeInsets.only(left: 16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '年齢',
                      style: TextStyle(fontSize: 12, color: HexColor()),
                    ),
                    Text(
                      personItem['age'] + '歳',
                      style: TextStyle(fontSize: 16),
                    ),
                  ])),
        ],
      ),
    );
  }
}

// 経験年数
Widget experience(bool isCard, Map personItem) {
  if (isCard) {
    return Row(
      // Property
      children: [
        Icon(FontAwesomeIcons.briefcase, size: 20, color: HexColor()),
        Padding(
          padding: EdgeInsets.only(left: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '経験年数 ${personItem["experience"]} 年',
              style: TextStyle(fontSize: 16, color: HexColor()),
            ),
          ),
        ),
      ],
    );
  } else {
    return Row(
      // Property
      children: [
        Icon(FontAwesomeIcons.briefcase, size: 40, color: HexColor()),
        Padding(
          padding: EdgeInsets.only(left: 16),
          child: Text(
            '経験年数 ${personItem["experience"]} 年',
            style: TextStyle(fontSize: 16, color: HexColor()),
          ),
        ),
      ],
    );
  }
}

// 性別
Widget sex(bool isCard, Map personItem) {
  if (isCard) {
    return Padding(
      padding: EdgeInsets.only(top: 4),
      child: Row(
        // Property
        children: [
          Icon(FontAwesomeIcons.marsAndVenus, size: 20, color: HexColor()),
          Padding(
            padding: EdgeInsets.only(left: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                personItem['sex'] == '0' ? '女性' : '男性',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  } else {
    return Expanded(
      flex: 1, // 1 要素分の横幅
      child: Padding(
        padding: EdgeInsets.only(top: 4),
        child: Row(
          // Property
          children: [
            Icon(FontAwesomeIcons.marsAndVenus, size: 30, color: HexColor()),
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '性別',
                      style: TextStyle(fontSize: 12, color: HexColor()),
                    ),
                    Text(
                      personItem['sex'] == '0' ? '女性' : '男性',
                      style: TextStyle(fontSize: 16),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}

// 最寄り駅
Widget station(bool isCard, Map personItem) {
  if (isCard) {
    return Padding(
      padding: EdgeInsets.only(top: 4),
      child: Row(
        // Property
        children: [
          Icon(FontAwesomeIcons.trainSubway, size: 20, color: HexColor()),
          Padding(
            padding: EdgeInsets.only(left: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                personItem['station'] + '駅',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  } else {
    return Padding(
      padding: EdgeInsets.only(top: 4),
      child: Row(
        // Property
        children: [
          Icon(FontAwesomeIcons.trainSubway, size: 30, color: HexColor()),
          Padding(
            padding: EdgeInsets.only(left: 16),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                '最寄り駅',
                style: TextStyle(fontSize: 12, color: HexColor()),
              ),
              Text(
                personItem['station'] + '駅',
                style: TextStyle(fontSize: 16),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

// 得意な言語
Widget excelsAt(bool isCard, Map personItem) {
  List lang = personItem['excelsAt'];
  if (isCard) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(top: 8),
        child: Wrap(
          //RowからWrapへ
          children: [
            Padding(
              padding: EdgeInsets.only(top: 4),
              child: Icon(
                FontAwesomeIcons.bookmark,
                size: 20,
                color: HexColor(),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: Wrap(
                children: lang
                    .map((excelsAtItem) => Container(
                        margin: const EdgeInsets.only(bottom: 8, right: 16),
                        padding: const EdgeInsets.only(
                            top: 4, bottom: 4, left: 8, right: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: HexColor()),
                          borderRadius: BorderRadius.circular(45),
                        ),
                        child: Text(excelsAtItem)))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  } else {
    return Row(
        // Property
        children: [
          SizedBox(
            width: 30,
            child: Icon(
              FontAwesomeIcons.bookmark,
              size: 30,
              color: HexColor(),
            ),
          ),
          Expanded(
              child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 4, bottom: 4),
                      child: Text(
                        '得意な言語',
                        style: TextStyle(fontSize: 12, color: HexColor()),
                      ),
                    ),
                    Wrap(
                      children: lang
                          .map((excelsAtItem) => Container(
                              margin:
                                  const EdgeInsets.only(bottom: 4, right: 16),
                              padding: const EdgeInsets.only(
                                  top: 4, bottom: 4, left: 8, right: 8),
                              decoration: BoxDecoration(
                                border: Border.all(color: HexColor()),
                                borderRadius: BorderRadius.circular(45),
                              ),
                              child: Text(excelsAtItem)))
                          .toList(),
                    ),
                  ]),
            ),
          )),
        ]);
  }
}

// テクニカルスキル
// Widget technicalSkill(Person personItem) {
//   return SizedBox(
//       height: personItem.technicalSkill.length * (64 + 8 + 8),
//       child: ListView.builder(
//           physics: const NeverScrollableScrollPhysics(),
//           itemCount: personItem.technicalSkill.length,
//           itemBuilder: (context, index) {
//             return Card(
//               child: SizedBox(
//                 height: 64,
//                 child: Padding(
//                   padding: const EdgeInsets.only(
//                       top: 8, bottom: 8, left: 16, right: 16),
//                   child: Row(
//                     // Property
//                     children: [
//                       DevelopmentLanguage.getDevelopmentLanguage(
//                           personItem.technicalSkill[index].skillId,
//                           30,
//                           HexColor()),
//                       Padding(
//                           padding: EdgeInsets.only(left: 16),
//                           child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   personItem.technicalSkill[index].skillName,
//                                   style: TextStyle(fontSize: 16),
//                                 ),
//                                 Text(
//                                   calcSkillExperience(personItem
//                                           .technicalSkill[index]
//                                           .skillExperience)
//                                       .toString(),
//                                   style: TextStyle(fontSize: 16),
//                                 ),
//                               ])),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           }));
// }

PopupMenuItem<String> makePopupMenuItem(String itemValue, IconData icon) {
  return PopupMenuItem(
    value: itemValue,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 24,
          color: HexColor(),
        ),
        Padding(padding: EdgeInsets.only(right: 16)),
        Text(itemValue.toUpperCase()),
      ],
    ),
  );
}

String calcSkillExperience(double skillExperience) {
  var experienceYear = (skillExperience / 12).floor();
  var experienceMonth = (skillExperience - (experienceYear * 12)).floor();

  if (experienceYear == 0) {
    return '${experienceMonth}ヶ月';
  }

  if (experienceMonth.floor() == 0) {
    return '${experienceYear}年';
  }

  return '${experienceYear}年 ${experienceMonth}ヶ月';
}
