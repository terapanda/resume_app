import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:resume_app/component/icons/my_flutter_app_icons.dart';

class ReplaceTechnical {
  static String replaceTechnicalSkill(String skillId) {
    switch (skillId) {
      case 'react':
        return "React";
      case 'vue':
        return "Vue";
      case 'angular':
        return "Angular";
      case 'javascript':
        return "Javascript";
      case 'type_script':
        return "Type script";
      case 'node':
        return "Node";
      case 'java':
        return "Java";
      case 'php':
        return "Php";
      case 'python':
        return "Python";
      case 'c':
        return "C";
      case 'rust':
        return "Rust";
      case 'android':
        return "Android";
      case 'apple':
        return "Apple";
      case 'swift':
        return "Swift";
      case 'unity':
        return "Unity";
      case 'f':
        return "F";
      case 'flutter':
        return "Flutter";
      case 'c_sharp':
        return "C_sharp";
      case 'c_puls':
        return "C_puls";
      case 'ruby':
        return "Ruby";
      case 'vba':
        return "VBa";
      case 'oracle':
        return "Oracle";
      case 'tomcat':
        return "Tomcat";
      case 'graphql':
        return "Graphql";
      default:
        return skillId;
    }
  }

  static Icon getSkillIcon(String language, double size, Color color) {
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
