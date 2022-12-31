import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:resume_app/model/person.dart';
import 'package:resume_app/utils/hex_color.dart';

// 最寄り駅
class StationWidget {
  Widget get(bool isCard, Person personItem) {
    if (isCard) {
      return Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Row(
          // Property
          children: [
            Icon(FontAwesomeIcons.trainSubway, size: 20, color: HexColor()),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '${personItem.station}駅',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Row(
          // Property
          children: [
            Icon(FontAwesomeIcons.trainSubway, size: 30, color: HexColor()),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '最寄り駅',
                      style: TextStyle(fontSize: 12, color: HexColor()),
                    ),
                    Text(
                      '${personItem.station}駅',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ]),
            ),
          ],
        ),
      );
    }
  }
}
