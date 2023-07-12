import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:multiselect_dropdown_flutter/multiselect_dropdown_flutter.dart';
import 'package:resume_app/model/person.dart';
import 'package:resume_app/screens/create_pdf/preview_page.dart';
import 'package:resume_app/utils/hex_color.dart';
import 'package:resume_app/utils/person_utils/headline_widget.dart';
import 'package:resume_app/utils/person_utils/technical_skill_widget.dart';
import 'package:resume_app/utils/replace_profile_data.dart';

import '../../model/job_career.dart';
import '../../model/technical_db.dart';
import '../../model/technical_os.dart';
import '../../model/technical_skill.dart';
import '../../model/userInfo_model.dart' as userInfoModel;
import '../../services/firebaseService.dart';
import '../../utils/calc_years_of_skill.dart';
import '../../utils/select_bottom_sheet.dart';
import '../../utils/use_shared_preferences.dart';

class ProjectAdd extends ConsumerStatefulWidget {
  final Person propPerson;
  final int propIndex;

  const ProjectAdd({
    Key? key,
    required this.propPerson,
    required this.propIndex,
  }) : super(key: key);

  @override
  ConsumerState<ProjectAdd> createState() => _ProjectAddState();
}

class _ProjectAddState extends ConsumerState<ProjectAdd> {
  late Person person;
  late int jobIndex;

  final contentController = TextEditingController();
  final careerPeriodFromController = TextEditingController();
  final careerPeriodToController = TextEditingController();
  final roleController = TextEditingController();
  final step1Controller = TextEditingController();
  final step2Controller = TextEditingController();
  final step3Controller = TextEditingController();

  late Map<dynamic, String> roleMaster;
  late Map<dynamic, String> developLanguageOSMaster;
  late Map<dynamic, String> developLanguageSkillMaster;
  late Map<dynamic, String> developLanguageDBMaster;
  late JobCareer jobCareer;
  Map<dynamic, String> phaseMaster = {};
  late String tempRole;
  late String tempCareerPeriodFrom;
  late String tempCareerPeriodTo;
  List selectedPhaseMasterList = [];
  List phaseMasterList = [];
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    person = widget.propPerson;
    jobIndex = widget.propIndex;

    contentController.text = '';
    careerPeriodFromController.text = '';
    careerPeriodToController.text = '';
    roleController.text = '';
    tempRole = '';
    tempCareerPeriodFrom = '';
    tempCareerPeriodTo = '';
    selectedPhaseMasterList = [];

