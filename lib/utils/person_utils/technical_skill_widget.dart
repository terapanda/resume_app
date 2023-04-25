import 'package:flutter/material.dart';
import 'package:resume_app/model/person.dart';
import 'package:resume_app/utils/calc_years_of_skill.dart';
import 'package:resume_app/utils/hex_color.dart';
import 'package:resume_app/utils/replace_technical.dart';

import '../../model/job_career.dart';

// テクニカル
class TechnicalSkillWidget {
  ReplaceTechnical replaceTechnical = ReplaceTechnical();
  Widget get(Person personItem, String type) {
    if (type == 'os') {
      if (personItem.technicalOSList == null ||
          personItem.technicalOSList!.isEmpty) {
        return const Text(
          "",
          style: TextStyle(fontSize: 16),
        );
      }
      return Column(children: [
        _technicalTitle("OS歴", personItem, 1),
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
                            replaceTechnical.getSkillIcon(
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
                                        personItem
                                            .technicalOSList![index].osName,
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      Text(
                                        CalcMonth.calcMonth(personItem
                                                .technicalOSList![index].month)
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
      if (personItem.technicalSkillList == null ||
          personItem.technicalSkillList!.isEmpty) {
        return const Text(
          "",
          style: TextStyle(fontSize: 16),
        );
      }
      return Column(children: [
        _technicalTitle("プログラミング言語歴", personItem, 2),
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
                            replaceTechnical.getSkillIcon(
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
                                        personItem.technicalSkillList![index]
                                            .skillName,
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      Text(
                                        CalcMonth.calcMonth(personItem
                                                .technicalSkillList![index]
                                                .month)
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
      if (personItem.technicalDBList == null ||
          personItem.technicalDBList!.isEmpty) {
        return const Text(
          "",
          style: TextStyle(fontSize: 16),
        );
      }
      return Column(children: [
        _technicalTitle("DB歴", personItem, 3),
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
                            replaceTechnical.getSkillIcon(
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
                                        personItem
                                            .technicalDBList![index].dbName,
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      Text(
                                        CalcMonth.calcMonth(personItem
                                                .technicalDBList![index].month)
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
    } else if ((personItem.technicalOSList == null ||
            personItem.technicalOSList!.isEmpty) &&
        (personItem.technicalSkillList == null ||
            personItem.technicalSkillList!.isEmpty) &&
        (personItem.technicalDBList == null ||
            personItem.technicalDBList!.isEmpty)) {
      return const Padding(
          padding: EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
          child: Text(
            "言語経歴の登録がありません",
            style: TextStyle(fontSize: 16),
          ));
    } else {
      return const Text(
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

class TechnicalSkillWidgetForJobJobCareer {
  ReplaceTechnical replaceTechnical = ReplaceTechnical();
  Widget get(JobCareer jobCareer, String type) {
    if (type == 'os') {
      if (jobCareer.usedTechnicalOSList == null ||
          jobCareer.usedTechnicalOSList!.isEmpty) {
        return const Text(
          "",
          style: TextStyle(fontSize: 16),
        );
      }
      return Column(children: [
        _technicalTitle("OS歴", jobCareer, 1),
        SizedBox(
            height: jobCareer.usedTechnicalOSList!.length * (64 + 8 + 8),
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: jobCareer.usedTechnicalOSList!.length,
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
                                jobCareer.usedTechnicalOSList![index].osId,
                                30,
                                HexColor()),
                            Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        jobCareer
                                            .usedTechnicalOSList![index].osName,
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      Text(
                                        CalcMonth.calcMonth(jobCareer
                                                .usedTechnicalOSList![index]
                                                .month)
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
      if (jobCareer.usedTechnicalSkillList == null ||
          jobCareer.usedTechnicalSkillList!.isEmpty) {
        return const Text(
          "",
          style: TextStyle(fontSize: 16),
        );
      }
      return Column(children: [
        _technicalTitle("プログラミング言語歴", jobCareer, 2),
        SizedBox(
            height: jobCareer.usedTechnicalSkillList!.length * (64 + 8 + 8),
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: jobCareer.usedTechnicalSkillList!.length,
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
                                jobCareer
                                    .usedTechnicalSkillList![index].skillId,
                                30,
                                HexColor()),
                            Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        jobCareer.usedTechnicalSkillList![index]
                                            .skillName,
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      Text(
                                        CalcMonth.calcMonth(jobCareer
                                                .usedTechnicalSkillList![index]
                                                .month)
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
      if (jobCareer.usedTechnicalDBList == null ||
          jobCareer.usedTechnicalDBList!.isEmpty) {
        return const Text(
          "",
          style: TextStyle(fontSize: 16),
        );
      }
      return Column(children: [
        _technicalTitle("DB歴", jobCareer, 3),
        SizedBox(
            height: jobCareer.usedTechnicalDBList!.length * (64 + 8 + 8),
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: jobCareer.usedTechnicalDBList!.length,
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
                                jobCareer.usedTechnicalDBList![index].dbId,
                                30,
                                HexColor()),
                            Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        jobCareer
                                            .usedTechnicalDBList![index].dbName,
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      Text(
                                        CalcMonth.calcMonth(jobCareer
                                                .usedTechnicalDBList![index]
                                                .month)
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
    } else if ((jobCareer.usedTechnicalOSList == null ||
            jobCareer.usedTechnicalOSList!.isEmpty) &&
        (jobCareer.usedTechnicalSkillList == null ||
            jobCareer.usedTechnicalSkillList!.isEmpty) &&
        (jobCareer.usedTechnicalDBList == null ||
            jobCareer.usedTechnicalDBList!.isEmpty)) {
      return const Padding(
          padding: EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
          child: Text(
            "言語経歴の登録がありません",
            style: TextStyle(fontSize: 16),
          ));
    } else {
      return const Text(
        "",
        style: TextStyle(fontSize: 16),
      );
    }
  }

  Widget _technicalTitle(String title, JobCareer jobCareer, int type) {
    if (type == 1) {
      if (jobCareer.usedTechnicalSkillList == null &&
          jobCareer.usedTechnicalDBList == null) {
        return const Text(
          "",
        );
      }
    } else if (type == 2) {
      if (jobCareer.usedTechnicalOSList == null &&
          jobCareer.usedTechnicalDBList == null) {
        return const Text(
          "",
        );
      }
    } else if (type == 3) {
      if (jobCareer.usedTechnicalOSList == null &&
          jobCareer.usedTechnicalSkillList == null) {
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
