import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resume_app/model/person.dart';
import 'package:resume_app/services/firebaseService.dart';
import 'package:resume_app/utils/person_utils/name_widget.dart';

class PersonAuthWidget extends StatefulWidget {
  final Person person;
  final int adminKey;
  final int uesrKey;

  const PersonAuthWidget({
    Key? key,
    required this.person,
    required this.adminKey,
    required this.uesrKey,
  }) : super(key: key);

  @override
  State<PersonAuthWidget> createState() => _PersonAuthWidgetState();
}

class _PersonAuthWidgetState extends State<PersonAuthWidget> {
  late bool switchValue;

  @override
  void initState() {
    super.initState();

    switchValue = widget.person.authority == widget.adminKey;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
        child: Column(
          children: [
            Row(children: [
              Flexible(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Text(
                      "${widget.person.department}　${widget.person.branchOffice ?? ""}",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              )
            ]),
            Row(children: [
              NameWidget().get(widget.person, 16),
              Center(
                child: CupertinoSwitch(
                  value: switchValue,
                  activeColor: CupertinoColors.activeOrange,
                  onChanged: (bool? value) async {
                    setState(() {
                      switchValue = value ?? false;
                    });

                    await FirebaseService.saveAuthority(widget.person.id,
                        switchValue ? widget.adminKey : widget.uesrKey);
                  },
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
