import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:resume_app/component/popup_card/popup_card.dart';
import 'package:resume_app/model/person.dart';
import 'package:resume_app/screens/create_pdf/create_pdf_screen.dart';
import 'package:resume_app/screens/create_pdf/file_name_widget.dart';
import 'package:resume_app/services/pdf_creator.dart';
import 'package:resume_app/services/save_helper/save_helper.dart';
import 'package:resume_app/utils/development_language.dart';
import 'package:resume_app/utils/hex_color.dart';
import 'package:resume_app/screens/project_list_screen.dart';

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
          child: Padding(
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
                        makePopupMenuItem('delete', FontAwesomeIcons.trash),
                      ];
                    },
                    onSelected: (String value) {
                      if (value == 'edit') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProjectListScreen(),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CreatePdfScreen(person: personList[index])),
                        );
                      }
                    },
                  )
                ]),
                new Divider(),
                Padding(padding: EdgeInsets.only(top: 8)),
                Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween, // <= 今回のターゲット
                    children: [
                      age(true, personList[index]),
                      experience(true, personList[index]),
                    ]),
                sex(true, personList[index]),
                station(true, personList[index]),
                excelsAt(true, personList[index]),
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
      final pdf = await PdfCreator.create();
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
        outerPadding: EdgeInsets.all(0),
        innerPadding: EdgeInsets.all(16),
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
            Padding(padding: EdgeInsets.only(top: 8)),
            Row(children: [
              age(false, personList[index]),
              sex(false, personList[index]),
            ]),
            new Container(
                margin: const EdgeInsets.only(left: 48.0), child: Divider()),
            station(false, personList[index]),
            excelsAt(false, personList[index]),
            new Divider(),
            Padding(padding: EdgeInsets.only(top: 8)),
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
Widget image(Person personItem, double size) {
  return Padding(
    padding: EdgeInsets.only(right: 16),
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
        padding: EdgeInsets.only(bottom: 4),
        child: Text(
          personItem.ruby,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
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
        padding: EdgeInsets.only(bottom: 4),
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
          padding: EdgeInsets.only(left: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              personItem.age + '歳',
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
                      personItem.age + '歳',
                      style: TextStyle(fontSize: 16),
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
          padding: EdgeInsets.only(left: 16),
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
          padding: EdgeInsets.only(left: 16),
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
                personItem.sex == '0' ? '女性' : '男性',
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
                      personItem.sex == '0' ? '女性' : '男性',
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
Widget station(bool isCard, Person personItem) {
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
                personItem.station + '駅',
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
                personItem.station + '駅',
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
Widget excelsAt(bool isCard, Person personItem) {
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
                children: personItem.excelsAt
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
                      children: personItem.excelsAt
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
Widget technicalSkill(Person personItem) {
  return SizedBox(
      height: personItem.technicalSkill.length * (64 + 8 + 8),
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: personItem.technicalSkill.length,
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
                      DevelopmentLanguage.getDevelopmentLanguage(
                          personItem.technicalSkill[index].skillId,
                          30,
                          HexColor()),
                      Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  personItem.technicalSkill[index].skillName,
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  calcSkillExperience(personItem
                                          .technicalSkill[index]
                                          .skillExperience)
                                      .toString(),
                                  style: TextStyle(fontSize: 16),
                                ),
                              ])),
                    ],
                  ),
                ),
              ),
            );
          }));
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
