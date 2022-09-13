import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resume_app/controller/search_bar_controller.dart';
import 'package:resume_app/utils/hex_color.dart';
import 'package:resume_app/screens/search_detail_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);
  final color_gray = '757575';

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
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(HexColor(color_gray)),
                ),
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
            body: _listWidget(context, searchBarController),
          );
        },
      ),
    );
  }

  Widget _appbarIcon(SearchBarController searchBarController) {
    return searchBarController.isSearching
        ? Icon(
            Icons.close,
            color: HexColor(color_gray),
          )
        : Icon(
            Icons.search,
            color: HexColor(color_gray),
          );
  }

  Widget _appBarTitle(SearchBarController searchBarController) {
    return searchBarController.isSearching
        ? TextField(
            autofocus: true,
            cursorColor: Colors.white,
            style: TextStyle(
              color: HexColor(color_gray),
            ),
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: HexColor(color_gray),
              ),
              hintText: '全文検索...',
              hintStyle: TextStyle(
                color: HexColor(color_gray),
              ),
            ),
            onChanged: (word) {
              searchBarController.searchOperation(word);
            },
          )
        : Text(
            '検索リスト',
            style: TextStyle(
              color: HexColor(color_gray),
            ),
          );
  }

  Widget _listWidget(
      BuildContext context, SearchBarController searchBarController) {
    final itemList = (searchBarController.isSearching &&
            searchBarController.searchedText.isNotEmpty)
        ? searchBarController.searchedItemList
        : searchBarController.allItemList;

    if (itemList.isEmpty) {
      return Center(
        child: Text('"${searchBarController.searchedText}"を含む文字列は見つかりませんでした。'),
      );
    } else {
      return ListView.builder(
          itemCount: itemList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        SearchDatailScreen(itemList[index], index)),
              ),
              child: Card(
                child: ListTile(
                  leading: Hero(
                    tag: 'image${index}',
                    child: Image.network(
                      itemList[index].image,
                    ),
                  ),
                  title: Text(
                    itemList[index].name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(itemList[index].ruby),
                  trailing: Icon(Icons.more_vert),
                  minVerticalPadding: 20,
                ),
              ),
            );
          });
    }
  }
}
