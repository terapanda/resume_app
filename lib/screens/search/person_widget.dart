import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:resume_app/component/popup_card/popup_card.dart';
import 'package:resume_app/model/person.dart';
import 'package:resume_app/screens/create_pdf/preview_page.dart';
import 'package:resume_app/services/firebaseService.dart';
import 'package:resume_app/services/pdf_creator.dart';
import 'package:resume_app/services/save_helper/save_helper.dart';
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

class PersonWidget extends StatelessWidget {
  final Person person;
  final int index;

  const PersonWidget({
    Key? key,
    required this.person,
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
    // TODO 権限設定追加予定
    if (true) {
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
          child: cardItemWidget(context),
          onDismissed: (direction) {
            FirebaseService.deletePerson(person.id);
          },
          confirmDismiss: (direction) async {
            return await showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('重要'),
                  content: Text('「${person.name}」を削除しますか'),
                  actions: [
                    SimpleDialogOption(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text('キャンセル'),
                    ),
                    SimpleDialogOption(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: const Text('続行'),
                    ),
                  ],
                );
              },
            );
          },
        ),
      );
    } else {
      return Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        child: cardItemWidget(context),
      );
    }
  }

  Widget cardItemWidget(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
        child: Column(
          children: [
            Row(children: [
              ImageWidget().get(person, 56),
              Flexible(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "${person.department}　${person.branchOffice ?? ""}",
                        style: const TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        person.name,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ]),
                ),
              ),
              PopupMenuButton(
                icon: const Icon(Icons.more_vert),
                itemBuilder: (context) {
                  return [
                    makePopupMenuItem('edit', FontAwesomeIcons.userPen),
                    makePopupMenuItem('pdf', FontAwesomeIcons.filePdf),
                    makePopupMenuDownloadItem(context, person.initial),
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
                        builder: (context) => PreviewPage(person: person),
                      ),
                    );
                  }
                },
              )
            ]),
            const Divider(),
            const Padding(padding: EdgeInsets.only(top: 8)),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              AgeWidget().get(true, person),
              ExperienceWidget().get(true, person),
            ]),
            SexWidget().get(true, person),
            StationWidget().get(true, person),
            FavoriteSkillWidget().get(true, person),
            LastUpdateDateWidget().get(true, person),
          ],
        ),
      ),
    );
  }

  Widget _popUpItemBody(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;

    void _save() async {
      final pdf = await PdfCreator.create(person, false, true);
      final bytes = await pdf.save();
      final fileName = '技術経歴書${person.initial}.pdf';
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
              ImageWidget().get(person, 88),
              Expanded(
                child: SizedBox(
                  height: 88,
                  child: Column(children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "${person.department}　${person.branchOffice ?? ""}",
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    NameWidget().get(person, 24),
                    ExperienceWidget().get(true, person),
                  ]),
                ),
              )
            ]),
            HeadlineWidget().get('プロフィール'),
            const Padding(padding: EdgeInsets.only(top: 8)),
            Row(children: [
              AgeWidget().get(false, person),
              SexWidget().get(false, person),
            ]),
            Container(
                margin: const EdgeInsets.only(left: 48.0),
                child: const Divider()),
            StationWidget().get(false, person),
            FavoriteSkillWidget().get(false, person),
            const Divider(),
            const Padding(padding: EdgeInsets.only(top: 8)),
            HeadlineWidget().get('言語経歴'),
            TechnicalSkillWidget().get(person, 'os'),
            TechnicalSkillWidget().get(person, 'skill'),
            TechnicalSkillWidget().get(person, 'db'),
            TechnicalSkillWidget().get(person, ''),
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
      final pdf = await PdfCreator.create(person, false, true);
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
