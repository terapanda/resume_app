import 'package:flutter/cupertino.dart';

import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:resume_app/component/popup_card/popup_card.dart';
import 'package:resume_app/model/job_career.dart';
import 'package:resume_app/model/person.dart';
import 'package:resume_app/model/technical_os.dart';
import 'package:resume_app/model/technical_skill.dart';
import 'package:resume_app/services/pdf_creator.dart';
import 'package:resume_app/services/save_helper/save_helper.dart';
import 'package:resume_app/screens/profile_edit_screen.dart';
import 'package:resume_app/utils/person_utils/age_widget.dart';
import 'package:resume_app/utils/person_utils/experience_widget.dart';
import 'package:resume_app/utils/person_utils/favorite_skill_widget.dart';
import 'package:resume_app/utils/person_utils/headline_widget.dart';
import 'package:resume_app/utils/person_utils/image_widget.dart';
import 'package:resume_app/utils/person_utils/name_widget.dart';
import 'package:resume_app/utils/person_utils/sex_widget.dart';
import 'package:resume_app/utils/person_utils/station_widget.dart';
import 'package:resume_app/utils/person_utils/technical_skill_widget.dart';

Person Persondata = Person(
    id: 2,
    name: "谷内　伸輔神",
    ruby: "たにうち　しんすけ",
    initial: "S.T",
    sex: 3,
    age: 34,
    contractType: 1,
    description:
        "＜身についた知識・スキル＞\n・業務用基幹システム構築業務で身につけたプロジェクト全体をマネジメントするスキル\n・社内関係部署の要望を把握し、協力会社との調整・折衝を経験したことから得た課題を把握する力、解決策を提示し遂行する力\n・システム全般に関する包括的な知識・スキル",
    station: "JRおおさか東線　高井田中央",
    favoriteSkill: ['COBOL', 'Vue', 'Python'],
    image:
        "https://static.rtrp.jp/article/131658/images/131658a327d71f-736a-4fb7-8352-29be1f6da1e9_m.jpg",
    experience: 8,
    lastUpdateDate: new DateTime(2021, 11, 12, 17, 30),
    technicalSkillList: [
      TechnicalSkill(skillId: 'react', monthOfSkill: 25),
      TechnicalSkill(skillId: 'vue', monthOfSkill: 24),
      TechnicalSkill(skillId: 'java', monthOfSkill: 24),
      TechnicalSkill(skillId: 'php', monthOfSkill: 12),
      TechnicalSkill(skillId: 'flutter', monthOfSkill: 24),
      TechnicalSkill(skillId: 'vba', monthOfSkill: 36),
      TechnicalSkill(skillId: 'python', monthOfSkill: 36)
    ],
    jobCareerList: [
      JobCareer(
          careerId: 1,
          careerPeriodFrom: DateTime(2019, 11, 01),
          careerPeriodTo: DateTime(2019, 12, 31),
          content: "高速道路に表示する電光掲示の遠隔操作システム",
          phaseInCharge: "フロントエンド",
          role: 4,
          usedTechnicalSkillList: [
            const TechnicalSkill(skillId: 'vue', monthOfSkill: 2),
          ]),
      JobCareer(
          careerId: 2,
          careerPeriodFrom: DateTime(2020, 01, 01),
          careerPeriodTo: DateTime(2021, 08, 31),
          content: "空調機器設置遠隔操作システム",
          phaseInCharge: "フロントエンド\n要件定義～テスト",
          role: 4,
          usedTechnicalOSList: [
            const TechnicalOS(osId: 'mac', monthOfOS: 8),
          ],
          usedTechnicalSkillList: [
            const TechnicalSkill(skillId: 'react', monthOfSkill: 8),
            const TechnicalSkill(skillId: 'type_script', monthOfSkill: 7),
          ]),
      JobCareer(
          careerId: 3,
          careerPeriodFrom: DateTime(2020, 01, 01),
          careerPeriodTo: DateTime(2021, 08, 31),
          content: "空調機器設置遠隔操作システム",
          phaseInCharge: "フロントエンド\n要件定義～テスト",
          role: 4,
          usedTechnicalOSList: [
            const TechnicalOS(osId: 'mac', monthOfOS: 8),
          ],
          usedTechnicalSkillList: [
            const TechnicalSkill(skillId: 'react', monthOfSkill: 8),
            const TechnicalSkill(skillId: 'type_script', monthOfSkill: 7),
          ]),
      JobCareer(
          careerId: 4,
          careerPeriodFrom: DateTime(2020, 01, 01),
          careerPeriodTo: DateTime(2021, 08, 31),
          content: "空調機器設置遠隔操作システム",
          phaseInCharge: "フロントエンド\n要件定義～テスト",
          role: 4,
          usedTechnicalOSList: [
            const TechnicalOS(osId: 'mac', monthOfOS: 8),
          ],
          usedTechnicalSkillList: [
            const TechnicalSkill(skillId: 'react', monthOfSkill: 8),
            const TechnicalSkill(skillId: 'type_script', monthOfSkill: 7),
          ]),
      JobCareer(
          careerId: 5,
          careerPeriodFrom: DateTime(2020, 01, 01),
          careerPeriodTo: DateTime(2021, 08, 31),
          content: "空調機器設置遠隔操作システム",
          phaseInCharge: "フロントエンド\n要件定義～テスト",
          role: 4,
          usedTechnicalOSList: [
            const TechnicalOS(osId: 'mac', monthOfOS: 8),
          ],
          usedTechnicalSkillList: [
            const TechnicalSkill(skillId: 'react', monthOfSkill: 8),
            const TechnicalSkill(skillId: 'type_script', monthOfSkill: 7),
          ]),
      JobCareer(
          careerId: 6,
          careerPeriodFrom: DateTime(2020, 01, 01),
          careerPeriodTo: DateTime(2021, 08, 31),
          content: "空調機器設置遠隔操作システム",
          phaseInCharge: "フロントエンド\n要件定義～テスト",
          role: 4,
          usedTechnicalOSList: [
            const TechnicalOS(osId: 'mac', monthOfOS: 8),
          ],
          usedTechnicalSkillList: [
            const TechnicalSkill(skillId: 'react', monthOfSkill: 8),
            const TechnicalSkill(skillId: 'type_script', monthOfSkill: 7),
          ]),
      JobCareer(
          careerId: 7,
          careerPeriodFrom: DateTime(2020, 01, 01),
          careerPeriodTo: DateTime(2021, 08, 31),
          content: "空調機器設置遠隔操作システム",
          phaseInCharge: "フロントエンド\n要件定義～テスト",
          role: 4,
          usedTechnicalOSList: [
            const TechnicalOS(osId: 'mac', monthOfOS: 8),
          ],
          usedTechnicalSkillList: [
            const TechnicalSkill(skillId: 'react', monthOfSkill: 8),
            const TechnicalSkill(skillId: 'type_script', monthOfSkill: 7),
          ]),
    ]);

