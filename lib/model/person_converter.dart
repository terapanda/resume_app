import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:resume_app/model/job_career.dart';
import 'package:resume_app/model/person.dart';
import 'package:resume_app/model/technical_db.dart';
import 'package:resume_app/model/technical_os.dart';
import 'package:resume_app/model/technical_skill.dart';
import 'package:resume_app/services/firebaseService.dart';
import 'package:resume_app/utils/age_calculator.dart';
import 'package:resume_app/utils/replace_profile_data.dart';
import 'package:resume_app/utils/replace_technical.dart';

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
      department: doc.data()['department'] as String,
      name: "${doc.data()['nameLast']}　${doc.data()['nameFirst']}",
      ruby: "${doc.data()['rubyLast']}　${doc.data()['rubyFirst']}",
      initial: doc.data()['initial'] as String,
      sex: doc.data()['sex'] as String,
      birthDay: (doc.data()['birthDay']).toDate(),
      age: doc.data()['age'] as int,
      station: doc.data()['station'] as String,
      image: await FirebaseStorage.instance.ref(imgURL).getDownloadURL(),
      updateDate: (doc.data()['updateDate']).toDate(),
      // jobCareerList: await fetchJobCareerList(doc.id),
      technicalOSList: null,
      technicalSkillList: null,
      technicalDBList: null,
      authority: doc.data()['authority'] as int,
      isProgrammer: doc.data()['isProgrammer'],
    );

    if (doc.data()['favoriteSkill'] != null) {
      person.favoriteSkill = (doc.data()['favoriteSkill'] as List)
          .map((e) => e as String)
          .toList();
    }

    if (doc.data()['description'] != null) {
      person.description = doc.data()['description'] as String;
    }

    if (doc.data()['contractType'] != null) {
      person.contractType = doc.data()['contractType'] as String;
    }

    if (doc.data()['branchOffice'] != null) {
      person.branchOffice = doc.data()['branchOffice'];
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
    List<TechnicalSkill> totalTechnicalSkillList = [];
    await FirebaseFirestore.instance
        .collection('/search/$userId/totalTechnicalSkill')
        .get()
        .then((event) async {
      for (var doc in event.docs) {
        TechnicalSkill technicalSkill = TechnicalSkill(
            skillId: doc.id,
            skillName: ReplaceTechnical.replaceTechnicalSkill(doc.id),
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
    List<TechnicalDB> totalTechnicalDBList = [];
    await FirebaseFirestore.instance
        .collection('/search/$userId/totalTechnicalDB')
        .get()
        .then((event) async {
      for (var doc in event.docs) {
        TechnicalDB technicalDB = TechnicalDB(
            dbId: doc.id,
            dbName: ReplaceTechnical.replaceTechnicalSkill(doc.id),
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
    List<TechnicalOS> totalTechnicalOSList = [];
    await FirebaseFirestore.instance
        .collection('/search/$userId/totalTechnicalOS')
        .get()
        .then((event) async {
      for (var doc in event.docs) {
        TechnicalOS technicalOS = TechnicalOS(
            osId: doc.id,
            osName: ReplaceTechnical.replaceTechnicalSkill(doc.id),
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

      for (var doc in event.docs) {
        JobCareer jobCareer = JobCareer(
          careerId: int.parse(doc.id),
          careerPeriodFrom:
              (doc.data()['careerPeriodFrom']).toDate() as DateTime,
          careerPeriodTo: (doc.data()['careerPeriodTo']).toDate() as DateTime,
          content: doc.data()['content'] as String,
          phase: [1, 2, 3], // doc.data()['phase'] as String,
          role: doc.data()['role'] as int,
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
    List<TechnicalSkill> technicalSkillList = [];
    await FirebaseFirestore.instance
        .collection('/users/$userId/jobCareer/$jobCareerId/technicalSkill')
        .get()
        .then((event) async {
      technicalSkillList = event.docs
          .map((doc) => TechnicalSkill(
                skillId: doc.id,
                skillName: ReplaceTechnical.replaceTechnicalSkill(doc.id),
                month: doc.data()['month'] as int,
              ))
          .toList();
    });
    return technicalSkillList;
  }

  /// jobCareerに紐づくOS情報取得
  static Future<List<TechnicalOS>> fetchTechnicalOSList(
      String userId, int jobCareerId) async {
    List<TechnicalOS> technicalOSList = [];
    await FirebaseFirestore.instance
        .collection('/users/$userId/jobCareer/$jobCareerId/technicalOS')
        .get()
        .then((event) {
      technicalOSList = event.docs
          .map((doc) => TechnicalOS(
                osId: doc.id,
                osName: ReplaceTechnical.replaceTechnicalSkill(doc.id),
                month: doc.data()['month'] as int,
              ))
          .toList();
    });
    return technicalOSList;
  }

  /// jobCareerに紐づくDB情報取得
  static Future<List<TechnicalDB>> fetchTechnicalDBList(
      String userId, int jobCareerId) async {
    List<TechnicalDB> technicalDBList = [];
    await FirebaseFirestore.instance
        .collection('/users/$userId/jobCareer/$jobCareerId/technicalDB')
        .get()
        .then((event) {
      technicalDBList = event.docs
          .map((doc) => TechnicalDB(
                dbId: doc.id,
                dbName: ReplaceTechnical.replaceTechnicalSkill(doc.id),
                month: doc.data()['month'] as int,
              ))
          .toList();
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
      for (var jobCareerListItem in person.jobCareerList!) {
        // jobCareerのOSList
        for (var usedTechnicalOSListItem
            in jobCareerListItem.usedTechnicalOSList!) {
          // OS経歴集計Listに追加
          tempTechnicalOSList.add(usedTechnicalOSListItem);
        }
      }
    }

    // 重複項目を合算する
    List<TechnicalOS> addingUpList = [];
    for (var technicalOSListItem in tempTechnicalOSList) {
      if (addingUpList.isEmpty) {
        addingUpList.add(technicalOSListItem);
      } else {
        var flg = true;
        for (var tempListItem in addingUpList) {
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
      for (var jobCareerListItem in person.jobCareerList!) {
        // jobCareerのDBList
        for (var usedTechnicalDBListItem
            in jobCareerListItem.usedTechnicalDBList!) {
          // DB経歴集計Listに追加
          tempTechnicalDBList.add(usedTechnicalDBListItem);
        }
      }
    }

    // 重複項目を合算する
    List<TechnicalDB> addingUpList = [];
    for (var technicalDBListItem in tempTechnicalDBList) {
      if (addingUpList.isEmpty) {
        addingUpList.add(technicalDBListItem);
      } else {
        var flg = true;
        for (var tempListItem in addingUpList) {
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
