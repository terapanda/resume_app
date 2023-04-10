import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:printing/printing.dart';
import 'package:resume_app/model/person.dart';
import 'package:resume_app/model/person_converter.dart';
import 'package:resume_app/screens/create_pdf/dialog_widget.dart';

import 'package:resume_app/services/save_helper/save_helper.dart';
import 'package:resume_app/services/pdf_creator.dart';
import 'package:resume_app/utils/hex_color.dart';

class PreviewPage extends StatefulWidget {
  final Person person;

  const PreviewPage({
    Key? key,
    required this.person,
  }) : super(key: key);

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  late String fileName;
  late bool showName;
  late bool showContractType;
  late Person person;

  @override
  void initState() {
    super.initState();

    // 受け取ったデータを状態を管理する変数に格納
    fileName = '技術経歴書(${widget.person.initial})';
    person = widget.person;
    showName = false;
    showContractType = true;
  }

  @override
  Widget build(BuildContext context) {
    PdfCreator pdfCreator = PdfCreator();
    return Scaffold(
      appBar: AppBar(
        title: _file_name_widget(),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (context) {
              return [
                makePopupMenuItem('name', '名前 → イニシャル', 'イニシャル → 名前', showName,
                    FontAwesomeIcons.arrowsUpDownLeftRight),
                makePopupMenuItem('contractType', '契約形態を非表示', '契約形態を表示',
                    showContractType, FontAwesomeIcons.arrowsUpDownLeftRight),
              ];
            },
            onSelected: (String value) {
              if (value == 'name') {
                setState(() {
                  showName = !showName;
                });
              }
              if (value == 'contractType') {
                setState(() {
                  showContractType = !showContractType;
                });
              }
            },
          )
        ],
      ),
      body: PdfPreview(
        maxPageWidth: 600,
        allowPrinting: true,
        allowSharing: false,
        canChangeOrientation: false,
        canChangePageFormat: false,
        canDebug: false,
        loadingWidget: const LinearProgressIndicator(),
        build: (format) async {
          widget.person.jobCareerList =
              await PersonConverter.fetchJobCareerList(widget.person.id);
          final pdf =
              await pdfCreator.create(person, showName, showContractType);
          return await pdf.save();
        },
        actions: [
          PdfPreviewAction(
            icon: const Icon(Icons.download),
            onPressed: (context, build, format) async {
              await SaveHelper.save(
                bytes: await build(format),
                fileName: fileName + '.pdf',
                platform: Theme.of(context).platform,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _file_name_widget() {
    return Row(
      textBaseline: TextBaseline.alphabetic,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.edit),
          onPressed: _showDialog,
        ),
        Text(
          fileName,
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(width: 10),
        const Text('.pdf'),
      ],
    );
  }

  void _showDialog() async {
    final input = await showDialog<String?>(
      context: context,
      builder: (context) {
        return DialogWidget(initialInput: fileName);
      },
    );
    if (input != null) {
      setState(() => fileName = input);
    }
  }

  PopupMenuItem<String> makePopupMenuItem(
      String key, String text1, String text2, bool isShow, IconData icon) {
    return PopupMenuItem(
      value: key,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 16,
            color: HexColor(),
          ),
          Padding(padding: EdgeInsets.only(right: 16)),
          isShow
              ? Text(
                  text1.toUpperCase(),
                  style: TextStyle(fontSize: 14),
                )
              : Text(text2.toUpperCase(), style: TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
