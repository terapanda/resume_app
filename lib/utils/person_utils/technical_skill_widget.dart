import 'package:flutter/material.dart';
import 'package:resume_app/model/person.dart';
import 'package:resume_app/utils/calc_years_of_skill.dart';
import 'package:resume_app/utils/hex_color.dart';
import 'package:resume_app/utils/person_utils/headline_widget.dart';
import 'package:resume_app/utils/replace_technical.dart';

// テクニカル
class TechnicalSkillWidget {
  Widget get(Person personItem, String type) {
    if (type == 'os') {
      if (personItem.technicalOSList == null) {
        return Text(
          "",
          style: TextStyle(fontSize: 16),
        );
      }
      return Column(children: [
        _technicalTitle("OS", personItem, 1),
        SizedBox(
            height: personItem.technicalOSList!.length * (64 + 8 + 8),
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: personItem.technicalOSList!.length,
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
                            ReplaceTechnical.getSkillIcon(
                                personItem.technicalOSList![index].osId,
                                30,
                                HexColor()),
                            Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        ReplaceTechnical.replaceTechnicalSkill(
                                            personItem
                                                .technicalOSList![index].osId),
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      Text(
                                        CalcMonthOfSkill.calcMonthOfSkill(
                                                personItem
                                                    .technicalOSList![index]
                                                    .monthOfOS)
                                            .toString(),
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ])),
                          ],
                        ),
                      ),
                    ),
                  );
                }))
      ]);
    } else if (type == 'skill') {
      if (personItem.technicalSkillList == null) {
        return Text(
          "",
          style: TextStyle(fontSize: 16),
        );
      }
      return Column(children: [
        _technicalTitle("言語", personItem, 2),
        SizedBox(
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
                            ReplaceTechnical.getSkillIcon(
                                personItem.technicalSkillList![index].skillId,
                                30,
                                HexColor()),
                            Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        ReplaceTechnical.replaceTechnicalSkill(
                                            personItem
                                                .technicalSkillList![index]
                                                .skillId),
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      Text(
                                        CalcMonthOfSkill.calcMonthOfSkill(
                                                personItem
                                                    .technicalSkillList![index]
                                                    .monthOfSkill)
                                            .toString(),
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ])),
                          ],
                        ),
                      ),
                    ),
                  );
                }))
      ]);
    } else if (type == 'db') {
      if (personItem.technicalDBList == null) {
        return Text(
          "",
          style: TextStyle(fontSize: 16),
        );
      }
      return Column(children: [
        _technicalTitle("DB", personItem, 3),
        SizedBox(
            height: personItem.technicalDBList!.length * (64 + 8 + 8),
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: personItem.technicalDBList!.length,
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
                            ReplaceTechnical.getSkillIcon(
                                personItem.technicalDBList![index].dbId,
                                30,
                                HexColor()),
                            Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        ReplaceTechnical.replaceTechnicalSkill(
                                            personItem
                                                .technicalDBList![index].dbId),
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      Text(
                                        CalcMonthOfSkill.calcMonthOfSkill(
                                                personItem
                                                    .technicalDBList![index]
                                                    .monthOfDB)
                                            .toString(),
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ])),
                          ],
                        ),
                      ),
                    ),
                  );
                }))
      ]);
    } else if (personItem.technicalOSList == null &&
        personItem.technicalSkillList == null &&
        personItem.technicalDBList == null) {
      return const Padding(
          padding: EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
          child: Text(
            "言語経歴の登録がありません",
            style: TextStyle(fontSize: 16),
          ));
    } else {
      return Text(
        "",
        style: TextStyle(fontSize: 16),
      );
    }
  }

  Widget _technicalTitle(String title, Person personItem, int type) {
    if (type == 1) {
      if (personItem.technicalSkillList == null &&
          personItem.technicalDBList == null) {
        return const Text(
          "",
        );
      }
    } else if (type == 2) {
      if (personItem.technicalOSList == null &&
          personItem.technicalDBList == null) {
        return const Text(
          "",
        );
      }
    } else if (type == 3) {
      if (personItem.technicalOSList == null &&
          personItem.technicalSkillList == null) {
        return const Text(
          "",
        );
      }
    }

    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: HexColor()),
        ),
      ),
    );
  }
}
