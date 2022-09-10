import 'package:flutter/material.dart';
import '../controller/search_bar_controller.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        final controller = SearchBarController();
        controller.init();
        return controller;
      },
      child: Consumer<SearchBarController>(
        builder: (BuildContext context, SearchBarController searchBarController,
            Widget? child) {
          if (searchBarController.isLoading) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          return Scaffold(
            key: searchBarController.globalKey,
            appBar: AppBar(
              centerTitle: true,
              title: _appBarTitle(searchBarController),
              actions: [
                IconButton(
                  icon: _appbarIcon(searchBarController),
                  onPressed: searchBarController.isSearching
                      ? searchBarController.searchEnd
                      : searchBarController.searchStart,
                ),
              ],
            ),
            body: _listWidget(searchBarController),
          );
        },
      ),
    );
  }

  Widget _appbarIcon(SearchBarController searchBarController) {
    return searchBarController.isSearching
        ? const Icon(
            Icons.close,
            color: Colors.white,
          )
        : const Icon(
            Icons.search,
            color: Colors.white,
          );
  }

  Widget _appBarTitle(SearchBarController searchBarController) {
    return searchBarController.isSearching
        ? TextField(
            autofocus: true,
            cursorColor: Colors.white,
            style: const TextStyle(
              color: Colors.white,
            ),
            decoration: const InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              hintText: '全文検索...',
              hintStyle: TextStyle(
                color: Colors.white,
              ),
            ),
            onChanged: (word) {
              searchBarController.searchOperation(word);
            },
          )
        : const Text(
            '検索リスト',
            style: TextStyle(
              color: Colors.white,
            ),
          );
  }

  Widget _listWidget(SearchBarController searchBarController) {
    final itemList = (searchBarController.isSearching &&
            searchBarController.searchedText.isNotEmpty)
        ? searchBarController.searchedItemList
        : searchBarController.allItemList;

    if (itemList.isEmpty) {
      return Center(
        child: Text('"${searchBarController.searchedText}"を含む文字列は見つかりませんでした。'),
      );
    } else {
      return Container(
        color: Colors.white,
        child: ListView.builder(
          key: const PageStorageKey(0),
          controller: searchBarController.scrollController,
          itemCount: itemList.length,
          itemBuilder: (context, index) {
            return SizedBox(
              height: 60,
              child: Card(
                child: Center(
                  child: Text(itemList[index].name),
                ),
              ),
            );
          },
        ),
      );
    }
  }
}
