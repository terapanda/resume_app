import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:resume_app/component/popup_card/popup_card.dart';
import 'package:resume_app/model/person.dart';
import 'package:resume_app/model/person_converter.dart';
import 'package:resume_app/provider/user_state.dart';
import 'package:resume_app/screens/create_pdf/preview_page.dart';
import 'package:resume_app/services/firebaseService.dart';
import 'package:resume_app/services/pdf_creator.dart';
import 'package:resume_app/services/save_helper/save_helper.dart';
import 'package:resume_app/utils/auth_check.dart';
import 'package:resume_app/utils/hex_color.dart';
import 'package:resume_app/screens/project_list/project_list_screen.dart';
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

import '../../model/job_career.dart';
import '../../provider/person_provider.dart';

class PersonWidget extends ConsumerStatefulWidget {
  final Person person;
  final int index;

  const PersonWidget({
    Key? key,
    required this.person,
    required this.index,
  }) : super(key: key);

  @override
  ConsumerState<PersonWidget> createState() => _PersonWidgetState();
}

class _PersonWidgetState extends ConsumerState<PersonWidget> {
  @override
  Widget build(BuildContext context) {
    return PopupItemLauncher(
      padding: const EdgeInsets.all(4.0),
      tag: 'tag${widget.index}',
      card: _cardItemBody(context),
      popUp: _popUpItemBody(context),
    );
  }

  Widget _cardItemBody(BuildContext context) {
    final userstate = ref.read(userStateProvider);
    // 管理者の場合ユーザ削除可能
    if (allowAdmin(userstate)) {
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
            FirebaseService.deletePerson(widget.person.id);
          },
          confirmDismiss: (direction) async {
            return await showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('重要'),
                  content: Text('「${widget.person.name}」を削除しますか'),
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
    final userstate = ref.read(userStateProvider);
    final googleUserInfostate = ref.read(GoogleUserInfoProvider);
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
        child: Column(
          children: [
            Row(children: [
              ImageWidget().get(widget.person, 56),
              Flexible(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "${widget.person.department}　${widget.person.branchOffice ?? ""}",
                        style: const TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.person.name,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ]),
                ),
              ),
              if (googleUserInfostate == widget.person.id ||
                  allowAdmin(userstate))
                PopupMenuButton(
                  icon: const Icon(Icons.more_vert),
                  itemBuilder: (context) {
                    return [
                      makePopupMenuItem(
                          'job carrier', FontAwesomeIcons.userPen),
                      makePopupMenuItem('pdf', FontAwesomeIcons.filePdf),
                      makePopupMenuDownloadItem(context, widget.person.initial),
                    ];
                  },
                  onSelected: (String value) async {
                    final List<JobCareer> jobCareerList =
                        await PersonConverter.fetchJobCareerList(
                            widget.person.id);
                    widget.person.jobCareerList = jobCareerList;
                    if (value == 'job carrier') {
                      // snapshot.docs[0].data()
                      Navigator.push(
                        context,
                        MaterialWithModalsPageRoute(
                          builder: (context) => ProjectListScreen(
                              propPerson: widget.person,
                              propJobCareerList: widget.person.jobCareerList!),
                        ),
                      );
                    } else if (value == 'pdf') {
                      Navigator.push(
                        context,
                        MaterialWithModalsPageRoute(
                          builder: (context) =>
                              PreviewPage(person: widget.person),
                        ),
                      );
                    }
                  },
                )
            ]),
            const Divider(),
            const Padding(padding: EdgeInsets.only(top: 8)),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              AgeWidget().get(true, widget.person),
              ExperienceWidget().get(true, widget.person),
            ]),
            SexWidget().get(true, widget.person),
            StationWidget().get(true, widget.person),
            FavoriteSkillWidget().get(true, widget.person),
            LastUpdateDateWidget().get(true, widget.person),
          ],
        ),
      ),
    );
  }

  Widget _popUpItemBody(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    PdfCreator pdfCreator = PdfCreator();

    void _save() async {
      widget.person.jobCareerList =
          await PersonConverter.fetchJobCareerList(widget.person.id);
      final pdf = await pdfCreator.create(widget.person, false, true);
      final bytes = await pdf.save();
      final fileName = '技術経歴書${widget.person.initial}.pdf';
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
        tag: 'tag${widget.index}',
        child: Column(
          children: [
            Row(children: [
              ImageWidget().get(widget.person, 88),
              Expanded(
                child: SizedBox(
                  height: 88,
                  child: Column(children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "${widget.person.department}　${widget.person.branchOffice ?? ""}",
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    NameWidget().get(widget.person, 24),
                    ExperienceWidget().get(true, widget.person),
                  ]),
                ),
              )
            ]),
            HeadlineWidget().get('プロフィール'),
            const Padding(padding: EdgeInsets.only(top: 8)),
            Row(children: [
              AgeWidget().get(false, widget.person),
              SexWidget().get(false, widget.person),
            ]),
            Container(
                margin: const EdgeInsets.only(left: 48.0),
                child: const Divider()),
            StationWidget().get(false, widget.person),
            FavoriteSkillWidget().get(false, widget.person),
            const Divider(),
            const Padding(padding: EdgeInsets.only(top: 8)),
            HeadlineWidget().get('言語経歴'),
            TechnicalSkillWidget().get(widget.person, 'os'),
            TechnicalSkillWidget().get(widget.person, 'skill'),
            TechnicalSkillWidget().get(widget.person, 'db'),
            TechnicalSkillWidget().get(widget.person, ''),
          ],
        ),
      ),
      floatingActionButton: ButtonBar(
        children: [
          ElevatedButton.icon(
            icon: const Icon(FontAwesomeIcons.filePdf),
            label: const Text('PDF Preview'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialWithModalsPageRoute(
                  builder: (context) => PreviewPage(person: widget.person),
                ),
              );
            },
          ),
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
    PdfCreator pdfCreator = PdfCreator();
    const itemValue = 'download';

    void _save() async {
      widget.person.jobCareerList =
          await PersonConverter.fetchJobCareerList(widget.person.id);
      final pdf = await pdfCreator.create(widget.person, false, true);
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
