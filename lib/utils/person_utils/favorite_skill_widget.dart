import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:resume_app/model/person.dart';
import 'package:resume_app/utils/hex_color.dart';

// 得意な言語
class FavoriteSkillWidget {
  Widget get(bool isCard, Person personItem) {
    if (isCard) {
      return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Wrap(
            //RowからWrapへ
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Icon(
                  FontAwesomeIcons.bookmark,
                  size: 20,
                  color: HexColor(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Wrap(
                  children: personItem.favoriteSkill
                      .map((favoriteSkillItem) => Container(
                          margin: const EdgeInsets.only(bottom: 8, right: 16),
                          padding: const EdgeInsets.only(
                              top: 4, bottom: 4, left: 8, right: 8),
                          decoration: BoxDecoration(
                            border: Border.all(color: HexColor()),
                            borderRadius: BorderRadius.circular(45),
                          ),
                          child: Text(favoriteSkillItem)))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Row(
          // Property
          children: [
            SizedBox(
              width: 30,
              child: Icon(
                FontAwesomeIcons.bookmark,
                size: 30,
                color: HexColor(),
              ),
            ),
            Expanded(
                child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 4, bottom: 4),
                        child: Text(
                          '得意な言語',
                          style: TextStyle(fontSize: 12, color: HexColor()),
                        ),
                      ),
                      Wrap(
                        children: personItem.favoriteSkill
                            .map((favoriteSkillItem) => Container(
                                margin:
                                    const EdgeInsets.only(bottom: 4, right: 16),
                                padding: const EdgeInsets.only(
                                    top: 4, bottom: 4, left: 8, right: 8),
                                decoration: BoxDecoration(
                                  border: Border.all(color: HexColor()),
                                  borderRadius: BorderRadius.circular(45),
                                ),
                                child: Text(favoriteSkillItem)))
                            .toList(),
                      ),
                    ]),
              ),
            )),
          ]);
    }
  }
}
