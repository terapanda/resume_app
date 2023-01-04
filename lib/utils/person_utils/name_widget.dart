import 'package:flutter/material.dart';
import 'package:resume_app/model/person.dart';

// 名前
class NameWidget {
  Widget get(Person personItem, double fontSize) {
    return Flexible(
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Text(
            personItem.name,
            style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
