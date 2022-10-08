import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resume_app/controller/search_bar_controller.dart';
import 'package:resume_app/utils/hex_color.dart';
import 'package:resume_app/screens/search_detail_screen.dart';
import 'package:resume_app/screens/create_pdf/create_pdf_screen.dart';
import 'package:banner_listtile/banner_listtile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchScreen extends StatefulWidget {
  final String searchValue; //上位Widgetから受け取りたいデータ

  const SearchScreen({Key? key, required this.searchValue}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var color_gray = '757575'; // アイコン、文字色
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
              body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ソート用のドロップダウンリスト
                    _dropDownWidget(searchBarController),
                    _listWidget(context, searchBarController),
                  ]));
        },
      ),
    );
  }

  Icon _appbarIcon(SearchBarController searchBarController) {
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
        ? TextFormField(
            autofocus: true,
            cursorColor: HexColor(color_gray),
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
              color: HexColor(color_gray),
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
                    color: HexColor(color_gray),
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
            color: HexColor(color_gray),
          )
        : Icon(
            FontAwesomeIcons.arrowDownShortWide,
            size: 24,
            color: HexColor(color_gray),
          );
  }

  Widget _listWidget(
      BuildContext context, SearchBarController searchBarController) {
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
                return Card(
                  child: InkWell(
                    child: BannerListTile(
                      imageContainerShapeZigzagIndex: index,
                      backgroundColor: Colors.white,
                      showBanner: false,
                      bannerPositionRight: false,
                      borderRadius: BorderRadius.circular(8),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SearchDatailScreen(itemList[index], index)),
                      ),
                      title: Text(
                        // style: TextStyle(fontSize: 20, color: Colors.white),
                        itemList[index].name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      imageContainer: Hero(
                        tag: 'image${index}',
                        child: Image.network(
                          itemList[index].image,
                        ),
                      ),
                      subtitle: Text(
                        itemList[index].ruby,
                      ),
                      trailing: PopupMenuButton(
                        icon: const Icon(Icons.more_vert),
                        itemBuilder: (context) {
                          return [
                            makePopupMenuItem('edit', FontAwesomeIcons.userPen),
                            makePopupMenuItem('pdf', FontAwesomeIcons.filePdf),
                            makePopupMenuItem('delete', FontAwesomeIcons.trash),
                          ];
                        },
                        onSelected: (String value) => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CreatePdfScreen(person: itemList[index])),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  PopupMenuItem<String> makePopupMenuItem(String itemValue, IconData icon) {
    return PopupMenuItem(
      value: itemValue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 24,
            color: HexColor(color_gray),
          ),
          Padding(padding: EdgeInsets.only(right: 16)),
          Text(itemValue.toUpperCase()),
        ],
      ),
    );
  }
}
