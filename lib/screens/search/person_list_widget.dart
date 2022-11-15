import 'package:flutter/material.dart';
import 'package:resume_app/controller/search_bar_controller.dart';
import 'package:resume_app/screens/search/person_widget.dart';

class PersonListWidget extends StatelessWidget {
  final SearchBarController searchBarController;

  const PersonListWidget({
    Key? key,
    required this.searchBarController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemList = (searchBarController.isSearching &&
            searchBarController.searchedText.isNotEmpty)
        ? searchBarController.searchedItemList
        : searchBarController.allItemList;

    return Flexible(
      child: itemList.isEmpty
          ? Center(
              child: Text(
                  '"${searchBarController.searchedText}"を含む文字列は見つかりませんでした。'),
            )
          : ListView.builder(
              itemCount: itemList.length,
              itemBuilder: (context, index) {
                return PersonWidget(personList: itemList, index: index);
              },
            ),
    );
  }
}
