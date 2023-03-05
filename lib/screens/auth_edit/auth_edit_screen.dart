import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resume_app/controller/search_bar_controller.dart';
import 'package:resume_app/screens/auth_edit/person_auth_list_widget.dart';
import 'package:resume_app/screens/search/person_list_widget.dart';
import 'package:resume_app/utils/hex_color.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AuthEditScreen extends StatefulWidget {
  const AuthEditScreen({Key? key}) : super(key: key);

  @override
  State<AuthEditScreen> createState() => _AuthEditScreenState();
}

class _AuthEditScreenState extends State<AuthEditScreen> {
  var _inputWord = '';
  var _selectedSortItem = 'up_ruby';
  final screenName = "AuthEditScreen";

  late String searchValue = "";
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        final controller = SearchBarController();
        controller.init(searchValue, _selectedSortItem, screenName);

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
                    PersonAuthListWidget(
                        searchBarController: searchBarController),
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
}
