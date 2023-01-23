import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:resume_app/utils/replace_profile_data.dart';
import 'package:resume_app/utils/replace_technical.dart';
import 'package:resume_app/model/person.dart';
import 'package:resume_app/model/job_career.dart';
import 'package:resume_app/model/technical_db.dart';
import 'package:resume_app/model/technical_os.dart';
import 'package:resume_app/model/technical_skill.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class SearchBarController extends ChangeNotifier {
  final globalKey = GlobalKey<ScaffoldState>();

  /// state
  bool isLoading = true;
  bool isSearching = false;
  String _searchedText = '';

  var allItemList = <Person>[];
  var searchedItemList = <Person>[];

  String get searchedText => _searchedText;

  final scrollController = ScrollController();

  void init(String searchValue, String selectedSortItem) async {
    // データとってきたときにローディング何秒間出すか？
    await Future.delayed(const Duration(seconds: 1)).then((_) {
      fetch(searchValue, selectedSortItem);
    });
  }

  Future<void> fetch(String searchValue, String selectedSortItem) async {
    // fetch data
    List<Person> personList = [];
    // exampleList = await hogehogeRepo.fetch();
    await firestore.collection('users').get().then((event) async {
      for (var doc in event.docs) {
        // 画像パス取得
        String imgURL = "users/noimage/noimage.png";
        if (doc.data()['image'] != "") {
          imgURL = doc.data()['image'];
        }

        // Person情報取得
        Person person = Person(
            id: doc.id,
            name: "${doc.data()['nameLast']}　${doc.data()['nameFirst']}",
            ruby: "${doc.data()['rubyLast']}　${doc.data()['rubyFirst']}",
            favoriteSkill: (doc.data()['favoriteSkill'] as List)
                .map((e) => e as String)
                .toList(),
            initial: doc.data()['initial'] as String,
            sex: doc.data()['sex'] as int,
            birthDay: (doc.data()['birthDay']).toDate(),
            contractType: doc.data()['contractType'] as int,
            description: doc.data()['description'] as String,
            station: doc.data()['station'] as String,
            image: await FirebaseStorage.instance.ref(imgURL).getDownloadURL(),
            experience: 3, // doc.data()['experience'] as int,
            updateDate: (doc.data()['updateDate']).toDate() as DateTime,
            jobCareerList: await fetchJobCareerList(doc.id),
            technicalOSList: null,
            technicalSkillList: null,
            technicalDBList: null);

        person.technicalSkillList =
            getAddingUpTechnicalSkillList(person); // 言語経歴追加
        person.technicalOSList = getAddingUpTechnicalOSList(person); // OS経歴追加
        person.technicalDBList = getAddingUpTechnicalDBList(person); // DB経歴追加

        personList.add(person);
      }
      notifyListeners();
    });

    allItemList = sortList(selectedSortItem, personList);

    isLoading = false;
    if (searchValue != null) {
      searchOperation(searchValue, selectedSortItem);
    } else {
      notifyListeners();
    }
  }

  /// jobCareerList取得
  Future<List<JobCareer>> fetchJobCareerList(String userId) async {
    List<JobCareer> jobCareerList = [];
    await firestore
        .collection('/users/$userId/jobCareer')
        .get()
        .then((event) async {
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
      notifyListeners();
    });
    return jobCareerList;
  }

  /// jobCareerに紐づくスキル情報取得
  Future<List<TechnicalSkill>> fetchTechnicalSkillList(
      String userId, int jobCareerId) async {
    List<TechnicalSkill> technicalSkillList = [];
    await firestore
        .collection('/users/$userId/jobCareer/$jobCareerId/technicalSkill')
        .get()
        .then((event) async {
      technicalSkillList = event.docs
          .map((doc) => TechnicalSkill(
                skillId: doc.id,
                month: doc.data()['month'] as int,
              ))
          .toList();
      notifyListeners();
    });
    return technicalSkillList;
  }

  /// jobCareerに紐づくOS情報取得
  Future<List<TechnicalOS>> fetchTechnicalOSList(
      String userId, int jobCareerId) async {
    List<TechnicalOS> technicalOSList = [];
    await firestore
        .collection('/users/$userId/jobCareer/$jobCareerId/technicalOS')
        .get()
        .then((event) {
      technicalOSList = event.docs
          .map((doc) => TechnicalOS(
                osId: doc.id,
                month: doc.data()['month'] as int,
              ))
          .toList();
      notifyListeners();
    });
    return technicalOSList;
  }

  /// jobCareerに紐づくDB情報取得
  Future<List<TechnicalDB>> fetchTechnicalDBList(
      String userId, int jobCareerId) async {
    List<TechnicalDB> technicalDBList = [];
    await firestore
        .collection('/users/$userId/jobCareer/$jobCareerId/technicalDB')
        .get()
        .then((event) {
      technicalDBList = event.docs
          .map((doc) => TechnicalDB(
                dbId: doc.id,
                month: doc.data()['month'] as int,
              ))
          .toList();
      notifyListeners();
    });
    return technicalDBList;
  }

  /// jobCareerごとの言語を合算した言語経歴リストを作成
  List<TechnicalSkill> getAddingUpTechnicalSkillList(Person person) {
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
  List<TechnicalOS> getAddingUpTechnicalOSList(Person person) {
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
  List<TechnicalDB> getAddingUpTechnicalDBList(Person person) {
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

  void searchStart() {
    isSearching = true;
    notifyListeners();
  }

  void searchEnd() {
    isSearching = false;
    _searchedText = '';
    searchedItemList.clear();
    notifyListeners();
  }

  void searchOperation(String searchText, String selectedSortItem) {
    _searchedText = searchText;

    searchedItemList.clear();

    // 全件検索
    searchedItemList.addAll(allItemList.where(
      (element) =>
          element.name.toLowerCase().contains(searchText.toLowerCase()) ||
          element.ruby.toLowerCase().contains(searchText.toLowerCase()) ||
          element.favoriteSkill
              .join(',')
              .toLowerCase()
              .contains(searchText.toLowerCase()) ||
          element.initial.toLowerCase().contains(searchText.toLowerCase()) ||
          ReplaceProfileData.replaceSex(element.sex)
              .toLowerCase()
              .contains(searchText.toLowerCase()) ||
          element.birthDay
              .toString()
              .toLowerCase()
              .contains(searchText.toLowerCase()) ||
          ReplaceProfileData.replaceContractType(element.contractType)
              .toLowerCase()
              .contains(searchText.toLowerCase()) ||
          element.description
              .toLowerCase()
              .contains(searchText.toLowerCase()) ||
          element.station.toLowerCase().contains(searchText.toLowerCase()) ||
          element.experience.toString().contains(searchText.toLowerCase()) ||
          (element.technicalOSList != null &&
              element.technicalOSList!
                  .map((e) => ReplaceTechnical.replaceTechnicalSkill(e.osId))
                  .join(',')
                  .toLowerCase()
                  .contains(
                    searchText.toLowerCase(),
                  )) ||
          (element.technicalSkillList != null &&
              element.technicalSkillList!
                  .map((e) => ReplaceTechnical.replaceTechnicalSkill(e.skillId))
                  .join(',')
                  .toLowerCase()
                  .contains(
                    searchText.toLowerCase(),
                  )) ||
          (element.technicalDBList != null &&
              element.technicalDBList!
                  .map((e) => {ReplaceTechnical.replaceTechnicalSkill(e.dbId)})
                  .join(',')
                  .toLowerCase()
                  .contains(
                    searchText.toLowerCase(),
                  )) ||
          (element.jobCareerList != null &&
              element.jobCareerList!
                  .map((e) => ReplaceProfileData.replaceRole(e.role))
                  .join(',')
                  .toLowerCase()
                  .contains(
                    searchText.toLowerCase(),
                  )) ||
          (element.jobCareerList != null &&
              element.jobCareerList!
                  .map((e) => e.phase)
                  .join(',')
                  .toLowerCase()
                  .contains(
                    searchText.toLowerCase(),
                  )) ||
          (element.jobCareerList != null &&
              element.jobCareerList!
                  .map((e) => {
                        e.usedTechnicalDBList == null
                            ? {""}
                            : {
                                e.usedTechnicalDBList!
                                    .map((f) => f.dbId)
                                    .join(',')
                              }
                      })
                  .join(',')
                  .toLowerCase()
                  .contains(
                    searchText.toLowerCase(),
                  )) ||
          (element.jobCareerList != null &&
              element.jobCareerList!
                  .map((e) => {
                        e.usedTechnicalOSList == null
                            ? {""}
                            : {
                                e.usedTechnicalOSList!
                                    .map((f) => f.osId)
                                    .join(',')
                              }
                      })
                  .join(',')
                  .toLowerCase()
                  .contains(
                    searchText.toLowerCase(),
                  )) ||
          (element.jobCareerList != null &&
              element.jobCareerList!
                  .map((e) => {
                        e.usedTechnicalSkillList == null
                            ? {""}
                            : {
                                e.usedTechnicalSkillList!
                                    .map((f) => f.skillId)
                                    .join(',')
                              }
                      })
                  .join(',')
                  .toLowerCase()
                  .contains(
                    searchText.toLowerCase(),
                  )),
    ));

    searchedItemList = sortList(selectedSortItem, searchedItemList);
    notifyListeners();
  }

  // selectedSortItemの値でソートを行う
  List<Person> sortList(String selectedSortItem, List<Person> itemList) {
    if (selectedSortItem.split('_')[1] == 'ruby') {
      if (selectedSortItem.split('_')[0] == 'up') {
        itemList.sort((a, b) => a.ruby.compareTo(b.ruby));
      } else {
        itemList.sort((a, b) => -a.ruby.compareTo(b.ruby));
      }
    } else if (selectedSortItem.split('_')[1] == 'age') {
      if (selectedSortItem.split('_')[0] == 'up') {
        itemList.sort((a, b) => a.birthDay.compareTo(b.birthDay));
      } else {
        itemList.sort((a, b) => -a.birthDay.compareTo(b.birthDay));
      }
    } else if (selectedSortItem.split('_')[1] == 'updateTime') {
      if (selectedSortItem.split('_')[0] == 'up') {
        itemList.sort((a, b) => a.updateDate.compareTo(b.updateDate));
      } else {
        itemList.sort((a, b) => -a.updateDate.compareTo(b.updateDate));
      }
    }
    return itemList;
  }
}
