import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resume_app/model/person.dart';
import 'package:resume_app/services/firebaseService.dart';
import 'package:resume_app/utils/person_utils/name_widget.dart';

class PersonAuthWidget extends StatefulWidget {
  final Person person;

  const PersonAuthWidget({
    Key? key,
    required this.person,
  }) : super(key: key);

  @override
  State<PersonAuthWidget> createState() => _PersonAuthWidgetState();
}

class _PersonAuthWidgetState extends State<PersonAuthWidget> {
  late bool isAdmin;
  late bool isProgramer;
  late bool isFullTimeEmployee;

  @override
  void initState() {
    super.initState();

    isAdmin = widget.person.authority == 2;
    isProgramer = widget.person.isProgrammer;
    isFullTimeEmployee = widget.person.contractType == "正社員";
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
        child: Column(
          children: [
            Row(children: [
              Text(
                "${widget.person.department}　${widget.person.branchOffice ?? ""}",
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
            ]),
            Row(children: [
              NameWidget().get(widget.person, 16),
              Row(children: [
                Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Tooltip(
                      message:
                          '管理者\n・PDFダウンロード\n・権限の変更\n・経歴の一時編集\n・ユーザの削除\n\n一般ユーザ\n・個人情報の修正\n・経歴の編集',
                      child: Text(
                        isAdmin ? "管理者" : "一般ユーザ",
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    )),
                Center(
                  child: CupertinoSwitch(
                    value: isAdmin,
                    activeColor: CupertinoColors.activeOrange,
                    onChanged: (bool? value) async {
                      setState(() {
                        isAdmin = value ?? false;
                      });

                      await FirebaseService.saveAuthority(
                          widget.person.id, isAdmin ? 2 : 3);
                    },
                  ),
                ),
              ]),
            ]),
            Row(children: [
              Flexible(
                  child: Align(
                      alignment: Alignment.centerLeft, child: SizedBox())),
              Row(children: [
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Tooltip(
                    message: '主にプログラマーである場合にtrueとする。',
                    child: Text(
                      isProgramer ? "検索画面に表示する" : "検索画面に表示しない",
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Center(
                  child: CupertinoSwitch(
                    value: isProgramer,
                    activeColor: CupertinoColors.activeOrange,
                    onChanged: (bool? value) async {
                      setState(() {
                        isProgramer = value ?? false;
                      });

                      await FirebaseService.saveIsProgrammer(
                          widget.person.id, isProgramer);
                    },
                  ),
                ),
              ]),
            ]),
            Row(children: [
              Flexible(
                  child: Align(
                      alignment: Alignment.centerLeft, child: SizedBox())),
              Row(children: [
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Tooltip(
                    message: '契約種別',
                    child: Text(
                      isFullTimeEmployee ? "正社員" : "契約社員",
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Center(
                  child: CupertinoSwitch(
                    value: isFullTimeEmployee,
                    activeColor: CupertinoColors.activeOrange,
                    onChanged: (bool? value) async {
                      setState(() {
                        isFullTimeEmployee = value ?? false;
                      });

                      await FirebaseService.saveContractType(
                          widget.person.id, isFullTimeEmployee ? 1 : 2);
                    },
                  ),
                ),
              ]),
            ]),
          ],
        ),
      ),
    );
  }
}
