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
    final personData = ref.watch(personStreamProvider);

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
      appBar: AppBar(
        leading: CupertinoButton(
          padding: EdgeInsets.only(left: 0),
          // color: Colors.amber,
          color: Color(0xFAFAFAFA),
          child: const Icon(CupertinoIcons.left_chevron),
          onPressed: () => onLeadingPressed(context),
        ),
        title: Text('マイページ'),
        actions: [
          TextButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileEditScreen(),
              ),
            ),
            child: Text(
              '編集',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
          ),
        ],
      ),
      body: SizedBox.expand(
        child: SafeArea(
          bottom: false,
          child: PopUpItem(
            height: deviceHeight,
            outerPadding: EdgeInsets.all(0),
            innerPadding: EdgeInsets.all(16),
            color: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            elevation: 2,
            tag: 'tag1',
            child: Column(
              children: [
                Row(
                  children: [
                    ImageWidget().get(personData.value, 88),
                    Expanded(
                      child: SizedBox(
                        height: 88,
                        child: Column(
                          children: [
                            NameWidget().get(personData.value, 24),
                            ExperienceWidget().get(true, personData.value),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                HeadlineWidget().get('プロフィール'),
                const Padding(padding: EdgeInsets.only(top: 8)),
                Row(
                  children: [
                    AgeWidget().get(false, personData.value),
                    SexWidget().get(false, personData.value),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(left: 48.0),
                  child: const Divider(),
                ),
                StationWidget().get(false, personData.value),
                FavoriteSkillWidget().get(false, personData.value),
                const Divider(),
                const Padding(padding: EdgeInsets.only(top: 8)),
                HeadlineWidget().get('言語経歴'),
                TechnicalSkillWidget().get(personData.value, 'os'),
                TechnicalSkillWidget().get(personData.value, 'skill'),
                TechnicalSkillWidget().get(personData.value, 'db'),
                TechnicalSkillWidget().get(personData.value, ''),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onLeadingPressed(context) {
    print('Leading pressed.'); //任意の処理
    Navigator.of(context).pop();
  }
}
