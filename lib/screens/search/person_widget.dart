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
import 'package:resume_app/utils/person_utils/age_widget.dart';
import 'package:resume_app/utils/person_utils/experience_widget.dart';
import 'package:resume_app/utils/person_utils/favorite_skill_widget.dart';
import 'package:resume_app/utils/person_utils/headline_widget.dart';
import 'package:resume_app/utils/person_utils/image_widget.dart';
import 'package:resume_app/utils/person_utils/last_update_date_widget.dart';
import 'package:resume_app/utils/person_utils/name_widget.dart';
import 'package:resume_app/utils/person_utils/sex_widget.dart';
import 'package:resume_app/utils/person_utils/station_widget.dart';
import 'package:resume_app/utils/person_utils/technical_skill_widget.dart';
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
                  ImageWidget().get(personList[index], 56),
                  NameWidget().get(personList[index], 16),
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
                      AgeWidget().get(true, personList[index]),
                      ExperienceWidget().get(true, personList[index]),
                    ]),
                SexWidget().get(true, personList[index]),
                StationWidget().get(true, personList[index]),
                FavoriteSkillWidget().get(true, personList[index]),
                LastUpdateDateWidget().get(true, personList[index]),
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
              ImageWidget().get(personList[index], 88),
              Expanded(
                child: SizedBox(
                  height: 88,
                  child: Column(children: [
                    NameWidget().get(personList[index], 24),
                    ExperienceWidget().get(true, personList[index]),
                  ]),
                ),
              )
            ]),
            HeadlineWidget().get('プロフィール'),
            const Padding(padding: EdgeInsets.only(top: 8)),
            Row(children: [
              AgeWidget().get(false, personList[index]),
              SexWidget().get(false, personList[index]),
            ]),
            Container(
                margin: const EdgeInsets.only(left: 48.0),
                child: const Divider()),
            StationWidget().get(false, personList[index]),
            FavoriteSkillWidget().get(false, personList[index]),
            const Divider(),
            const Padding(padding: EdgeInsets.only(top: 8)),
            HeadlineWidget().get('言語経歴'),
            TechnicalSkillWidget().get(personList[index]),
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
