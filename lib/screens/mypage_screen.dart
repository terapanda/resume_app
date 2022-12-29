import 'package:flutter/cupertino.dart';

import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:resume_app/component/popup_card/popup_card.dart';
import 'package:resume_app/model/job_career.dart';
import 'package:resume_app/model/person.dart';
import 'package:resume_app/model/technical_os.dart';
import 'package:resume_app/model/technical_skill.dart';
import 'package:resume_app/services/pdf_creator.dart';
import 'package:resume_app/services/save_helper/save_helper.dart';
import 'package:resume_app/utils/calc_years_of_skill.dart';
import 'package:resume_app/utils/hex_color.dart';
import 'package:resume_app/screens/profile_edit_screen.dart';
import 'package:resume_app/utils/replace_profile_data.dart';
import 'package:resume_app/utils/replace_technical.dart';

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
    Person Persondata = Person(
        id: 2,
        name: "谷内　伸輔神",
        ruby: "たにうち　しんすけ",
        initial: "S.T",
        sex: 3,
        age: 34,
        contractType: 1,
        description:
            "＜身についた知識・スキル＞\n・業務用基幹システム構築業務で身につけたプロジェクト全体をマネジメントするスキル\n・社内関係部署の要望を把握し、協力会社との調整・折衝を経験したことから得た課題を把握する力、解決策を提示し遂行する力\n・システム全般に関する包括的な知識・スキル",
        station: "JRおおさか東線　高井田中央",
        favoriteSkill: ['COBOL', 'Vue', 'Python'],
        image:
            "https://static.rtrp.jp/article/131658/images/131658a327d71f-736a-4fb7-8352-29be1f6da1e9_m.jpg",
        experience: 8,
        lastUpdateDate: new DateTime(2021, 11, 12, 17, 30),
        technicalSkillList: [
          TechnicalSkill(skillId: 'react', monthOfSkill: 25),
          TechnicalSkill(skillId: 'vue', monthOfSkill: 24),
          TechnicalSkill(skillId: 'java', monthOfSkill: 24),
          TechnicalSkill(skillId: 'php', monthOfSkill: 12),
          TechnicalSkill(skillId: 'flutter', monthOfSkill: 24),
          TechnicalSkill(skillId: 'vba', monthOfSkill: 36),
          TechnicalSkill(skillId: 'python', monthOfSkill: 36)
        ],
        jobCareerList: [
          JobCareer(
              careerId: 1,
              careerPeriodFrom: DateTime(2019, 11, 01),
              careerPeriodTo: DateTime(2019, 12, 31),
              content: "高速道路に表示する電光掲示の遠隔操作システム",
              phaseInCharge: "フロントエンド",
              role: 4,
              usedTechnicalSkillList: [
                const TechnicalSkill(skillId: 'vue', monthOfSkill: 2),
              ]),
          JobCareer(
              careerId: 2,
              careerPeriodFrom: DateTime(2020, 01, 01),
              careerPeriodTo: DateTime(2021, 08, 31),
              content: "空調機器設置遠隔操作システム",
              phaseInCharge: "フロントエンド\n要件定義～テスト",
              role: 4,
              usedTechnicalOSList: [
                const TechnicalOS(osId: 'mac', monthOfOS: 8),
              ],
              usedTechnicalSkillList: [
                const TechnicalSkill(skillId: 'react', monthOfSkill: 8),
                const TechnicalSkill(skillId: 'type_script', monthOfSkill: 7),
              ]),
          JobCareer(
              careerId: 3,
              careerPeriodFrom: DateTime(2020, 01, 01),
              careerPeriodTo: DateTime(2021, 08, 31),
              content: "空調機器設置遠隔操作システム",
              phaseInCharge: "フロントエンド\n要件定義～テスト",
              role: 4,
              usedTechnicalOSList: [
                const TechnicalOS(osId: 'mac', monthOfOS: 8),
              ],
              usedTechnicalSkillList: [
                const TechnicalSkill(skillId: 'react', monthOfSkill: 8),
                const TechnicalSkill(skillId: 'type_script', monthOfSkill: 7),
              ]),
          JobCareer(
              careerId: 4,
              careerPeriodFrom: DateTime(2020, 01, 01),
              careerPeriodTo: DateTime(2021, 08, 31),
              content: "空調機器設置遠隔操作システム",
              phaseInCharge: "フロントエンド\n要件定義～テスト",
              role: 4,
              usedTechnicalOSList: [
                const TechnicalOS(osId: 'mac', monthOfOS: 8),
              ],
              usedTechnicalSkillList: [
                const TechnicalSkill(skillId: 'react', monthOfSkill: 8),
                const TechnicalSkill(skillId: 'type_script', monthOfSkill: 7),
              ]),
          JobCareer(
              careerId: 5,
              careerPeriodFrom: DateTime(2020, 01, 01),
              careerPeriodTo: DateTime(2021, 08, 31),
              content: "空調機器設置遠隔操作システム",
              phaseInCharge: "フロントエンド\n要件定義～テスト",
              role: 4,
              usedTechnicalOSList: [
                const TechnicalOS(osId: 'mac', monthOfOS: 8),
              ],
              usedTechnicalSkillList: [
                const TechnicalSkill(skillId: 'react', monthOfSkill: 8),
                const TechnicalSkill(skillId: 'type_script', monthOfSkill: 7),
              ]),
          JobCareer(
              careerId: 6,
              careerPeriodFrom: DateTime(2020, 01, 01),
              careerPeriodTo: DateTime(2021, 08, 31),
              content: "空調機器設置遠隔操作システム",
              phaseInCharge: "フロントエンド\n要件定義～テスト",
              role: 4,
              usedTechnicalOSList: [
                const TechnicalOS(osId: 'mac', monthOfOS: 8),
              ],
              usedTechnicalSkillList: [
                const TechnicalSkill(skillId: 'react', monthOfSkill: 8),
                const TechnicalSkill(skillId: 'type_script', monthOfSkill: 7),
              ]),
          JobCareer(
              careerId: 7,
              careerPeriodFrom: DateTime(2020, 01, 01),
              careerPeriodTo: DateTime(2021, 08, 31),
              content: "空調機器設置遠隔操作システム",
              phaseInCharge: "フロントエンド\n要件定義～テスト",
              role: 4,
              usedTechnicalOSList: [
                const TechnicalOS(osId: 'mac', monthOfOS: 8),
              ],
              usedTechnicalSkillList: [
                const TechnicalSkill(skillId: 'react', monthOfSkill: 8),
                const TechnicalSkill(skillId: 'type_script', monthOfSkill: 7),
              ]),
        ]);
    void _save(Persondata) async {
      final pdf = await PdfCreator.create(Persondata, false, true);
      final bytes = await pdf.save();
      final fileName = '技術経歴書Y.W.pdf';
      await SaveHelper.save(
        bytes: bytes,
        fileName: fileName,
        platform: Theme.of(context).platform,
      );
    }

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
                    const Padding(padding: EdgeInsets.only(top: 8)),
                    Row(children: [
                      age(false, Persondata),
                      sex(false, Persondata),
                    ]),
                    Container(
                        margin: const EdgeInsets.only(left: 48.0),
                        child: const Divider()),
                    station(false, Persondata),
                    favoriteSkill(false, Persondata),
                    const Divider(),
                    const Padding(padding: EdgeInsets.only(top: 8)),
                    headline('言語経歴'),
                    technicalSkill(Persondata),
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
    padding: const EdgeInsets.only(top: 8),
    child: Align(
      alignment: Alignment.centerLeft,
      child: Text(
        headName,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    ),
  );
}

