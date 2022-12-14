import 'package:flutter/material.dart';
import 'size_config.dart';

class InputForm extends StatefulWidget {
  const InputForm({
    this.inputType,
    this.hintText,
    this.isHalf = false,
    this.width = 100,
  }) : assert(isHalf != null);
  final String? inputType;
  final String? hintText;
  final bool isHalf;
  final double width;

  @override
  State<InputForm> createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  final myController = TextEditingController();

  String _enteredComment = '';
  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  _inputType() {
    switch (widget.inputType) {
      case 'int':
        return TextInputType.number;
      case 'phone':
        return TextInputType.phone;
      case 'email':
        return TextInputType.emailAddress;
      case 'url':
        return TextInputType.url;
      case 'name':
        return TextInputType.name;
      default:
        return TextInputType.text;
    }
  }

  _width() {
    if (widget.width == 100) {
      return MediaQuery.of(context).size.width * 0.9;
    } else {
      return widget.width;
    }
  }

  Widget _inputForm() {
    SizeConfig().init(context);
    final inputForm = Container(
      padding: const EdgeInsets.all(3),
      width: _width(),
      height: MediaQuery.of(context).size.height * 0.06,
      child: TextFormField(
        controller: myController,
        keyboardType: _inputType(),
        decoration: InputDecoration(
            labelStyle: TextStyle(color: Colors.black54),
            labelText: widget.hintText,
            border: const OutlineInputBorder(),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 2))),
      ),
    );
    return inputForm;
  }

  Widget _inputFormWidthHalf() {
    SizeConfig().init(context);
    final inputFormWidthHalf = Container(
      padding: const EdgeInsets.all(3),
      width: MediaQuery.of(context).size.width * 0.448,
      height: MediaQuery.of(context).size.height * 0.06,
      child: TextFormField(
        controller: myController,
        keyboardType: _inputType(),
        decoration: InputDecoration(
            labelStyle: TextStyle(color: Colors.black54),
            labelText: widget.hintText,
            border: const OutlineInputBorder(),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 2))),
      ),
    );
    return inputFormWidthHalf;
  }

  Widget _inputFormBirthDay() {
    SizeConfig().init(context);
    final inputFormBirthDay = Container(
      padding: const EdgeInsets.all(3),
      width: MediaQuery.of(context).size.width * 0.448,
      height: MediaQuery.of(context).size.height * 0.06,
      child: TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelStyle: TextStyle(color: Colors.black54),
          labelText: '2000/04/01',
          border: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 2)),
        ),
      ),
    );
    return inputFormBirthDay;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isHalf) {
      return _inputFormWidthHalf();
    } else if (widget.inputType == 'birth') {
      return _inputFormBirthDay();
    }
    return _inputForm();
    // switch (widget.inputType) {
    //   case 'int':
    //     return _inputNumeric();
    //   case 'phone':
    //     return _inputPhone();
    //   case 'email':
    //     return _inputEmail();
    //   default:
    //     return _inputString();
    // }
  }
}
