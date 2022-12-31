import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:resume_app/model/person.dart';
import 'package:resume_app/utils/hex_color.dart';

// 写真
class ImageWidget {
  Widget get(Person personItem, double size) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(45),
        child: Image.network(
          personItem.image,
          width: size,
          height: size,
        ),
      ),
    );
  }
}
