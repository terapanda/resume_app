import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resume_app/controller/search_bar_controller.dart';
import 'package:resume_app/utils/hex_color.dart';

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
            body: _listWidget(searchBarController),
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
      return GridView.count(
        padding: EdgeInsets.all(4.0),
        crossAxisCount: 2,
        crossAxisSpacing: 10.0, // 縦
        mainAxisSpacing: 10.0, // 横
        childAspectRatio: 0.7, // 高さ
        shrinkWrap: true,
        children: List.generate(itemList.length, (index) {
          return Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                new BoxShadow(
                  color: Colors.grey,
                  offset: new Offset(5.0, 5.0),
                  blurRadius: 10.0,
                )
              ],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(children: <Widget>[
              Container(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      itemList[index].image,
                      fit: BoxFit.cover,
                    )),
              ),
              Container(
                margin: const EdgeInsets.only(top: 16.0),
                width: double.infinity,
                child: Text(
                  itemList[index].ruby,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 10,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                child: Text(
                  itemList[index].name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 4.0),
                width: double.infinity,
                child: Text(
                  "年齢：${itemList[index].age}歳",
                  style: TextStyle(
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ]),
          );
        }),
      );
    }
  }
}
