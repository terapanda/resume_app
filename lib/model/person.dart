class Person {
  final String id;
  final String name;
  final String ruby;
  final String initial;
  final String sex;
  final String age;
  final String station;
  final String image;

  const Person(
      {required this.id, // 社員番号
      required this.name, // 名前
      this.ruby = '', // かな
      required this.initial, // イニシャル
      required this.sex, // 性別
      required this.age, // 年齢
      required this.station, // 駅
      required this.image // 写真
      });
}
