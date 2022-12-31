import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:resume_app/model/person.dart';
import 'package:resume_app/utils/hex_color.dart';
import 'package:resume_app/utils/replace_profile_data.dart';

// 経験年数
class ExperienceWidget {
  Widget get(bool isCard, Person personItem) {
    if (isCard) {
      return Row(
        // Property
        children: [
          Icon(FontAwesomeIcons.briefcase, size: 20, color: HexColor()),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '経験年数 ${personItem.experience} 年',
                style: TextStyle(fontSize: 16, color: HexColor()),
              ),
            ),
          ),
        ],
      );
    } else {
      return Row(
        // Property
        children: [
          Icon(FontAwesomeIcons.briefcase, size: 40, color: HexColor()),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              '経験年数 ${personItem.experience} 年',
              style: TextStyle(fontSize: 16, color: HexColor()),
            ),
          ),
        ],
      );
    }
  }
}
