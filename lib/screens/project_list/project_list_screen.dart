import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:resume_app/model/person.dart';
import 'package:resume_app/screens/project_list/project_card.dart';
import 'package:resume_app/utils/unfocus_keybord.dart';

import '../../model/job_career.dart';
import '../../utils/size_config.dart';

class ProjectListScreen extends ConsumerStatefulWidget {
  final Person propPerson;
  final List<JobCareer> propJobCareerList;
  const ProjectListScreen({
    Key? key,
    required this.propPerson,
    required this.propJobCareerList,
  }) : super(key: key);

  @override
  ConsumerState<ProjectListScreen> createState() => _ProjectListScreenState();
}

class _ProjectListScreenState extends ConsumerState<ProjectListScreen> {
  late final Person person;
  late final List<JobCareer> jobCareerList;

  @override
  void initState() {
    super.initState();
    person = widget.propPerson;
    jobCareerList = widget.propJobCareerList;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(title: Text('プロジェクト一覧')),
      body: _listWidget(context),
    );
  }

  final _form = GlobalKey<FormState>();

  late AsyncValue user;

  Widget _listWidget(BuildContext context) {
    return SingleChildScrollView(
        child: UnfocusKeybord(
            child: Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: jobCareerList.length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        child: ProjectCard(
                            propIndex: index,
                            propJobCareer: jobCareerList[index],
                            propPerson: person),
                      );
                    }))));
  }
}
