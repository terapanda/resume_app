import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:resume_app/model/job_career.dart';
import 'package:resume_app/model/person.dart';
import 'package:resume_app/model/technical_db.dart';
import 'package:resume_app/model/technical_os.dart';
import 'package:resume_app/model/technical_skill.dart';
import 'package:resume_app/utils/replace_technical.dart';

import '../utils/deep_copy.dart';
import '../utils/use_shared_preferences.dart';

class PersonConverter {
  static late DateTime experienceDateTime = DateTime.now();

  static Future<Person> convert(
    dynamic doc,
  ) async {
    // 画像パス取得
    String imgURL = "users/noimage/noimage.png";
    if (doc.data()['image'] != "") {
      imgURL = doc.data()['image'];
    }
    // 勤続年数取得
    await fetchExperienceDateTime(doc.id);

    // Person情報取得
    Person person = Person(
      id: doc.id,
      age: doc.data()['age'] as int,
      authority: doc.data()['authority'] as int,
      birthDay: (doc.data()['birthDay']).toDate(),
      department: doc.data()['department'] as String,
      image: await FirebaseStorage.instance.ref(imgURL).getDownloadURL(),
      isProgrammer: doc.data()['isProgrammer'],
      initial: doc.data()['initial'] as String,
      name: "${doc.data()['nameLast']}　${doc.data()['nameFirst']}",
      ruby: "${doc.data()['rubyLast']}　${doc.data()['rubyFirst']}",
      sex: doc.data()['sex'] as String,
      station: doc.data()['station'] as String,
      updateDate: (doc.data()['updateDate']).toDate(),
    );

    if (doc.data()['branchOffice'] != null) {
      person.branchOffice = doc.data()['branchOffice'];
    }

    if (doc.data()['contractType'] != null) {
      person.contractType = doc.data()['contractType'] as String;
    }

    if (doc.data()['description'] != null) {
      person.description = doc.data()['description'] as String;
    }

    if (doc.data()['experience'] != null) {
      person.experience = doc.data()['experience'];
    }

    if (doc.data()['favoriteSkill'] != null) {
      person.favoriteSkill = (doc.data()['favoriteSkill'] as List)
          .map((e) => e as String)
          .toList();
    }

    if (doc.data()['experience'] != null) {
      person.experience = doc.data()['experience'] as int; // 勤続年数追加
    }

    person.technicalSkillList =
        await fetchTotalTechnicalSkillList(doc.id); // 言語経歴追加
    person.technicalDBList = await fetchTotalTechnicalDBList(doc.id); // DB経歴追加
    person.technicalOSList = await fetchTotalTechnicalOSList(doc.id); // OS経歴追加
    return person;
  }

  /// totalTechnicalSkillList取得
  static Future<List<TechnicalSkill>> fetchTotalTechnicalSkillList(
      String userId) async {
    ReplaceTechnical replaceTechnical = ReplaceTechnical();
    final masterData = await UseSharedPreferences.getUserDefaults('master');
    final encodeData = UseSharedPreferences.decodeMasterMap(masterData);
    List<TechnicalSkill> totalTechnicalSkillList = [];
    await FirebaseFirestore.instance
        .collection('/search/$userId/totalTechnicalSkill')
        .get()
        .then((event) async {
      for (var doc in event.docs) {
        TechnicalSkill technicalSkill = TechnicalSkill(
            skillId: doc.id,
            skillName: await replaceTechnical.replaceTechnicalSkill(
                doc.id, encodeData),
            month: doc.data()['month'] as int);
        totalTechnicalSkillList.add(technicalSkill);
      }
    });
    // ソート
    totalTechnicalSkillList.sort((a, b) => b.month.compareTo(a.month));

    return totalTechnicalSkillList;
  }

  /// totalTechnicalDBList取得
  static Future<List<TechnicalDB>> fetchTotalTechnicalDBList(
      String userId) async {
    ReplaceTechnical replaceTechnical = ReplaceTechnical();
    final masterData = await UseSharedPreferences.getUserDefaults('master');
    final encodeData = UseSharedPreferences.decodeMasterMap(masterData);
    List<TechnicalDB> totalTechnicalDBList = [];
    await FirebaseFirestore.instance
        .collection('/search/$userId/totalTechnicalDB')
        .get()
        .then((event) async {
      for (var doc in event.docs) {
        TechnicalDB technicalDB = TechnicalDB(
            dbId: doc.id,
            dbName: await replaceTechnical.replaceTechnicalSkill(
                doc.id, encodeData),
            month: doc.data()['month'] as int);
        totalTechnicalDBList.add(technicalDB);
      }
    });
    // ソート
    totalTechnicalDBList.sort((a, b) => b.month.compareTo(a.month));

    return totalTechnicalDBList;
  }

