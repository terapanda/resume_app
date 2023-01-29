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

import '../provider/user_state.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

class MypageScreen extends ConsumerWidget {
  const MypageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Person Persondata = ref.watch(personProvider);

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
            leading: CupertinoButton(
              padding: EdgeInsets.only(left: 0),
              // color: Colors.amber,
              color: Color(0xFAFAFAFA),
              child: const Icon(CupertinoIcons.left_chevron),
              onPressed: () => onLeadingPressed(context),
            ),
            transitionBetweenRoutes: false,
            middle: Text('マイページ'),
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
                    TechnicalSkillWidget().get(Persondata, 'os'),
                    TechnicalSkillWidget().get(Persondata, 'skill'),
                    TechnicalSkillWidget().get(Persondata, 'db'),
                    TechnicalSkillWidget().get(Persondata, ''),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ));
  }

  void onLeadingPressed(context) {
    print('Leading pressed.'); //任意の処理
    Navigator.of(context).pop();
  }
}
