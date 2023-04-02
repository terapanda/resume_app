import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:resume_app/model/person_converter.dart';
import 'package:resume_app/utils/replace_profile_data.dart';
import 'package:resume_app/utils/replace_technical.dart';
import 'package:resume_app/model/person.dart';

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

  void init(
      String searchValue, String selectedSortItem, String screenName) async {
    // データとってきたときにローディング何秒間出すか？
    await Future.delayed(const Duration(seconds: 1)).then((_) {
      fetch(searchValue, selectedSortItem, screenName);
    });
  }

  Future<void> fetch(
      String searchValue, String selectedSortItem, String screenName) async {
    // fetch data
    List<Person> personList = await fetchPersonList(screenName);

    allItemList = sortList(selectedSortItem, personList);

    isLoading = false;
    if (searchValue != null) {
      searchOperation(searchValue, selectedSortItem);
    } else {
      notifyListeners();
    }
  }

  static Future<List<Person>> fetchPersonList(String screenName) async {
    List<Person> personList = [];
    await FirebaseFirestore.instance
        .collection('search')
        .get()
        .then((event) async {
      for (var doc in event.docs) {
        // プログラマーのみ表示
        if (screenName == "SearchScreen" && !doc.data()['isProgrammer']) {
          continue;
        }
        if (screenName == "AuthEditScreen" && doc.data()['authority'] == 1) {
          continue;
        }

        // 取得したuserデータをPersonの形に置き換える
        Person person = await PersonConverter.convert(doc);
        personList.add(person);
      }
    });
    return personList;
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
    ReplaceProfileData replaceProfileData = ReplaceProfileData();
    _searchedText = searchText;

    searchedItemList.clear();

    // 全件検索
    searchedItemList.addAll(allItemList.where(
      (element) =>
          element.department.toLowerCase().contains(searchText.toLowerCase()) ||
          (element.branchOffice != null &&
              element.branchOffice!
                  .toLowerCase()
                  .contains(searchText.toLowerCase())) ||
          element.name.toLowerCase().contains(searchText.toLowerCase()) ||
          element.ruby.toLowerCase().contains(searchText.toLowerCase()) ||
          element.favoriteSkill!
              .join(',')
              .toLowerCase()
              .contains(searchText.toLowerCase()) ||
          element.initial.toLowerCase().contains(searchText.toLowerCase()) ||
          element.sex.contains(searchText.toLowerCase()) ||
          element.birthDay
              .toString()
              .toLowerCase()
              .contains(searchText.toLowerCase()) ||
          element.contractType!.contains(searchText.toLowerCase()) ||
          element.description!
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
                  .map((e) => replaceProfileData.replaceRole(e.role))
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
        itemList.sort((a, b) => a.age.compareTo(b.age));
      } else {
        itemList.sort((a, b) => -a.age.compareTo(b.age));
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
