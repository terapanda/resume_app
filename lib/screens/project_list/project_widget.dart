import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:resume_app/component/popup_card/popup_card.dart';
import 'package:resume_app/model/job_career.dart';
import 'package:resume_app/model/person.dart';
import 'package:resume_app/model/person_converter.dart';
import 'package:resume_app/provider/user_state.dart';
import 'package:resume_app/screens/create_pdf/preview_page.dart';
import 'package:resume_app/screens/project_list/project_edit_screen.dart';
import 'package:resume_app/services/firebaseService.dart';
import 'package:resume_app/services/pdf_creator.dart';
import 'package:resume_app/services/save_helper/save_helper.dart';
import 'package:resume_app/utils/hex_color.dart';
import 'package:resume_app/utils/person_utils/age_widget.dart';
import 'package:resume_app/utils/person_utils/experience_widget.dart';
import 'package:resume_app/utils/person_utils/favorite_skill_widget.dart';
import 'package:resume_app/utils/person_utils/headline_widget.dart';
import 'package:resume_app/utils/person_utils/image_widget.dart';
import 'package:resume_app/utils/person_utils/name_widget.dart';
import 'package:resume_app/utils/person_utils/sex_widget.dart';
import 'package:resume_app/utils/person_utils/station_widget.dart';
import 'package:resume_app/utils/person_utils/technical_skill_widget.dart';
import 'package:resume_app/utils/replace_profile_data.dart';

import '../../provider/person_provider.dart';

class ProjectWidget extends ConsumerStatefulWidget {
  final Person propPerson;
  final JobCareer propJobCareer;
  final int propIndex;

  const ProjectWidget({
    Key? key,
    required this.propPerson,
    required this.propJobCareer,
    required this.propIndex,
  }) : super(key: key);

  @override
  ConsumerState<ProjectWidget> createState() => _ProjectWidgetState();
}

class _ProjectWidgetState extends ConsumerState<ProjectWidget> {
  late Person person;
  late JobCareer jobCareer;
  late int index;

  late bool editMode;