// 写真
Widget image(Person personItem, double size) {
  return Padding(
    padding: const EdgeInsets.only(right: 16),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(45),
      child: Image.network(
        personItem.image,
        width: size,
        height: size,
      ),
    ),
  );
}

// ふりがな
Widget ruby(Person personItem) {
  return Flexible(
    child: Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Text(
          personItem.ruby,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ),
  );
}

// 名前
Widget name(Person personItem, double fontSize) {
  return Flexible(
    child: Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Text(
          personItem.name,
          style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ),
  );
}

// 年齢
Widget age(bool isCard, Person personItem) {
  if (isCard) {
    return Row(
      // Property
      children: [
        Icon(FontAwesomeIcons.addressCard, size: 20, color: HexColor()),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '${personItem.age}歳',
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
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '年齢',
                      style: TextStyle(fontSize: 12, color: HexColor()),
                    ),
                    Text(
                      '${personItem.age}歳',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ])),
        ],
      ),
    );
  }
}

// 経験年数
Widget experience(bool isCard, Person personItem) {
  if (isCard) {
    return Row(
      // Property
      children: [
        Icon(FontAwesomeIcons.briefcase, size: 20, color: HexColor()),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '経験年数 ${personItem.experience} 年',
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
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            '経験年数 ${personItem.experience} 年',
            style: TextStyle(fontSize: 16, color: HexColor()),
          ),
        ),
      ],
    );
  }
}

