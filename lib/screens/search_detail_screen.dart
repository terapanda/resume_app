import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:resume_app/utils/hex_color.dart';
import 'package:resume_app/model/person.dart';
import 'package:resume_app/utils/replace_profile_data.dart';

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
        automaticallyImplyLeading: true,
      ),
      body: Column(children: <Widget>[
        Container(
          alignment: Alignment.center,
          height: 150,
          margin: EdgeInsets.only(top: 24, bottom: 24),
          child: Image.network(
            personItem.image,
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Card(
              elevation: 5,
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding:
                      EdgeInsets.only(top: 8, bottom: 16, left: 32, right: 32),
                  child: Column(
                    children: [
                      name(personItem),
                      new Divider(),
                      Padding(padding: EdgeInsets.only(top: 8)),
                      age(personItem),
                      sex(personItem),
                      station(personItem),
                      favorite(personItem),
                      new Divider(),
                      Padding(padding: EdgeInsets.only(top: 8)),
                      technicalSkill(personItem),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  // 名前
  Widget name(Person personItem) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            personItem.ruby,
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(bottom: 4),
            child: Text(
              personItem.name,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  // 年齢
  Widget age(Person personItem) {
    return Row(
      // Property
      children: [
        Icon(
          FontAwesomeIcons.addressCard,
          size: 20,
          color: HexColor(),
        ),
        Padding(
          padding: EdgeInsets.only(left: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              personItem.age.toString() + '歳',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }

  // 性別
  Widget sex(Person personItem) {
    return Row(
      // Property
      children: [
        Icon(
          FontAwesomeIcons.marsAndVenus,
          size: 20,
          color: HexColor(),
        ),
        Padding(
          padding: EdgeInsets.only(left: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              ReplaceProfileData.replaceSex(personItem.sex),
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }

  // 最寄り駅
  Widget station(Person personItem) {
    return Row(
      // Property
      children: [
        Icon(
          FontAwesomeIcons.trainSubway,
          size: 20,
          color: HexColor(),
        ),
        Padding(
          padding: EdgeInsets.only(left: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              personItem.station + '駅',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }

  // お気に入り
  Widget favorite(Person personItem) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(top: 8),
        child: Wrap(
          //RowからWrapへ
          children: [
            Icon(
              FontAwesomeIcons.bookmark,
              size: 20,
              color: HexColor(),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: Wrap(
                //RowからWrapへ
                children: [
                  Container(
                      margin: const EdgeInsets.only(bottom: 8, right: 16),
                      padding: const EdgeInsets.only(
                          top: 4, bottom: 4, left: 8, right: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: HexColor()),
                        borderRadius: BorderRadius.circular(45),
                      ),
                      child: const Text("COBOL")),
                  Container(
                    margin: const EdgeInsets.only(bottom: 8, right: 16),
                    padding: const EdgeInsets.only(
                        top: 4, bottom: 4, left: 8, right: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: HexColor()),
                      borderRadius: BorderRadius.circular(45),
                    ),
                    child: const Text("C++"),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 8, right: 16),
                    padding: const EdgeInsets.only(
                        top: 4, bottom: 4, left: 8, right: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: HexColor()),
                      borderRadius: BorderRadius.circular(45),
                    ),
                    child: const Text("Java"),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 8, right: 16),
                    padding: const EdgeInsets.only(
                        top: 4, bottom: 4, left: 8, right: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: HexColor()),
                      borderRadius: BorderRadius.circular(45),
                    ),
                    child: const Text("Java"),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 8, right: 16),
                    padding: const EdgeInsets.only(
                        top: 4, bottom: 4, left: 8, right: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: HexColor()),
                      borderRadius: BorderRadius.circular(45),
                    ),
                    child: const Text("Java"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // テクニカルスキル
  Widget technicalSkill(Person personItem) {
    return Column(
        // Property
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '言語経歴',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'OS',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
        ]);
  }
}
