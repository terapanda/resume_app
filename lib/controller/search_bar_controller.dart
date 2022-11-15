import 'package:flutter/material.dart';
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
    // allItemList = await hogehogeRepo.fetch();

    // allItemList = exampleList;
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
    searchedItemList.addAll(allItemList.where((element) =>
        element.name.toLowerCase().contains(
              searchText.toLowerCase(),
            ) ||
        element.ruby.toLowerCase().contains(
              searchText.toLowerCase(),
            ) ||
        element.sex.toLowerCase().contains(
              searchText.toLowerCase(),
            ) ||
        element.age.toLowerCase().contains(
              searchText.toLowerCase(),
            ) ||
        element.station.toLowerCase().contains(
              searchText.toLowerCase(),
            ) ||
        element.experience.toString().contains(
              searchText.toLowerCase(),
            ) ||
        element.excelsAt.join(',').toLowerCase().contains(
              searchText.toLowerCase(),
            )));

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
