import 'package:flutter/material.dart';
import '../example_data/search_screen_data.dart';
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

  void init() {
    fetch();
  }

  Future<void> fetch() async {
    // データとってきたときにローディング何秒間出すか？
    await Future.delayed(const Duration(seconds: 1)).then((_) {
      // fetch data
      // allItemList = await hogehogeRepo.fetch();
      allItemList = exampleList;

      isLoading = false;
      notifyListeners();
    });
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

  void searchOperation(String searchText) {
    _searchedText = searchText;

    searchedItemList.clear();

    searchedItemList.addAll(
      allItemList.where(
        (element) =>
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
                ),
      ),
    );
    notifyListeners();
  }
}
