import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resume_app/controller/search_bar_controller.dart';
import 'package:resume_app/utils/hex_color.dart';
import 'package:resume_app/model/person.dart';

//スクリーン2
class SearchDatailScreen extends StatelessWidget {
  SearchDatailScreen(this.personItem, this.listindex, {Key? key})
      : super(key: key);
  Person personItem;
  int listindex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SearchDatailScreen'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Hero(
            tag: 'image${listindex}',
            child: Image.network(
              personItem.image,
            ),
          ),
        ),
      ),
    );
  }
}
