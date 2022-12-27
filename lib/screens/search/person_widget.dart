import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:resume_app/component/popup_card/popup_card.dart';
import 'package:resume_app/model/person.dart';
import 'package:resume_app/screens/create_pdf/preview_page.dart';
import 'package:resume_app/services/pdf_creator.dart';
import 'package:resume_app/services/save_helper/save_helper.dart';
import 'package:resume_app/utils/calc_years_of_skill.dart';
import 'package:resume_app/utils/hex_color.dart';
import 'package:resume_app/screens/project_list_screen.dart';
import 'package:resume_app/utils/replace_profile_data.dart';
import 'package:resume_app/utils/replace_technical.dart';

class PersonWidget extends StatelessWidget {
  final List<Person> personList;
  final int index;

  const PersonWidget({
    Key? key,
    required this.personList,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupItemLauncher(
      padding: const EdgeInsets.all(4.0),
      tag: 'tag$index',
      card: _cardItemBody(context),
      popUp: _popUpItemBody(context),
    );
  }

  Widget _cardItemBody(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: AlignmentDirectional.centerEnd,
          color: Colors.red,
          child: const Padding(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
            //Padding配下にchildを足し、Iconを配置
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ), //ここまで追加
          ),
        ),
        child: Card(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
            child: Column(
              children: [
                Row(children: [
                  image(personList[index], 56),
                  name(personList[index], 16),
                  PopupMenuButton(
                    icon: const Icon(Icons.more_vert),
                    itemBuilder: (context) {
                      return [
                        makePopupMenuItem('edit', FontAwesomeIcons.userPen),
                        makePopupMenuItem('pdf', FontAwesomeIcons.filePdf),
                        makePopupMenuDownloadItem(
                            context, personList[index].initial),
                      ];
                    },
                    onSelected: (String value) {
                      if (value == 'edit') {
                        Navigator.push(
                          context,
                          MaterialWithModalsPageRoute(
                            builder: (context) => const ProjectListScreen(),
                          ),
                        );
                      } else if (value == 'pdf') {
                        Navigator.push(
                          context,
                          MaterialWithModalsPageRoute(
                            builder: (context) =>
                                PreviewPage(person: personList[index]),
                          ),
                        );
                      }
                    },
                  )
                ]),
                const Divider(),
                const Padding(padding: EdgeInsets.only(top: 8)),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      age(true, personList[index]),
                      experience(true, personList[index]),
                    ]),
                sex(true, personList[index]),
                station(true, personList[index]),
                favoriteSkill(true, personList[index]),
                lastUpdateDate(true, personList[index]),
                // new Divider(),
                // Padding(padding: EdgeInsets.only(top: 8)),
                // technicalSkill(personList[index]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _popUpItemBody(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;

    void _save() async {
      final pdf = await PdfCreator.create(personList[index], false, true);
      final bytes = await pdf.save();
      final fileName = '技術経歴書${personList[index].initial}.pdf';
      await SaveHelper.save(
        bytes: bytes,
        fileName: fileName,
        platform: Theme.of(context).platform,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'エンジニア',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: true,
      ),
      body: PopUpItem(
        height: deviceHeight,
        outerPadding: const EdgeInsets.all(0),
        innerPadding: const EdgeInsets.all(16),
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        elevation: 2,
        tag: 'tag$index',
        child: Column(
          children: [
            Row(children: [
              image(personList[index], 88),
              Expanded(
                child: SizedBox(
                  height: 88,
                  child: Column(children: [
                    name(personList[index], 24),
                    experience(true, personList[index]),
                  ]),
                ),
              )
            ]),
            headline('プロフィール'),
            const Padding(padding: EdgeInsets.only(top: 8)),
            Row(children: [
              age(false, personList[index]),
              sex(false, personList[index]),
            ]),
            Container(
                margin: const EdgeInsets.only(left: 48.0),
                child: const Divider()),
            station(false, personList[index]),
            favoriteSkill(false, personList[index]),
            const Divider(),
            const Padding(padding: EdgeInsets.only(top: 8)),
            headline('言語経歴'),
            technicalSkill(personList[index]),
          ],
        ),
      ),
      floatingActionButton: ButtonBar(
        children: [
          ElevatedButton.icon(
            icon: const Icon(Icons.download),
            label: const Text('Download'),
            onPressed: _save,
          ),
          // ElevatedButton.icon(
          //   icon: const Icon(Icons.navigate_next),
          //   label: const Text('Preview'),
          //   style: ElevatedButton.styleFrom(primary: Colors.pink),
          //   onPressed: _preview,
          // ),
        ],
      ),
    );
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

// 名前
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
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                                        personItem.technicalSkillList![index]
                                            .skillId),
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    CalcYearsOfSkill.calcYearsOfSkill(personItem
                                            .technicalSkillList![index]
                                            .yearsOfSkill)
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
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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

  PopupMenuItem<String> makePopupMenuDownloadItem(
      BuildContext context, String initial) {
    const itemValue = 'download';

    void _save() async {
      final pdf = await PdfCreator.create(personList[index], false, true);
      final bytes = await pdf.save();
      final fileName = '技術経歴書($initial).pdf';
      await SaveHelper.save(
        bytes: bytes,
        fileName: fileName,
        platform: Theme.of(context).platform,
      );
    }

    return PopupMenuItem(
      value: itemValue,
      onTap: _save,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.download,
            size: 24,
            color: HexColor(),
          ),
          const Padding(padding: EdgeInsets.only(right: 16)),
          Text(itemValue.toUpperCase()),
        ],
      ),
    );
  }
}
