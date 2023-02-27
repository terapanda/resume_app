import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'size_config.dart';
import 'package:resume_app/provider/user_state.dart';

class InputForm extends ConsumerWidget {
  InputForm({
    Key? key,
    this.inputType,
    this.hintText,
    this.isHalf = false,
    this.width = 100,
    this.maxLength,
    this.initialValue,
    this.onChanged,
    this.onSaved,
  }) : super(key: key);

  final String? inputType;
  final String? hintText;
  final bool isHalf;
  final double width;
  final int? maxLength;
  final initialValue;

  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;

  final myController = TextEditingController();

  _inputType() {
    switch (inputType) {
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

  _width(context) {
    if (width == 100) {
      return MediaQuery.of(context).size.width * 0.9;
    } else {
      return width;
    }
  }

  Widget _inputForm(BuildContext context) {
    myController.text = initialValue;
    final inputForm = Container(
      padding: const EdgeInsets.all(3),
      width: _width(context),
      // height: MediaQuery.of(context).size.height * 0.06,
      child: TextFormField(
        onChanged: onChanged ?? (value) {},
        onSaved: onSaved,
        controller: myController,
        keyboardType: _inputType(),
        decoration: InputDecoration(
            labelStyle: TextStyle(color: Colors.black54),
            labelText: hintText,
            border: const OutlineInputBorder(),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 2))),
      ),
    );
    return inputForm;
  }

  Widget _inputFormWidthHalf(BuildContext context) {
    myController.text = initialValue;
    final inputFormWidthHalf = Container(
      padding: const EdgeInsets.all(3),
      width: MediaQuery.of(context).size.width * 0.448,
      // height: MediaQuery.of(context).size.height * 0.08,
      child: TextFormField(
        onChanged: onChanged ?? (value) {},
        onSaved: onSaved,
        controller: myController,
        keyboardType: _inputType(),
        decoration: InputDecoration(
          labelStyle: TextStyle(color: Colors.black54),
          labelText: hintText,
          border: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2),
          ),
        ),
      ),
    );
    return inputFormWidthHalf;
  }

  Widget _inputFormBirthDay(BuildContext context) {
    myController.text = initialValue;
    SizeConfig().init(context);
    final inputFormBirthDay = Container(
      padding: const EdgeInsets.all(3),
      width: MediaQuery.of(context).size.width * 0.448,
      // height: MediaQuery.of(context).size.height * 0.08,
      child: TextFormField(
        onChanged: onChanged ?? (value) {},
        inputFormatters: [LengthLimitingTextInputFormatter(8)],
        keyboardType: TextInputType.number,
        controller: myController,
        decoration: InputDecoration(
            labelStyle: TextStyle(color: Colors.black54),
            labelText: hintText,
            border: const OutlineInputBorder(),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 2))),
      ),
    );
    return inputFormBirthDay;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (isHalf) {
      return _inputFormWidthHalf(context);
    } else if (inputType == 'birth') {
      return _inputFormBirthDay(context);
    }
    return _inputForm(context);
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

// class InputForm extends StatefulWidget {
//   const InputForm({
//     this.inputType,
//     this.hintText,
//     this.isHalf = false,
//     this.width = 100,
//     this.maxLength,
//     this.initialValue,
//   }) : assert(isHalf != null);
//   final String? inputType;
//   final String? hintText;
//   final bool isHalf;
//   final double width;
//   final int? maxLength;
//   final initialValue;

//   @override
//   State<InputForm> createState() => _InputFormState();
// }

// class _InputFormState extends State<InputForm> {
//   final myController = TextEditingController();

//   String _enteredComment = '';
//   @override
//   void dispose() {
//     myController.dispose();
//     super.dispose();
//   }

//   _inputType() {
//     switch (widget.inputType) {
//       case 'int':
//         return TextInputType.number;
//       case 'phone':
//         return TextInputType.phone;
//       case 'email':
//         return TextInputType.emailAddress;
//       case 'url':
//         return TextInputType.url;
//       case 'name':
//         return TextInputType.name;
//       default:
//         return TextInputType.text;
//     }
//   }

//   _width() {
//     if (widget.width == 100) {
//       return MediaQuery.of(context).size.width * 0.9;
//     } else {
//       return widget.width;
//     }
//   }

//   Widget _inputForm() {
//     SizeConfig().init(context);
//     final inputForm = Container(
//       padding: const EdgeInsets.all(3),
//       width: _width(),
//       height: MediaQuery.of(context).size.height * 0.06,
//       child: TextFormField(
//         initialValue: widget.initialValue,
//         // controller: myController,
//         keyboardType: _inputType(),
//         decoration: InputDecoration(
//             labelStyle: TextStyle(color: Colors.black54),
//             labelText: widget.hintText,
//             border: const OutlineInputBorder(),
//             focusedBorder: const OutlineInputBorder(
//                 borderSide: BorderSide(color: Colors.red, width: 2))),
//       ),
//     );
//     return inputForm;
//   }

//   Widget _inputFormWidthHalf() {
//     SizeConfig().init(context);
//     final inputFormWidthHalf = Container(
//       padding: const EdgeInsets.all(3),
//       width: MediaQuery.of(context).size.width * 0.448,
//       height: MediaQuery.of(context).size.height * 0.06,
//       child: TextFormField(
//         initialValue: widget.initialValue,
//         // controller: myController,
//         keyboardType: _inputType(),
//         decoration: InputDecoration(
//             labelStyle: TextStyle(color: Colors.black54),
//             labelText: widget.hintText,
//             border: const OutlineInputBorder(),
//             focusedBorder: const OutlineInputBorder(
//                 borderSide: BorderSide(color: Colors.red, width: 2))),
//       ),
//     );
//     return inputFormWidthHalf;
//   }

//   Widget _inputFormBirthDay() {
//     SizeConfig().init(context);
//     final inputFormBirthDay = Container(
//       padding: const EdgeInsets.all(3),
//       width: MediaQuery.of(context).size.width * 0.448,
//       height: MediaQuery.of(context).size.height * 0.06,
//       child: TextFormField(
//         initialValue: widget.initialValue,
//         inputFormatters: [LengthLimitingTextInputFormatter(8)],
//         keyboardType: TextInputType.number,
//         // controller: myController,
//         decoration: InputDecoration(
//             labelStyle: TextStyle(color: Colors.black54),
//             labelText: widget.hintText,
//             border: const OutlineInputBorder(),
//             focusedBorder: const OutlineInputBorder(
//                 borderSide: BorderSide(color: Colors.red, width: 2))),
//       ),
//     );
//     return inputFormBirthDay;
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (widget.isHalf) {
//       return _inputFormWidthHalf();
//     } else if (widget.inputType == 'birth') {
//       return _inputFormBirthDay();
//     }
//     return _inputForm();
//     // switch (widget.inputType) {
//     //   case 'int':
//     //     return _inputNumeric();
//     //   case 'phone':
//     //     return _inputPhone();
//     //   case 'email':
//     //     return _inputEmail();
//     //   default:
//     //     return _inputString();
//     // }
//   }
// }