    jobCareer = JobCareer(
        careerId: jobIndex + 1,
        content: '',
        careerPeriodFrom: DateTime.now(),
        careerPeriodTo: DateTime.now(),
        role: '',
        phase: [],
        usedTechnicalOSList: [],
        usedTechnicalSkillList: [],
        usedTechnicalDBList: []);
  }

  @override
  void dispose() {
    super.dispose();
  }

  // Future型は非同期処理（時間のかかる処理）
  Future<String> initialize() async {
    final masterData = await UseSharedPreferences.getUserDefaults('master');
    final encodeData = UseSharedPreferences.decodeMasterMap(masterData);
    roleMaster = encodeData['role']!;
    phaseMaster = encodeData['phase']!;
    developLanguageOSMaster = encodeData['developLanguageOS']!;
    developLanguageSkillMaster = encodeData['developLanguageSkill']!;
    developLanguageDBMaster = encodeData['developLanguageDB']!;

    step1Controller.text = "os";
    step2Controller.text = "";
    step3Controller.text = "1";

    for (var phaseMasterItem in phaseMaster.entries) {
      phaseMasterList
          .add({'key': phaseMasterItem.key, 'value': phaseMasterItem.value});
    }

    return 'Data Loaded';
  }

  @override
  Widget build(BuildContext context) {
    var popUpItemAdd = Column(
      children: [
        const Padding(padding: EdgeInsets.only(top: 16)),
        Align(
          alignment: Alignment.centerLeft,
          child: Column(children: [
            TextField(
              textInputAction: TextInputAction.done,
              controller: contentController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black54,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.pinkAccent,
                  ),
                ),
                labelText: '案件名',
                labelStyle: TextStyle(
                  color: Colors.black54,
                ),
                prefixIconColor: Colors.black54,
                // prefixIcon: Icon(Icons.edit),
              ),
            ),
          ]),
        ),
        const Padding(padding: EdgeInsets.only(top: 24)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextField(
                    style: const TextStyle(fontSize: 14),
                    readOnly: true,
                    textInputAction: TextInputAction.done,
                    controller: careerPeriodFromController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black54,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.pinkAccent,
                        ),
                      ),
                      labelText: '参画期間From',
                      labelStyle: TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                    onTap: () {
                      tempCareerPeriodFrom = careerPeriodFromController.text;

                      DatePicker.showDatePicker(context,
                          showTitleActions: true,
                          minTime: DateTime(1900, 1, 1),
                          maxTime: DateTime.now(), onChanged: (date) {
                        print('change $date');
                        jobCareer.careerPeriodFrom = date;
                        careerPeriodFromController.text =
                            ReplaceProfileData().replaceYMDforJp(date);
                      }, onConfirm: (date) {
                        print('confirm $date');
                        jobCareer.careerPeriodFrom = date;
                        print(date);
                        careerPeriodFromController.text =
                            ReplaceProfileData().replaceYMDforJp(date);
                      }, onCancel: () {
                        careerPeriodFromController.text = tempCareerPeriodFrom;
                      }, locale: LocaleType.jp);
                    },
                  ),
                ),
                SizedBox(
                  width: 20,
                  child: Text(
                    ' ~ ',
                    style: TextStyle(fontSize: 14, color: HexColor()),
                  ),
                ),
                Expanded(
                  child: TextField(
                    style: const TextStyle(fontSize: 14),
                    readOnly: true,
                    textInputAction: TextInputAction.done,
                    controller: careerPeriodToController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black54,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.pinkAccent,
                        ),
                      ),
                      labelText: '参画期間To',
                      labelStyle: TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                    onTap: () {
                      tempCareerPeriodTo = careerPeriodToController.text;

                      DatePicker.showDatePicker(context,
                          showTitleActions: true,
                          minTime: DateTime(1900, 1, 1),
                          maxTime: DateTime.now(), onChanged: (date) {
                        print('change $date');
                        jobCareer.careerPeriodTo = date;
                        careerPeriodToController.text =
                            ReplaceProfileData().replaceYMDforJp(date);
                      }, onConfirm: (date) {
                        print('confirm $date');
                        jobCareer.careerPeriodTo = date;
                        careerPeriodToController.text =
                            ReplaceProfileData().replaceYMDforJp(date);
                      }, onCancel: () {
                        careerPeriodToController.text = tempCareerPeriodTo;
                      }, locale: LocaleType.jp);
                    },
                  ),
                ),
              ],
            )
          ],
        ),
        const Padding(padding: EdgeInsets.only(top: 16)),
        TextField(
          style: const TextStyle(fontSize: 14),
          readOnly: true,
          textInputAction: TextInputAction.done,
          controller: roleController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black54,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.pinkAccent,
              ),
            ),
            labelText: '役割',
            labelStyle: TextStyle(
              color: Colors.black54,
            ),
          ),
          onTap: () {
            if (roleController.text == '') {
              roleController.text = 'PM';
            }
            tempRole = roleController.text;

            selectBottomSheet(
              context,
              [
                for (int key in roleMaster.keys) ...{
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(roleMaster[key]!),
                  )
                },
              ],
              (int index) async {
                roleController.text = await ReplaceProfileData()
                    .replaceRole(roleMaster.keys.elementAt(index));
              },
              () async {
                tempRole = roleController.text;
                Navigator.pop(context);
              },
              () async {
                roleController.text = tempRole;
                Navigator.pop(context);
              },
            );
          },
        ),
        const Padding(padding: EdgeInsets.only(top: 16)),
        MultiSelectDropdown(
          list: phaseMasterList,
          id: 'key',
          label: 'value',
          initiallySelected: selectedPhaseMasterList,
          onChange: (newList) {
            selectedPhaseMasterList = newList;
          },
          splashColor: Colors.black38,
          checkboxFillColor: Colors.pinkAccent,
          isLarge: true,
          textStyle: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
          whenEmpty: '担当フェーズ',
        ),
        const Divider(),
        const Padding(padding: EdgeInsets.only(top: 8)),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          HeadlineWidget().get('OS/言語/DB'),
          Padding(
            padding: const EdgeInsets.only(top: 16, right: 4),
            child: InkWell(
              child: Row(children: [
                Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "追加",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.pinkAccent.shade100),
                    ),
                  ),
                ),
                const Icon(
                  FontAwesomeIcons.circlePlus,
                  size: 16,
                  color: Colors.pinkAccent,
                )
              ]),
              onTap: () {
                selectDevelopmentHistory(context);
              },
            ),
          ),
        ]),
        TechnicalSkillWidgetForJobJobCareer()
            .edit(jobCareer, 'os', parentFunction),
        TechnicalSkillWidgetForJobJobCareer()
            .edit(jobCareer, 'skill', parentFunction),
        TechnicalSkillWidgetForJobJobCareer()
            .edit(jobCareer, 'db', parentFunction),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '職務経歴',
        ),
        actions: [
          TextButton(
              onPressed: () async {
                await saveUserInfo();
                await saveUserInfoForSearchData();
                setState(() {});
                Navigator.pop(context);
              },
              child: const Text(
                '保存',
                style: TextStyle(color: Colors.black, fontSize: 18),
              )),
        ],
        automaticallyImplyLeading: true,
      ),
      body: FutureBuilder<void>(
          future: initialize(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // 値が存在する場合の処理
              return SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.all(16), child: popUpItemAdd));
            } else {
              // 値が存在しない場合の処理
              return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('Awaiting result...'),
                    ),
                  ]);
            }
          }),
    );
  }

  void selectDevelopmentHistory(BuildContext context) {
    selectBottomSheet(
      context,
      [
        const Padding(
          padding: EdgeInsets.only(top: 8),
          child: Text("os"),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 8),
          child: Text("skill"),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 8),
          child: Text("db"),
        )
      ],
      (int index) async {
        switch (index) {
          case 0:
            step1Controller.text = 'os';
            break;
          case 1:
            step1Controller.text = 'skill';
            break;
          case 2:
            step1Controller.text = 'db';
            break;
          default:
            step1Controller.text = 'os';
        }
      },
      () async {
        Navigator.pop(context);

        Map<dynamic, String> master = {};
        switch (step1Controller.text) {
          case 'os':
            master = developLanguageOSMaster;
            step2Controller.text = master.values.first;
            break;
          case 'skill':
            master = developLanguageSkillMaster;
            step2Controller.text = master.values.first;
            break;
          case 'db':
            master = developLanguageDBMaster;
            step2Controller.text = master.values.first;
            break;
          default:
            master = developLanguageOSMaster;
            step2Controller.text = master.values.first;
        }
        List step2List = [
          for (String key in master.keys) ...{master[key]!},
        ];

        selectBottomSheet(
          context,
          [
            for (String key in master.keys) ...{
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(master[key]!),
              )
            },
          ],
          (int key) {
            step2Controller.text = step2List[key];
          },
          () async {
            Navigator.pop(context);
            selectBottomSheet(
              context,
              [
                for (var i = 1; i < 241; i++) ...{
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(CalcMonth.calcMonth(i)),
                  )
                },
              ],
              (int key) {
                step3Controller.text = (key + 1).toString();
              },
              () async {
                Navigator.pop(context);
                switch (step1Controller.text) {
                  case 'os':
                    TechnicalOS technicalOS = TechnicalOS(
                        osId: await ReplaceProfileData()
                            .replaceOSForVal(step2Controller.text),
                        osName: step2Controller.text,
                        month: int.parse(step3Controller.text));

                    List<TechnicalOS> tempList = jobCareer.usedTechnicalOSList!;
                    // 同じ項目がないか探す。あったら消す。
                    for (var i = 0; i < tempList.length; i++) {
                      if (tempList[i].osId == technicalOS.osId) {
                        jobCareer.usedTechnicalOSList!.removeAt(i);
                      }
                    }
                    jobCareer.usedTechnicalOSList!.add(technicalOS);
                    break;
                  case 'skill':
                    TechnicalSkill technicalSkill = TechnicalSkill(
                        skillId: await ReplaceProfileData()
                            .replaceSkillForVal(step2Controller.text),
                        skillName: step2Controller.text,
                        month: int.parse(step3Controller.text));

                    List<TechnicalSkill> tempList =
                        jobCareer.usedTechnicalSkillList!;
                    // 同じ項目がないか探す。あったら消す。
                    for (var i = 0; i < tempList.length; i++) {
                      if (tempList[i].skillId == technicalSkill.skillId) {
                        jobCareer.usedTechnicalSkillList!.removeAt(i);
                      }
                    }
                    jobCareer.usedTechnicalSkillList!.add(technicalSkill);
                    break;
                  case 'db':
                    TechnicalDB technicalDB = TechnicalDB(
                        dbId: await ReplaceProfileData()
                            .replaceDBForVal(step2Controller.text),
                        dbName: step2Controller.text,
                        month: int.parse(step3Controller.text));

                    List<TechnicalDB> tempList = jobCareer.usedTechnicalDBList!;
                    // 同じ項目がないか探す。あったら消す。
                    for (var i = 0; i < tempList.length; i++) {
                      if (tempList[i].dbId == technicalDB.dbId) {
                        jobCareer.usedTechnicalDBList!.removeAt(i);
                      }
                    }
                    jobCareer.usedTechnicalDBList!.add(technicalDB);
                    break;
                  default:
                }
                setState(() {});
              },
              () async {
                step3Controller.text = '';
                Navigator.pop(context);
              },
            );
          },
          () async {
            step2Controller.text = '';
            Navigator.pop(context);
          },
        );
      },
      () async {
        step1Controller.text = '';
        Navigator.pop(context);
      },
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

  // データ保存(users)
  Future<void> saveUserInfo() async {
    List<int> selectedPhaseList = [];
    for (var i = 0; i < selectedPhaseMasterList.length; i++) {
      selectedPhaseList.add(selectedPhaseMasterList[i]["key"]);
    }

    List<userInfoModel.TechnicalOS> osList = [];
    for (var listItem in jobCareer.usedTechnicalOSList!) {
      osList.add(userInfoModel.TechnicalOS(
          osId: listItem.osId, month: listItem.month));
    }
    List<userInfoModel.TechnicalSkill> skillList = [];
    for (var listItem in jobCareer.usedTechnicalSkillList!) {
      skillList.add(userInfoModel.TechnicalSkill(
          skillId: listItem.skillId, month: listItem.month));
    }
    List<userInfoModel.TechnicalDB> dbList = [];
    for (var listItem in jobCareer.usedTechnicalDBList!) {
      dbList.add(userInfoModel.TechnicalDB(
          dbId: listItem.dbId, month: listItem.month));
    }

    userInfoModel.JobCareer userInfo = userInfoModel.JobCareer(
        careerId: jobCareer.careerId,
        content: contentController.text,
        careerPeriodFrom: jobCareer.careerPeriodFrom,
        careerPeriodTo: jobCareer.careerPeriodTo,
        role: await ReplaceProfileData().replaceRoleForVal(roleController.text),
        phase: selectedPhaseList,
        usedTechnicalOSList: osList,
        usedTechnicalSkillList: skillList,
        usedTechnicalDBList: dbList);
    FirebaseService.saveProject(person.id, userInfo);
  }

  // データ保存(search)
  Future<void> saveUserInfoForSearchData() async {
    List<String> selectedPhaseList = [];
    for (var i = 0; i < selectedPhaseMasterList.length; i++) {
      selectedPhaseList.add(selectedPhaseMasterList[i]["value"]);
    }

    JobCareer userInfo = JobCareer(
        careerId: jobCareer.careerId,
        content: contentController.text,
        careerPeriodFrom: jobCareer.careerPeriodFrom,
        careerPeriodTo: jobCareer.careerPeriodTo,
        role: roleController.text,
        phase: selectedPhaseList,
        usedTechnicalOSList: jobCareer.usedTechnicalOSList,
        usedTechnicalSkillList: jobCareer.usedTechnicalSkillList,
        usedTechnicalDBList: jobCareer.usedTechnicalDBList);
    person.jobCareerList!.add(userInfo);
    await FirebaseService.saveProjectForSearch(person.id, userInfo);

    person = await FirebaseService.saveAddingUpList(person);
    jobCareer = person.jobCareerList![jobIndex];
  }

  void parentFunction() {
    setState(() {});
  }
}