// 性別
Widget sex(bool isCard, Person personItem) {
  if (isCard) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        // Property
        children: [
          Icon(
              personItem.sex == 0
                  ? FontAwesomeIcons.venus
                  : personItem.sex == 1
                      ? FontAwesomeIcons.mars
                      : FontAwesomeIcons.question,
              size: 20,
              color: HexColor()),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                ReplaceProfileData.replaceSex(personItem.sex),
                style: const TextStyle(fontSize: 16),
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
        padding: const EdgeInsets.only(top: 4),
        child: Row(
          // Property
          children: [
            Icon(
                personItem.sex == 0
                    ? FontAwesomeIcons.venus
                    : personItem.sex == 1
                        ? FontAwesomeIcons.mars
                        : FontAwesomeIcons.question,
                size: 30,
                color: HexColor()),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '性別',
                      style: TextStyle(fontSize: 12, color: HexColor()),
                    ),
                    Text(
                      ReplaceProfileData.replaceSex(personItem.sex),
                      style: const TextStyle(fontSize: 16),
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
Widget station(bool isCard, Person personItem) {
  if (isCard) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        // Property
        children: [
          Icon(FontAwesomeIcons.trainSubway, size: 20, color: HexColor()),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${personItem.station}駅',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  } else {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        // Property
        children: [
          Icon(FontAwesomeIcons.trainSubway, size: 30, color: HexColor()),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                '最寄り駅',
                style: TextStyle(fontSize: 12, color: HexColor()),
              ),
              Text(
                '${personItem.station}駅',
                style: const TextStyle(fontSize: 16),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

// 得意な言語
Widget favoriteSkill(bool isCard, Person personItem) {
  if (isCard) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Wrap(
          //RowからWrapへ
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Icon(
                FontAwesomeIcons.bookmark,
                size: 20,
                color: HexColor(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Wrap(
                children: personItem.favoriteSkill
                    .map((favoriteSkillItem) => Container(
                        margin: const EdgeInsets.only(bottom: 8, right: 16),
                        padding: const EdgeInsets.only(
                            top: 4, bottom: 4, left: 8, right: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: HexColor()),
                          borderRadius: BorderRadius.circular(45),
                        ),
                        child: Text(favoriteSkillItem)))
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
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 4, bottom: 4),
                      child: Text(
                        '得意な言語',
                        style: TextStyle(fontSize: 12, color: HexColor()),
                      ),
                    ),
                    Wrap(
                      children: personItem.favoriteSkill
                          .map((favoriteSkillItem) => Container(
                              margin:
                                  const EdgeInsets.only(bottom: 4, right: 16),
                              padding: const EdgeInsets.only(
                                  top: 4, bottom: 4, left: 8, right: 8),
                              decoration: BoxDecoration(
                                border: Border.all(color: HexColor()),
                                borderRadius: BorderRadius.circular(45),
                              ),
                              child: Text(favoriteSkillItem)))
                          .toList(),
                    ),
                  ]),
            ),
          )),
        ]);
  }
}

// テクニカルスキル
Widget technicalSkill(Person personItem) {
  if (personItem.technicalSkillList == null) {
    return const Padding(
        padding: EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
        child: Text(
          "言語経歴の登録がありません",
          style: TextStyle(fontSize: 16),
        ));
  }

  return SizedBox(
      height: personItem.technicalSkillList!.length * (64 + 8 + 8),
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: personItem.technicalSkillList!.length,
          itemBuilder: (context, index) {
            return Card(
              child: SizedBox(
                height: 64,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 8, bottom: 8, left: 16, right: 16),
                  child: Row(
                    // Property
                    children: [
                      ReplaceTechnical.getSkillIcon(
                          personItem.technicalSkillList![index].skillId,
                          30,
                          HexColor()),
                      Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ReplaceTechnical.replaceTechnicalSkill(
                                      personItem
                                          .technicalSkillList![index].skillId),
                                  style: const TextStyle(fontSize: 16),
                                ),
                                Text(
                                  CalcMonthOfSkill.calcMonthOfSkill(personItem
                                          .technicalSkillList![index]
                                          .monthOfSkill)
                                      .toString(),
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ])),
                    ],
                  ),
                ),
              ),
            );
          }));
}

// 最終更新日
Widget lastUpdateDate(bool isCard, Person personItem) {
  if (isCard) {
    return Row(
      // Property
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Icon(FontAwesomeIcons.clock, size: 14, color: HexColor()),
        Padding(
            padding: const EdgeInsets.only(left: 8),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                '最終更新時刻',
                style: TextStyle(fontSize: 9, color: HexColor()),
              ),
              Text(
                personItem.lastUpdateDate.toString().substring(0, 16),
                style: const TextStyle(fontSize: 12),
              ),
            ])),
      ],
    );
  } else {
    return Row(
      // Property
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Icon(FontAwesomeIcons.clock, size: 14, color: HexColor()),
        Padding(
            padding: const EdgeInsets.only(left: 8),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                '最終更新時刻',
                style: TextStyle(fontSize: 9, color: HexColor()),
              ),
              Text(
                personItem.lastUpdateDate.toString().substring(0, 16),
                style: const TextStyle(fontSize: 12),
              ),
            ])),
      ],
    );
  }
}

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
        const Padding(padding: EdgeInsets.only(right: 16)),
        Text(itemValue.toUpperCase()),
      ],
    ),
  );
}

  // PopupMenuItem<String> makePopupMenuDownloadItem(
  //     BuildContext context, String initial) {
  //   const itemValue = 'download';

  //   void _save() async {
  //     final pdf = await PdfCreator.create(personList[index], false, true);
  //     final bytes = await pdf.save();
  //     final fileName = '技術経歴書($initial).pdf';
  //     await SaveHelper.save(
  //       bytes: bytes,
  //       fileName: fileName,
  //       platform: Theme.of(context).platform,
  //     );
  //   }

  //   return PopupMenuItem(
  //     value: itemValue,
  //     onTap: _save,
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       children: [
  //         Icon(
  //           Icons.download,
  //           size: 24,
  //           color: HexColor(),
  //         ),
  //         const Padding(padding: EdgeInsets.only(right: 16)),
  //         Text(itemValue.toUpperCase()),
  //       ],
  //     ),
  //   );
  // }

