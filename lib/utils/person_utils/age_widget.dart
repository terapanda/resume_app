import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:resume_app/model/person.dart';
import 'package:resume_app/utils/hex_color.dart';

// 年齢
class AgeWidget {
  Widget get(bool isCard, Person personItem) {
    if (isCard) {
      return Row(
        // Property
        children: [
          Icon(FontAwesomeIcons.addressCard, size: 20, color: HexColor()),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${personItem.age}歳',
                style: TextStyle(fontSize: 16, color: HexColor()),
              ),
            ),
          ),
        ],
      );
    } else {
      return Expanded(
        flex: 1, // 1 要素分の横幅
        child: Row(
          // Property
          children: [
            Icon(FontAwesomeIcons.addressCard, size: 30, color: HexColor()),
            Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '年齢',
                        style: TextStyle(fontSize: 12, color: HexColor()),
                      ),
                      Text(
                        '${personItem.age}歳',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ])),
          ],
        ),
      );
    }
  }
}
