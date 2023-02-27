import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';

class Profile {
  late Timestamp? birthDay;
  late int? contractType;
  late String? description;
  late List? favoriteSkill;
  late String? image;
  late String? initial;
  late String? nameFirst;
  late String? nameLast;
  late String? rubyFirst;
  late String? rubyLast;
  late int? sex;
  late String? station;

  Profile({
    this.birthDay,
    this.contractType,
    this.description,
    this.favoriteSkill,
    this.image,
    this.initial,
    this.nameFirst,
    this.nameLast,
    this.rubyFirst,
    this.rubyLast,
    this.sex,
    this.station,
  });
}
