import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:resume_app/controller/search_bar_controller.dart';
import 'package:resume_app/provider/user_state.dart';
import 'package:resume_app/screens/auth_edit/person_auth_widget.dart';
import 'package:resume_app/utils/use_shared_preferences.dart';

class PersonAuthListWidget extends ConsumerWidget {
  final SearchBarController searchBarController;

  const PersonAuthListWidget({
    Key? key,
    required this.searchBarController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final masterData = UseSharedPreferences.getUserDefaults('master');
    final itemList = (searchBarController.isSearching &&
            searchBarController.searchedText.isNotEmpty)
        ? searchBarController.searchedItemList
        : searchBarController.allItemList;

    return Flexible(
      child: itemList.isEmpty
          ? Center(
              child: Text(
                  '"${searchBarController.searchedText}"を含むエンジニアは見つかりませんでした。'),
            )
          : ListView.builder(
              itemCount: itemList.length,
              itemBuilder: (context, index) {
                return PersonAuthWidget(person: itemList[index]);
              },
            ),
    );
  }
}