  /// totalTechnicalDBList取得
  static Future<List<TechnicalOS>> fetchTotalTechnicalOSList(
      String userId) async {
    ReplaceTechnical replaceTechnical = ReplaceTechnical();
    final masterData = await UseSharedPreferences.getUserDefaults('master');
    final encodeData = UseSharedPreferences.decodeMasterMap(masterData);
    List<TechnicalOS> totalTechnicalOSList = [];
    await FirebaseFirestore.instance
        .collection('/search/$userId/totalTechnicalOS')
        .get()
        .then((event) async {
      for (var doc in event.docs) {
        TechnicalOS technicalOS = TechnicalOS(
            osId: doc.id,
            osName: await replaceTechnical.replaceTechnicalSkill(
                doc.id, encodeData),
            month: doc.data()['month'] as int);
        totalTechnicalOSList.add(technicalOS);
      }
    });
    // ソート
    totalTechnicalOSList.sort((a, b) => b.month.compareTo(a.month));

    return totalTechnicalOSList;
  }

  /// 勤続年数取得
  static Future<void> fetchExperienceDateTime(String userId) async {
    await FirebaseFirestore.instance
        .collection('/users/$userId/jobCareer')
        .get()
        .then((event) async {
      // 勤続年数計算のための値を取得（最初の案件の開始日）
      if (event.docs.isNotEmpty) {
        experienceDateTime =
            (event.docs[0].data()['careerPeriodFrom']).toDate() as DateTime;
      } else {
        experienceDateTime = DateTime.now();
      }
    });
  }

  /// jobCareerList取得
  static Future<List<JobCareer>> fetchJobCareerList(String userId) async {
    List<JobCareer> jobCareerList = [];
    await FirebaseFirestore.instance
        .collection('/search/$userId/jobCareer')
        .get()
        .then((event) async {
      for (var doc in event.docs) {
        JobCareer jobCareer = JobCareer(
          careerId: int.parse(doc.id),
          careerPeriodFrom:
              (doc.data()['careerPeriodFrom']).toDate() as DateTime,
          careerPeriodTo: (doc.data()['careerPeriodTo']).toDate() as DateTime,
          content: doc.data()['content'] as String,
          phase: (doc.data()['phase'] as List).map((e) => e as String).toList(),
          role: doc.data()['role'],
          usedTechnicalDBList:
              await fetchTechnicalDBList(userId, int.parse(doc.id)),
          usedTechnicalOSList:
              await fetchTechnicalOSList(userId, int.parse(doc.id)),
          usedTechnicalSkillList:
              await fetchTechnicalSkillList(userId, int.parse(doc.id)),
        );
        jobCareerList.add(jobCareer);
      }
    });
    return jobCareerList;
  }

  /// jobCareerに紐づくスキル情報取得
  static Future<List<TechnicalSkill>> fetchTechnicalSkillList(
      String userId, int jobCareerId) async {
    ReplaceTechnical replaceTechnical = ReplaceTechnical();
    final masterData = await UseSharedPreferences.getUserDefaults('master');
    final encodeData = UseSharedPreferences.decodeMasterMap(masterData);
    List<TechnicalSkill> technicalSkillList = [];
    await FirebaseFirestore.instance
        .collection('/search/$userId/jobCareer/$jobCareerId/technicalSkill')
        .get()
        .then((event) async {
      for (var i = 0; i < event.docs.length; i++) {
        technicalSkillList.add(TechnicalSkill(
          skillId: event.docs[i].id,
          skillName: await replaceTechnical.replaceTechnicalSkill(
              event.docs[i].id, encodeData),
          month: event.docs[i].data()['month'] as int,
        ));
      }
    });
    return technicalSkillList;
  }

  /// jobCareerに紐づくOS情報取得
  static Future<List<TechnicalOS>> fetchTechnicalOSList(
      String userId, int jobCareerId) async {
    ReplaceTechnical replaceTechnical = ReplaceTechnical();
    final masterData = await UseSharedPreferences.getUserDefaults('master');
    final encodeData = UseSharedPreferences.decodeMasterMap(masterData);
    List<TechnicalOS> technicalOSList = [];
    await FirebaseFirestore.instance
        .collection('/search/$userId/jobCareer/$jobCareerId/technicalOS')
        .get()
        .then((event) async {
      for (var i = 0; i < event.docs.length; i++) {
        technicalOSList.add(TechnicalOS(
          osId: event.docs[i].id,
          osName: await replaceTechnical.replaceTechnicalSkill(
              event.docs[i].id, encodeData),
          month: event.docs[i].data()['month'] as int,
        ));
      }
    });
    return technicalOSList;
  }

