import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:resume_app/example_data/book_data.dart';
import 'package:resume_app/model/person.dart';
import 'package:resume_app/screens/create_pdf/file_name_widget.dart';
import 'package:resume_app/screens/create_pdf/preview_page.dart';

import 'package:resume_app/services/save_helper/save_helper.dart';
import 'package:resume_app/services/pdf_creator.dart';
import 'text_field_widget.dart';

class CreatePdfScreen extends StatefulWidget {
  final Person person;

  const CreatePdfScreen({Key? key, required this.person}) : super(key: key);

  @override
  State<CreatePdfScreen> createState() => _CreatePdfScreenState();
}

class _CreatePdfScreenState extends State<CreatePdfScreen> {
  final controllerMap = BookData.book1.map(
    (key, text) => MapEntry(key, TextEditingController(text: text)),
  );
  final fileNameKey = GlobalKey<FileNameWidgetState>();

  void _save() async {
    final pdf = await PdfCreator.create();
    final bytes = await pdf.save();
    final fileName = '${fileNameKey.currentState!.fileName}.pdf';
    await SaveHelper.save(
      bytes: bytes,
      fileName: fileName,
      platform: Theme.of(context).platform,
    );
  }

  void _preview() {
    Navigator.push(
      context,
      MaterialWithModalsPageRoute(
        builder: (context) =>
            PreviewPage('${fileNameKey.currentState!.fileName}.pdf'),
      ),
    );
  }

  @override
  void dispose() {
    for (final controller in controllerMap.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Creator'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(48),
        child: Column(
          children: [
            FileNameWidget(
                fileType: 'pdf',
                title: widget.person.initial,
                key: fileNameKey),
            ...controllerMap.entries.map(
              (e) => TextFieldWidget(label: e.key, controller: e.value),
            ),
          ],
        ),
      ),
      floatingActionButton: ButtonBar(
        children: [
          ElevatedButton.icon(
            icon: const Icon(Icons.download),
            label: const Text('Download'),
            onPressed: _save,
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.navigate_next),
            label: const Text('Preview'),
            style: ElevatedButton.styleFrom(primary: Colors.pink),
            onPressed: _preview,
          ),
        ],
      ),
    );
  }
}
