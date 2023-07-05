import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:resume_app/component/icons/my_flutter_app_icons.dart';

class ReplaceTechnical {
  Future<String> replaceTechnicalSkill(
      String skillId, Map<String, Map<dynamic, String>> masterData) async {
    Map<dynamic, String> developLanguage = {};
    developLanguage
        .addAll(masterData["developLanguageSkill"] as Map<dynamic, String>);
    developLanguage
        .addAll(masterData["developLanguageOS"] as Map<dynamic, String>);
    developLanguage
        .addAll(masterData["developLanguageDB"] as Map<dynamic, String>);

    final entrySkill = developLanguage.entries.firstWhere(
        (entry) => entry.key == skillId,
        orElse: () => MapEntry(skillId, skillId));

    if (entrySkill == null) {
      return skillId;
    }
    return entrySkill.value;
  }

  Icon getSkillIcon(String language, double size, Color color) {
    switch (language) {
      case 'react':
        return Icon(FontAwesomeIcons.react, size: size, color: color);
      case 'vue':
        return Icon(FontAwesomeIcons.vuejs, size: size, color: color);
      case 'angular':
        return Icon(FontAwesomeIcons.angular, size: size, color: color);
      case 'javascript':
        return Icon(FontAwesomeIcons.js, size: size, color: color);
      case 'node':
        return Icon(FontAwesomeIcons.node, size: size, color: color);
      case 'java':
        return Icon(FontAwesomeIcons.java, size: size, color: color);
      case 'php':
        return Icon(FontAwesomeIcons.php, size: size, color: color);
      case 'python':
        return Icon(FontAwesomeIcons.python, size: size, color: color);
      case 'c':
        return Icon(FontAwesomeIcons.c, size: size, color: color);
      case 'rust':
        return Icon(FontAwesomeIcons.rust, size: size, color: color);
      case 'android':
        return Icon(FontAwesomeIcons.android, size: size, color: color);
      case 'apple':
        return Icon(FontAwesomeIcons.apple, size: size, color: color);
      case 'swift':
        return Icon(FontAwesomeIcons.swift, size: size, color: color);
      case 'unity':
        return Icon(FontAwesomeIcons.unity, size: size, color: color);
      case 'f':
        return Icon(FontAwesomeIcons.f, size: size, color: color);
      case 'flutter':
        return Icon(MyFlutterApp.flutter, size: size, color: color);
      case 'c_sharp':
        return Icon(MyFlutterApp.c_sharp, size: size, color: color);
      case 'c_puls':
        return Icon(MyFlutterApp.c_puls, size: size, color: color);
      case 'ruby':
        return Icon(MyFlutterApp.ruby, size: size, color: color);
      case 'oracle':
        return Icon(MyFlutterApp.oracle, size: size, color: color);
      case 'vba':
        return Icon(MyFlutterApp.excel, size: size, color: color);
      case 'tomcat':
        return Icon(MyFlutterApp.tomcat, size: size, color: color);
      case 'graphql':
        return Icon(MyFlutterApp.graphql, size: size, color: color);
      default:
        return Icon(MyFlutterApp.c_sharp, size: size, color: color);
    }
  }
}
