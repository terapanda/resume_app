import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class ProjectEditDialog extends StatefulWidget {
  const ProjectEditDialog({super.key});

  @override
  State<ProjectEditDialog> createState() => _ProjectEditDialogState();
}

class _ProjectEditDialogState extends State<ProjectEditDialog> {
  String summaryValue = '';
  String startDate = '';
  String endDate = '';
  int position = 1;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      backgroundColor: Color(0xFAFAFAFA),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      contentPadding: const EdgeInsets.all(10),
      title: Text("プロジェクト"),
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: TextFormField(
                  scrollPhysics: const NeverScrollableScrollPhysics(),
                  autocorrect: false,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: 'プロジェクトの概要',
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),
              SizedBox(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('参画期間'),
                      Text('ポジション'),
                    ]),
              ),
              SizedBox(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () => showDialog(
                            context: context,
                            builder: (_) {
                              return SelectDateWidget();
                            }),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: MediaQuery.of(context).size.height * 0.08,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(Icons.calendar_month),
                                  Text(startDate),
                                  Text('~'),
                                  Text(endDate),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          buttonPadding: EdgeInsets.all(10),
                          buttonDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          buttonWidth: MediaQuery.of(context).size.width * 0.3,
                          buttonHeight:
                              MediaQuery.of(context).size.height * 0.08,
                          itemHeight: 60,
                          items: const [
                            DropdownMenuItem(
                              value: 1,
                              child: Text('PM'),
                            ),
                            DropdownMenuItem(
                              value: 2,
                              child: Text('PL'),
                            ),
                            DropdownMenuItem(
                              value: 3,
                              child: Text('SE'),
                            ),
                            DropdownMenuItem(
                              value: 4,
                              child: Text('PG'),
                            ),
                            DropdownMenuItem(
                              value: 5,
                              child: Text('TESTER'),
                            ),
                          ],
                          onChanged: (int? value) {
                            setState(() {
                              position = value!;
                            });
                          },
                          value: position,
                        ),
                      ),
                    ]),
              ),
              SelectDevelopLanguage()
            ],
          ),
        ),
        SimpleDialogOption(
          onPressed: () => print("summaryValue"),
        )
      ],
    );
  }

  Widget SelectDateWidget() {
    return Container(
      child: SfDateRangePicker(
        backgroundColor: Color.fromARGB(248, 252, 250, 250),
        onSelectionChanged: _onSelectionChanged,
        selectionMode: DateRangePickerSelectionMode.range,
        initialSelectedRange: PickerDateRange(
            DateTime.now().subtract(const Duration(days: 4)),
            DateTime.now().add(const Duration(days: 3))),
      ),
    );
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        startDate = '${DateFormat('yyyy/MM').format(args.value.startDate)}';
        endDate =
            '${DateFormat('yyyy/MM').format(args.value.endDate ?? args.value.startDate)}';
      }
    });
  }
}

class DevLanguage {
  const DevLanguage(this.name, this.code);
  final String name;
  final int code;
}

class SelectDevelopLanguage extends StatefulWidget {
  const SelectDevelopLanguage({super.key});

  @override
  State createState() => SelectDevelopLanguageState();
}

class SelectDevelopLanguageState extends State<SelectDevelopLanguage> {
  final List<DevLanguage> _languages = <DevLanguage>[
    const DevLanguage('JAVA', 1),
    const DevLanguage('React', 2),
    const DevLanguage('python', 3),
    const DevLanguage('vue', 4),
  ];
  final List<int> _items = <int>[];
  Iterable<Widget> get languageWidgets {
    return _languages.map((DevLanguage devlanguage) {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: FilterChip(
          showCheckmark: false,
          selectedColor: Colors.amber,
          backgroundColor: Color.fromARGB(255, 184, 184, 183),
          checkmarkColor: Colors.black,
          label: Text(devlanguage.name),
          selected: _items.contains(devlanguage.code),
          onSelected: (bool value) {
            setState(() {
              if (value) {
                _items.add(devlanguage.code);
              } else {
                _items.removeWhere((int code) {
                  return code == devlanguage.code;
                });
              }
            });
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Wrap(
          children: languageWidgets.toList(),
        ),
        Text('洗濯中: ${_items.join(', ')}'),
      ],
    );
  }
}
