import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:resume_app/model/person.dart';
import 'package:resume_app/utils/hex_color.dart';

// 最終更新日
class LastUpdateDateWidget {
  Widget get(bool isCard, Person personItem) {
    if (isCard) {
      return Row(
        // Property
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(FontAwesomeIcons.clock, size: 14, color: HexColor()),
          Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '最終更新時刻',
                      style: TextStyle(fontSize: 9, color: HexColor()),
                    ),
                    Text(
                      personItem.lastUpdateDate.toString().substring(0, 16),
                      style: const TextStyle(fontSize: 12),
                    ),
                  ])),
        ],
      );
    } else {
      return Row(
        // Property
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(FontAwesomeIcons.clock, size: 14, color: HexColor()),
          Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '最終更新時刻',
                      style: TextStyle(fontSize: 9, color: HexColor()),
                    ),
                    Text(
                      personItem.lastUpdateDate.toString().substring(0, 16),
                      style: const TextStyle(fontSize: 12),
                    ),
                  ])),
        ],
      );
    }
  }
}