  /// jobCareerに紐づくDB情報取得
  static Future<List<TechnicalDB>> fetchTechnicalDBList(
      String userId, int jobCareerId) async {
    ReplaceTechnical replaceTechnical = ReplaceTechnical();
    final masterData = await UseSharedPreferences.getUserDefaults('master');
    final encodeData = UseSharedPreferences.decodeMasterMap(masterData);
    List<TechnicalDB> technicalDBList = [];
    await FirebaseFirestore.instance
        .collection('/search/$userId/jobCareer/$jobCareerId/technicalDB')
        .get()
        .then((event) async {
      for (var i = 0; i < event.docs.length; i++) {
        technicalDBList.add(TechnicalDB(
          dbId: event.docs[i].id,
          dbName: await replaceTechnical.replaceTechnicalSkill(
              event.docs[i].id, encodeData),
          month: event.docs[i].data()['month'] as int,
        ));
      }
    });

    return technicalDBList;
  }

  /// jobCareerごとの言語を合算した言語経歴リストを作成
  static List<TechnicalSkill> getAddingUpTechnicalSkillList(Person person) {
    // jobCareerごとの言語を一旦合算なしでListに詰め込む
    List<TechnicalSkill> tempTechnicalSkillList = [];
    if (person.jobCareerList != null) {
      // jobCareerList
      for (var jobCareerListItem in person.jobCareerList!) {
        // jobCareerの言語List
        for (var usedTechnicalSkillListItem
            in jobCareerListItem.usedTechnicalSkillList!) {
          // 言語経歴集計Listに追加
          tempTechnicalSkillList.add(usedTechnicalSkillListItem);
        }
      }
    }

    // 重複項目を合算する
    List<TechnicalSkill> addingUpList = [];
    for (var technicalSkillListItem in tempTechnicalSkillList) {
      if (addingUpList.isEmpty) {
        addingUpList.add(technicalSkillListItem);
      } else {
        var flg = true;
        for (var tempListItem in addingUpList) {
          if (tempListItem.skillId == technicalSkillListItem.skillId) {
            tempListItem.month =
                tempListItem.month + technicalSkillListItem.month;
            flg = false;
            break;
          }
        }
        if (flg) {
          addingUpList.add(technicalSkillListItem);
        }
      }
    }
    return addingUpList;
  }

  /// jobCareerごとのOSを合算した言語経歴リストを作成
  static List<TechnicalOS> getAddingUpTechnicalOSList(Person person) {
    // jobCareerごとのOSを一旦合算なしでListに詰め込む
    List<TechnicalOS> tempTechnicalOSList = [];
    if (person.jobCareerList != null) {
      // jobCareerList
      for (JobCareer jobCareerListItem in person.jobCareerList!) {
        // jobCareerのOSList
        for (TechnicalOS usedTechnicalOSListItem
            in jobCareerListItem.usedTechnicalOSList!) {
          // OS経歴集計Listに追加
          tempTechnicalOSList.add(usedTechnicalOSListItem);
        }
      }
    }

    // 重複項目を合算する
    List<TechnicalOS> addingUpList = [];
    for (TechnicalOS technicalOSListItem in tempTechnicalOSList) {
      if (addingUpList.isEmpty) {
        addingUpList.add(technicalOSListItem);
      } else {
        var flg = true;
        for (TechnicalOS tempListItem in addingUpList) {
          if (tempListItem.osId == technicalOSListItem.osId) {
            tempListItem.month = tempListItem.month + technicalOSListItem.month;
            flg = false;
            break;
          }
        }
        if (flg) {
          addingUpList.add(technicalOSListItem);
        }
      }
    }
    return addingUpList;
  }

  /// jobCareerごとのDBを合算した言語経歴リストを作成
  static List<TechnicalDB> getAddingUpTechnicalDBList(Person person) {
    // jobCareerごとのDBを一旦合算なしでListに詰め込む
    List<TechnicalDB> tempTechnicalDBList = [];
    if (person.jobCareerList != null) {
      // jobCareerList
      for (JobCareer jobCareerListItem in person.jobCareerList!) {
        // jobCareerのDBList
        for (TechnicalDB usedTechnicalDBListItem
            in jobCareerListItem.usedTechnicalDBList!) {
          // DB経歴集計Listに追加
          tempTechnicalDBList.add(usedTechnicalDBListItem);
        }
      }
    }

    // 重複項目を合算する
    List<TechnicalDB> addingUpList = [];
    for (TechnicalDB technicalDBListItem in tempTechnicalDBList) {
      if (addingUpList.isEmpty) {
        addingUpList.add(technicalDBListItem);
      } else {
        var flg = true;
        for (TechnicalDB tempListItem in addingUpList) {
          if (tempListItem.dbId == technicalDBListItem.dbId) {
            tempListItem.month = tempListItem.month + technicalDBListItem.month;
            flg = false;
            break;
          }
        }
        if (flg) {
          addingUpList.add(technicalDBListItem);
        }
      }
    }
    return addingUpList;
  }
}
