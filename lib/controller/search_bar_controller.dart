import 'package:flutter/material.dart';
import 'package:resume_app/model/technical_db.dart';
import 'package:resume_app/model/technical_os.dart';
import 'package:resume_app/model/technical_skill.dart';
import 'package:resume_app/utils/replace_profile_data.dart';
import 'package:resume_app/utils/replace_technical.dart';
import '../example_data/search_screen_data.dart';
import 'package:resume_app/model/person.dart';
import 'package:collection/src/iterable_extensions.dart';

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
    // exampleList = await hogehogeRepo.fetch();

    allItemList = sortList(selectedSortItem, exampleList);

    isLoading = false;
    if (searchValue != null) {
      searchOperation(searchValue, selectedSortItem);
    } else {
      notifyListeners();
    }
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
          element.excelsAt
              .join(',')
              .toLowerCase()
              .contains(searchText.toLowerCase()) ||
          element.initial.toLowerCase().contains(searchText.toLowerCase()) ||
          ReplaceProfileData.replaceSex(element.sex)
              .toLowerCase()
              .contains(searchText.toLowerCase()) ||
          element.age
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
                  .map((e) => e.phaseInCharge)
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
    }
    return itemList;
  }
}
