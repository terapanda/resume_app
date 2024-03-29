import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:resume_app/model/person.dart';
import 'package:resume_app/utils/hex_color.dart';
import 'package:resume_app/utils/replace_profile_data.dart';

// 性別
class SexWidget {
  Widget get(bool isCard, Person personItem) {
    ReplaceProfileData replaceProfileData = ReplaceProfileData();
    if (isCard) {
      return Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Row(
          // Property
          children: [
            Icon(
                personItem.sex == "男性"
                    ? FontAwesomeIcons.mars
                    : personItem.sex == "女性"
                        ? FontAwesomeIcons.venus
                        : FontAwesomeIcons.question,
                size: 20,
                color: HexColor()),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  personItem.sex,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Expanded(
        flex: 1, // 1 要素分の横幅
        child: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Row(
            // Property
            children: [
              Icon(
                  personItem.sex == "男性"
                      ? FontAwesomeIcons.mars
                      : personItem.sex == "女性"
                          ? FontAwesomeIcons.venus
                          : FontAwesomeIcons.question,
                  size: 30,
                  color: HexColor()),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '性別',
                        style: TextStyle(fontSize: 12, color: HexColor()),
                      ),
                      Text(
                        personItem.sex,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ]),
              ),
            ],
          ),
        ),
      );
    }
  }
}
