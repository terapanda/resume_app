import 'package:flutter/material.dart';
import 'package:resume_app/model/person.dart';
import 'package:resume_app/utils/calc_years_of_skill.dart';
import 'package:resume_app/utils/hex_color.dart';
import 'package:resume_app/utils/replace_technical.dart';

// テクニカルスキル
class TechnicalSkillWidget {
  ReplaceTechnical replaceTechnical = ReplaceTechnical();
  Widget get(Person personItem) {
    if (personItem.technicalSkillList == null) {
      return const Padding(
          padding: EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
          child: Text(
            "言語経歴の登録がありません",
            style: TextStyle(fontSize: 16),
          ));
    }

    return SizedBox(
        height: personItem.technicalSkillList!.length * (64 + 8 + 8),
        child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: personItem.technicalSkillList!.length,
            itemBuilder: (context, index) {
              return Card(
                child: SizedBox(
                  height: 64,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 8, bottom: 8, left: 16, right: 16),
                    child: Row(
                      // Property
                      children: [
                        replaceTechnical.getSkillIcon(
                            personItem.technicalSkillList![index].skillId,
                            30,
                            HexColor()),
                        Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    personItem
                                        .technicalSkillList![index].skillName,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    CalcMonth.calcMonth(personItem
                                            .technicalSkillList![index].month)
                                        .toString(),
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ])),
                      ],
                    ),
                  ),
                ),
              );
            }));
  }
}
