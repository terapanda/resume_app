import 'package:flutter/material.dart';
import 'package:resume_app/screens/create_pdf/dialog_widget.dart';

class FileNameWidget extends StatefulWidget {
  final String fileType;
  final String title;

  const FileNameWidget({Key? key, required this.fileType, required this.title})
      : super(key: key);

  @override
  State<FileNameWidget> createState() => FileNameWidgetState();
}

class FileNameWidgetState extends State<FileNameWidget> {
  late String fileName;

  @override
  void initState() {
    super.initState();

    // 受け取ったデータを状態を管理する変数に格納
    fileName = '技術経歴書(${widget.title})';
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

  @override
  Widget build(BuildContext context) {
    return Row(
      textBaseline: TextBaseline.alphabetic,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.edit),
          onPressed: _showDialog,
        ),
        Text(
          fileName,
          style: const TextStyle(fontSize: 30),
        ),
        const SizedBox(width: 30),
        Text('.' + widget.fileType),
      ],
    );
  }
}