class MypageScreen extends StatefulWidget {
  const MypageScreen({super.key});

  @override
  State<MypageScreen> createState() => _MypageScreenState();
}

class _MypageScreenState extends State<MypageScreen> {
  @override
  Widget build(BuildContext context) {
    return _popUpItemBody(context);
  }

  Widget _popUpItemBody(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    void _save(Persondata) async {
      final pdf = await PdfCreator.create(Persondata, false, true);
      final bytes = await pdf.save();
      final fileName = '技術経歴書Y.W.pdf';
      await SaveHelper.save(
        bytes: bytes,
        fileName: fileName,
        platform: Theme.of(context).platform,
      );
    }

    return Scaffold(
        body: CupertinoScaffold(
      body: Builder(
        builder: (context) => CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            transitionBetweenRoutes: false,
            middle: Text('エンジニア'),
            trailing: TextButton(
              onPressed: () => CupertinoScaffold.showCupertinoModalBottomSheet(
                context: context,
                backgroundColor: const Color(0xFAFAFAFA),
                builder: (context) => Stack(
                  children: <Widget>[ProfileEditScreen()],
                ),
              ),
              child: Text('編集',
                  style: TextStyle(color: Colors.black, fontSize: 18)),
            ),
          ),
          child: SizedBox.expand(
            child: SafeArea(
              bottom: false,
              child: PopUpItem(
                height: deviceHeight,
                outerPadding: EdgeInsets.all(0),
                innerPadding: EdgeInsets.all(16),
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
                elevation: 2,
                tag: 'tag1',
                child: Column(
                  children: [
                    Row(children: [
                      ImageWidget().get(Persondata, 88),
                      Expanded(
                        child: SizedBox(
                          height: 88,
                          child: Column(children: [
                            NameWidget().get(Persondata, 24),
                            ExperienceWidget().get(true, Persondata),
                          ]),
                        ),
                      )
                    ]),
                    HeadlineWidget().get('プロフィール'),
                    const Padding(padding: EdgeInsets.only(top: 8)),
                    Row(children: [
                      AgeWidget().get(false, Persondata),
                      SexWidget().get(false, Persondata),
                    ]),
                    Container(
                        margin: const EdgeInsets.only(left: 48.0),
                        child: const Divider()),
                    StationWidget().get(false, Persondata),
                    FavoriteSkillWidget().get(false, Persondata),
                    const Divider(),
                    const Padding(padding: EdgeInsets.only(top: 8)),
                    HeadlineWidget().get('言語経歴'),
                    TechnicalSkillWidget().get(Persondata),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
