import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:resume_app/model/person.dart';

import '../../model/job_career.dart';
import '../../utils/hex_color.dart';
import '../../utils/person_utils/headline_widget.dart';
import '../../utils/person_utils/technical_skill_widget.dart';
import '../../utils/replace_profile_data.dart';
import '../../utils/size_config.dart';
import '../create_pdf/preview_page.dart';

class ProjectEditScreen extends ConsumerStatefulWidget {
  final Person propPerson;
  final JobCareer propJobCareer;
  const ProjectEditScreen({
    Key? key,
    required this.propPerson,
    required this.propJobCareer,
  }) : super(key: key);

  @override
  ConsumerState<ProjectEditScreen> createState() => _ProjectEditScreenState();
}

class _ProjectEditScreenState extends ConsumerState<ProjectEditScreen> {
  late final Person person;
  late final JobCareer jobCareer;

  @override
  void initState() {
    super.initState();
    person = widget.propPerson;
    jobCareer = widget.propJobCareer;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '職務経歴編集',
        ),
        automaticallyImplyLeading: true,
      ),
      body: _listWidget(context),
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

  final _form = GlobalKey<FormState>();

  late AsyncValue user;

  Widget _listWidget(BuildContext context) {
    return Column(
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
  }
}
