import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resume_app/controller/search_bar_controller.dart';
import 'package:resume_app/screens/search/person_list_widget.dart';
import 'package:resume_app/utils/hex_color.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchScreen extends StatefulWidget {
  final String searchValue; //上位Widgetから受け取りたいデータ

  const SearchScreen({Key? key, required this.searchValue}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var _inputWord = '';
  var _selectedSortItem = 'up_ruby';
  final _sortMap = {
    'up_ruby': "名前：昇順",
    'down_ruby': "名前：降順",
    'up_age': "年齢：昇順",
    'down_age': "年齢：降順"
  };

  late String searchValue; // 前画面から受け取った検索用文字列
  @override
  void initState() {
    super.initState();

    // 受け取ったデータを状態を管理する変数に格納
    searchValue = widget.searchValue;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        final controller = SearchBarController();
        controller.init(searchValue, _selectedSortItem);

        if (searchValue != "") {
          controller.isSearching = true;
        }

        return controller;
      },
      child: Consumer<SearchBarController>(
        builder: (BuildContext context, SearchBarController searchBarController,
            Widget? child) {
          if (searchBarController.isLoading) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(HexColor()),
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
              body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ソート用のドロップダウンリスト
                    _dropDownWidget(searchBarController),
                    PersonListWidget(searchBarController: searchBarController),
                  ]));
        },
      ),
    );
  }

  Icon _appbarIcon(SearchBarController searchBarController) {
    return searchBarController.isSearching
        ? Icon(
            Icons.close,
            color: HexColor(),
          )
        : Icon(
            Icons.search,
            color: HexColor(),
          );
  }

  Widget _appBarTitle(SearchBarController searchBarController) {
    return searchBarController.isSearching
        ? TextFormField(
            autofocus: true,
            cursorColor: HexColor(),
            style: TextStyle(
              color: HexColor(),
            ),
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: HexColor(),
              ),
              hintText: '全文検索...',
              hintStyle: TextStyle(
                color: HexColor(),
              ),
            ),
            initialValue: searchValue, //ここに初期値
            onChanged: (word) {
              setState(() {
                _inputWord = word;
              });

              searchBarController.searchOperation(word, _selectedSortItem);
            },
          )
        : Text(
            '検索リスト',
            style: TextStyle(
              color: HexColor(),
            ),
          );
  }

  Widget _dropDownWidget(SearchBarController searchBarController) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Container(
          alignment: Alignment.center, //中央
          height: 56,
          child: PopupMenuButton(
            // elevation: 10,
            splashRadius: 50,
            tooltip: 'ソート順[ ${_sortMap[_selectedSortItem] as String} ]',
            position: PopupMenuPosition.under,
            iconSize: MediaQuery.of(context).size.width * 0.5,
            icon: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _searchIcon(_selectedSortItem),
                Padding(padding: EdgeInsets.only(right: 16)),
                Text(
                  _sortMap[_selectedSortItem] as String,
                  style: TextStyle(
                    color: HexColor(),
                  ),
                ),
              ],
            ),
            itemBuilder: (context) {
              return _sortMap.entries.map((entry) {
                return PopupMenuItem(
                  mouseCursor: MouseCursor.defer,
                  value: entry.key,
                  child: Text(entry.value),
                );
              }).toList();
            },
            onSelected: (newValue) {
              setState(() {
                _selectedSortItem = newValue as String;
              });
              searchBarController.fetch(_inputWord, newValue as String);
            },
          ),
        ),
      ),
    );
  }

  Widget _searchIcon(String selectedSortItem) {
    return selectedSortItem.split('_')[0] == 'up'
        ? Icon(
            FontAwesomeIcons.arrowDownWideShort,
            size: 24,
            color: HexColor(),
          )
        : Icon(
            FontAwesomeIcons.arrowDownShortWide,
            size: 24,
            color: HexColor(),
          );
  }
}
