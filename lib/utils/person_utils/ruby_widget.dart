import 'package:flutter/material.dart';
import 'package:resume_app/model/person.dart';

// ふりがな
class RubyWidget {
  Widget get(Person personItem) {
    return Flexible(
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Text(
            personItem.ruby,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
