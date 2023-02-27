import 'package:flutter/material.dart';

class TitleValidatorOutputWidget extends StatelessWidget {
  const TitleValidatorOutputWidget(
      {Key? key,
      this.validResult,
      required this.dialogBox,
      required this.rightToLeft})
      : super(key: key);
  final String? validResult;
  final bool dialogBox;
  final bool rightToLeft;
  @override
  Widget build(BuildContext context) {
    return validResult == null || !dialogBox
        ? SizedBox.shrink()
        : Text(
            validResult!,
            textDirection: rightToLeft ? TextDirection.rtl : TextDirection.ltr,
            style: TextStyle(
              color: Colors.red,
              fontSize: 13,
            ),
          );
  }
}