  @override
  void initState() {
    super.initState();
    person = widget.propPerson;
    jobCareer = widget.propJobCareer;
    index = widget.propIndex;

    editMode = false;
  }

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
    final userstate = ref.read(userStateProvider);
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
          FirebaseService.deletejobCareer(person.id, jobCareer.careerId);
        },
        confirmDismiss: (direction) async {
          return await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('重要'),
                content: Text('「${jobCareer.content}」を削除しますか'),
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
              Flexible(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        jobCareer.content,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ]),
                ),
              ),
            ]),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(FontAwesomeIcons.calendar, size: 14, color: HexColor()),
                Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '参画期間',
                            style: TextStyle(fontSize: 9, color: HexColor()),
                          ),
                          Text(
                            '${jobCareer.careerPeriodFrom.toString().substring(0, 10)} ~ ${jobCareer.careerPeriodTo.toString().substring(0, 10)}',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ])),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _popUpItemBody(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    PdfCreator pdfCreator = PdfCreator();

    void _save() async {
      person.jobCareerList =
          await PersonConverter.fetchJobCareerList(person.id);
      final pdf = await pdfCreator.create(person, false, true);
      final bytes = await pdf.save();
      final fileName = '技術経歴書${person.initial}.pdf';
      await SaveHelper.save(
        bytes: bytes,
        fileName: fileName,
        platform: Theme.of(context).platform,
      );
    }

    var popUpItem = Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Column(children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                jobCareer.content,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ]),
        ),
        const Padding(padding: EdgeInsets.only(top: 24)),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(FontAwesomeIcons.calendar, size: 30, color: HexColor()),
            Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '参画期間',
                        style: TextStyle(fontSize: 14, color: HexColor()),
                      ),
                      Text(
                        '${ReplaceProfileData().replaceYMDforJp(jobCareer.careerPeriodFrom)} ~ ${ReplaceProfileData().replaceYMDforJp(jobCareer.careerPeriodTo)}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ])),
          ],
        ),
        const Padding(padding: EdgeInsets.only(top: 16)),
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
            flex: 1, // 1 要素分の横幅
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              // Property
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Icon(FontAwesomeIcons.addressCard,
                        size: 30, color: HexColor())),
                Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '役割',
                            style: TextStyle(fontSize: 12, color: HexColor()),
                          ),
                          Text(
                            jobCareer.role,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ])),
              ],
            ),
          ),
          Expanded(
              child: Align(
            alignment: Alignment.topLeft,
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                // Property
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Icon(Icons.workspace_premium,
                          size: 30, color: HexColor())),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text(
                              '担当フェーズ',
                              style: TextStyle(fontSize: 12, color: HexColor()),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: jobCareer.phase
                                .map((phaseItem) => Container(
                                    margin: const EdgeInsets.only(
                                        bottom: 4, right: 16, left: 8),
                                    child: Text(
                                      phaseItem,
                                      style: const TextStyle(fontSize: 15),
                                    )))
                                .toList(),
                          )
                        ]),
                  ),
                ]),
          )),
        ]),
        const Divider(),
        const Padding(padding: EdgeInsets.only(top: 8)),
        HeadlineWidget().get('言語経歴'),
        TechnicalSkillWidgetForJobJobCareer().get(jobCareer, 'os'),
        TechnicalSkillWidgetForJobJobCareer().get(jobCareer, 'skill'),
        TechnicalSkillWidgetForJobJobCareer().get(jobCareer, 'db'),
        TechnicalSkillWidgetForJobJobCareer().get(jobCareer, ''),
      ],
    );

    var popUpItemEdit = Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Column(children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                jobCareer.content,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ]),
        ),
        const Padding(padding: EdgeInsets.only(top: 24)),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(FontAwesomeIcons.calendar, size: 30, color: HexColor()),
            Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '参画期間',
                        style: TextStyle(fontSize: 14, color: HexColor()),
                      ),
                      Text(
                        '${ReplaceProfileData().replaceYMDforJp(jobCareer.careerPeriodFrom)} ~ ${ReplaceProfileData().replaceYMDforJp(jobCareer.careerPeriodTo)}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ])),
          ],
        ),
        const Padding(padding: EdgeInsets.only(top: 16)),
        // Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        //   Expanded(
        //     flex: 1, // 1 要素分の横幅
        //     child: Row(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       // Property
        //       children: [
        //         Padding(
        //             padding: const EdgeInsets.only(top: 8),
        //             child: Icon(FontAwesomeIcons.addressCard,
        //                 size: 30, color: HexColor())),
        //         Padding(
        //             padding: const EdgeInsets.only(left: 16),
        //             child: Column(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   Text(
        //                     '役割',
        //                     style: TextStyle(fontSize: 12, color: HexColor()),
        //                   ),
        //                   Text(
        //                     jobCareer.role,
        //                     style: const TextStyle(fontSize: 16),
        //                   ),
        //                 ])),
        //       ],
        //     ),
        //   ),
        //   Expanded(
        //       child: Align(
        //     alignment: Alignment.topLeft,
        //     child: Row(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         // Property
        //         children: [
        //           Padding(
        //               padding: const EdgeInsets.only(top: 8),
        //               child: Icon(Icons.workspace_premium,
        //                   size: 30, color: HexColor())),
        //           Padding(
        //             padding: const EdgeInsets.only(left: 16),
        //             child: Column(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   Padding(
        //                     padding: const EdgeInsets.only(bottom: 4),
        //                     child: Text(
        //                       '担当フェーズ',
        //                       style: TextStyle(fontSize: 12, color: HexColor()),
        //                     ),
        //                   ),
        //                   Column(
        //                     crossAxisAlignment: CrossAxisAlignment.start,
        //                     children: jobCareer.phase
        //                         .map((phaseItem) => Container(
        //                             margin: const EdgeInsets.only(
        //                                 bottom: 4, right: 16, left: 8),
        //                             child: Text(
        //                               phaseItem,
        //                               style: const TextStyle(fontSize: 15),
        //                             )))
        //                         .toList(),
        //                   )
        //                 ]),
        //           ),
        //         ]),
        //   )),
        // ]),
        // const Divider(),
        // const Padding(padding: EdgeInsets.only(top: 8)),
        // HeadlineWidget().get('言語経歴'),
        // TechnicalSkillWidgetForJobJobCareer().get(jobCareer, 'os'),
        // TechnicalSkillWidgetForJobJobCareer().get(jobCareer, 'skill'),
        // TechnicalSkillWidgetForJobJobCareer().get(jobCareer, 'db'),
        // TechnicalSkillWidgetForJobJobCareer().get(jobCareer, ''),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '職務経歴',
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                editMode = !editMode;
              });
            },
            child: editMode
                ? Text(
                    '保存',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  )
                : Text(
                    '編集',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
          ),
        ],
        automaticallyImplyLeading: true,
      ),
      body: PopUpItem(
        height: deviceHeight,
        outerPadding: const EdgeInsets.all(0),
        innerPadding: const EdgeInsets.all(16),
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        elevation: 2,
        tag: 'tag${index}',
        child: editMode ? popUpItemEdit : popUpItem,
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
                  builder: (context) => PreviewPage(person: person),
                ),
              );
            },
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
      person.jobCareerList =
          await PersonConverter.fetchJobCareerList(person.id);
      final pdf = await pdfCreator.create(person, false, true);
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
