import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:resume_app/model/job_career.dart';
import 'package:resume_app/model/person.dart';
import 'package:resume_app/provider/user_state.dart';
import 'package:resume_app/screens/project_list/project_screen.dart';
import 'package:resume_app/services/firebaseService.dart';
import 'package:resume_app/utils/hex_color.dart';
import '../../provider/person_provider.dart';

class ProjectCard extends ConsumerStatefulWidget {
  final Person propPerson;
  final JobCareer propJobCareer;
  final int propIndex;

  const ProjectCard({
    Key? key,
    required this.propPerson,
    required this.propJobCareer,
    required this.propIndex,
  }) : super(key: key);

  @override
  ConsumerState<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends ConsumerState<ProjectCard> {
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
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialWithModalsPageRoute(
            builder: (context) => Project(
                propPerson: person, propJobCareer: jobCareer, propIndex: index),
          ),
        );
      },
      child: Card(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
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
      ),
    );
  }
}
