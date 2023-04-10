import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:intl/intl.dart';
import 'package:resume_app/model/person.dart';
import 'package:resume_app/utils/calc_years_of_skill.dart';

const PdfColor green = PdfColor.fromInt(0xff9ce5d0);
const PdfColor lightGreen = PdfColor.fromInt(0xffcdf1e7);

// var logger = Logger(
//   printer: PrettyPrinter(),
// );

class PdfCreator {
  Future<pw.Document> create(
      Person person, bool showName, bool showContractType) async {
    // Googleフォントを取得して埋め込むことも可能
    final pw.Font regular = await PdfGoogleFonts.mPLUS1pRegular();
    final pw.Font bold = await PdfGoogleFonts.mPLUS1pBold();

    final pdf = pw.Document(author: 'Me');
    var now = DateTime.now();

    final logo = pw.MemoryImage(
      (await rootBundle.load('images/sun_logo.png')).buffer.asUint8List(),
    );

    late List<String> basicTableHeader = ['エンジニア名', '年齢', '性別', '最寄駅'];
    late List<String> basicTableBody = [
      showName ? person.name : person.initial,
      person.age.toString(),
      person.sex,
      person.station
    ];

    late List<String> technicalTableHeader = [
      'No.',
      '期間',
      'システム名及び作業内容',
      '役割・規模',
      'テクニカルスキル／開発環境等'
    ];

    if (showContractType) {
      basicTableHeader.add('弊社契約形態');
      basicTableBody.add(person.contractType!);
    }

    late List<List<String>> technicalTableBody = [];
    if (person.jobCareerList != null && person.jobCareerList!.isNotEmpty) {
      for (var i = 0; i < person.jobCareerList!.length; i++) {
        late List<String> technicalTableBodyRecord = [];

        technicalTableBodyRecord.add(
          (i + 1).toString(),
        );

        technicalTableBodyRecord.add(
            '${DateFormat('yyyy/MM/dd').format(person.jobCareerList![i].careerPeriodFrom)}\n~\n${DateFormat('yyyy/MM/dd').format(person.jobCareerList![i].careerPeriodTo)}');

        technicalTableBodyRecord.add(
            '【システム名】\n${person.jobCareerList![i].content}\n【担当フェーズ】\n${person.jobCareerList![i].phase.toString().replaceAll('[', "").replaceAll(']', "")}');

        technicalTableBodyRecord.add(person.jobCareerList![i].role);

        late String technicals = "";

        if (person.jobCareerList![i].usedTechnicalOSList != null &&
            person.jobCareerList![i].usedTechnicalOSList!.isNotEmpty) {
          technicals += "【OS】\n";
          for (var j = 0;
              j < person.jobCareerList![i].usedTechnicalOSList!.length;
              j++) {
            technicals += "・";
            technicals +=
                person.jobCareerList![i].usedTechnicalOSList![j].osName;
            technicals += "\n";
          }
        }

        if (person.jobCareerList![i].usedTechnicalDBList != null &&
            person.jobCareerList![i].usedTechnicalDBList!.isNotEmpty) {
          technicals += "【DB】\n";
          for (var j = 0;
              j < person.jobCareerList![i].usedTechnicalDBList!.length;
              j++) {
            technicals += "・";
            technicals +=
                person.jobCareerList![i].usedTechnicalDBList![j].dbName;
            technicals += "\n";
          }
        }

        if (person.jobCareerList![i].usedTechnicalSkillList != null &&
            person.jobCareerList![i].usedTechnicalSkillList!.isNotEmpty) {
          technicals += "【言語】\n";
          for (var j = 0;
              j < person.jobCareerList![i].usedTechnicalSkillList!.length;
              j++) {
            technicals += "・";
            technicals +=
                person.jobCareerList![i].usedTechnicalSkillList![j].skillName;
            technicals += "\n";
          }
        }
        technicalTableBodyRecord.add(technicals);

        technicalTableBody.add(technicalTableBodyRecord);
      }
    }

    // 本文
    final content = pw.MultiPage(
      pageTheme: pw.PageTheme(
        theme: pw.ThemeData.withFont(
          base: regular,
          bold: bold,
        ),
        pageFormat: PdfPageFormat.a4,
        orientation: pw.PageOrientation.portrait,
      ),
      header: (context) {
        return pw.Padding(
          padding: const pw.EdgeInsets.only(bottom: 30),
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Image(logo, width: 100),
              pw.Text("技　術　経　歴　書",
                  style: pw.Theme.of(context).header0.copyWith(fontSize: 24)),
              pw.Text(DateFormat('yyyy/MM/dd').format(DateTime.now())),
            ],
          ),
        );
      },
      build: (context) {
        return [
          pw.Header(
            level: 0,
            textStyle: pw.Theme.of(context).header0,
            child: pw.Text(
              "■基本情報",
              style: pw.Theme.of(context).header3,
            ),
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Expanded(
                  flex: 1, // 1 要素分の横幅
                  child: pw.Padding(
                      padding: const pw.EdgeInsets.only(left: 10),
                      child: pw.SizedBox(
                          child: pw.Table.fromTextArray(
                        context: context,
                        data: <List>[
                          basicTableHeader,
                          basicTableBody,
                        ],
                        cellAlignment: pw.Alignment.center,
                        // cellAlignments: {0: pw.Alignment.center},
                      )))),
              pw.Padding(
                  padding: const pw.EdgeInsets.only(left: 10),
                  child: pw.SizedBox(
                      width: 90,
                      child: pw.Table.fromTextArray(
                        context: context,
                        data: <List>[
                          ['参画可能日'],
                          ['1234年 56月中旬'],
                        ],
                        cellAlignment: pw.Alignment.center,
                        // cellAlignments: {0: pw.Alignment.center},
                      ))),
            ],
          ),
          pw.SizedBox(height: 10),
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Expanded(
                flex: 1, // 1 要素分の横幅
                child: pw.Padding(
                    padding: const pw.EdgeInsets.only(top: 4),
                    child: pw.Container(
                      margin: const pw.EdgeInsets.only(left: 10),
                      alignment: pw.Alignment.topLeft,
                      child: pw.Column(children: <pw.Widget>[
                        pw.Container(
                            width: double.infinity,
                            child: pw.Text("概要（得意分野、自己PRなど）",
                                textAlign: pw.TextAlign.left,
                                style: pw.TextStyle(
                                    fontSize: 14,
                                    fontWeight: pw.FontWeight.bold))),
                        pw.Container(
                            width: double.infinity,
                            decoration: pw.BoxDecoration(
                              border: pw.Border.all(),
                            ),
                            padding: const pw.EdgeInsets.all(8),
                            child: pw.Text(person.description!,
                                maxLines: 20,
                                textAlign: pw.TextAlign.left,
                                style: const pw.TextStyle(fontSize: 10)))
                      ]),
                    )),
              ),
              pw.Container(
                  alignment: pw.Alignment.topCenter,
                  child: pw.Padding(
                      padding: const pw.EdgeInsets.only(left: 10),
                      child: pw.SizedBox(
                          width: 200,
                          child: pw.Column(children: <pw.Widget>[
                            pw.Table.fromTextArray(
                              border: null,
                              headers: [
                                person.technicalSkillList!.isNotEmpty
                                    ? '主要言語'
                                    : ""
                              ],
                              data: List<List<dynamic>>.generate(
                                person.technicalSkillList != null
                                    ? person.technicalSkillList!.length
                                    : 0,
                                (index) => <dynamic>[
                                  person.technicalSkillList![index].skillName,
                                  CalcMonth.calcMonth(
                                      person.technicalSkillList![index].month),
                                ],
                              ),
                              cellStyle: const pw.TextStyle(
                                fontSize: 10,
                              ),
                              headerStyle: pw.TextStyle(
                                fontSize: 12,
                                fontWeight: pw.FontWeight.bold,
                              ),
                              rowDecoration: const pw.BoxDecoration(
                                border: pw.Border(
                                  top: pw.BorderSide(
                                    width: .5,
                                  ),
                                ),
                              ),
                              cellAlignment: pw.Alignment.centerRight,
                              cellAlignments: {0: pw.Alignment.centerLeft},
                            ),
                            pw.Table.fromTextArray(
                              border: null,
                              headers: [
                                person.technicalOSList!.isNotEmpty ? '主要OS' : ""
                              ],
                              data: List<List<dynamic>>.generate(
                                person.technicalOSList != null
                                    ? person.technicalOSList!.length
                                    : 0,
                                (index) => <dynamic>[
                                  person.technicalOSList![index].osName,
                                  CalcMonth.calcMonth(
                                      person.technicalOSList![index].month),
                                ],
                              ),
                              cellStyle: const pw.TextStyle(
                                fontSize: 10,
                              ),
                              headerStyle: pw.TextStyle(
                                fontSize: 12,
                                fontWeight: pw.FontWeight.bold,
                              ),
                              rowDecoration: const pw.BoxDecoration(
                                border: pw.Border(
                                  top: pw.BorderSide(
                                    width: .5,
                                  ),
                                ),
                              ),
                              cellAlignment: pw.Alignment.centerRight,
                              cellAlignments: {0: pw.Alignment.centerLeft},
                            ),
                            pw.Table.fromTextArray(
                              border: null,
                              headers: [
                                person.technicalDBList!.isNotEmpty ? '主要DB' : ""
                              ],
                              data: List<List<dynamic>>.generate(
                                person.technicalDBList != null
                                    ? person.technicalDBList!.length
                                    : 0,
                                (index) => <dynamic>[
                                  person.technicalDBList![index].dbName,
                                  CalcMonth.calcMonth(
                                      person.technicalDBList![index].month),
                                ],
                              ),
                              cellStyle: const pw.TextStyle(
                                fontSize: 10,
                              ),
                              headerStyle: pw.TextStyle(
                                fontSize: 12,
                                fontWeight: pw.FontWeight.bold,
                              ),
                              rowDecoration: const pw.BoxDecoration(
                                border: pw.Border(
                                  top: pw.BorderSide(
                                    width: .5,
                                  ),
                                ),
                              ),
                              cellAlignment: pw.Alignment.centerRight,
                              cellAlignments: {0: pw.Alignment.centerLeft},
                            )
                          ])))),
            ],
          ),
          pw.SizedBox(height: 20),
          pw.Header(
            level: 0,
            textStyle: pw.Theme.of(context).header0,
            child: pw.Text(
              "■技術概要",
              style: pw.Theme.of(context).header3,
            ),
          ),
          pw.Padding(
              padding: const pw.EdgeInsets.only(left: 10),
              child: pw.SizedBox(
                  child: pw.Table.fromTextArray(
                      context: context,
                      headers: List<String>.generate(
                        technicalTableHeader.length,
                        (col) => technicalTableHeader[col],
                      ),
                      cellAlignment: pw.Alignment.topLeft,
                      data: technicalTableBody)))
        ];
      },
    );

    // pdf.addPage(cover);
    pdf.addPage(content);
    return pdf;
  }
}
