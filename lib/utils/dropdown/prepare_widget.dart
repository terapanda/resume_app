import 'package:search_choices/search_choices.dart';
import 'package:flutter/material.dart';

/// Function mainly called internally to transform an [object] (either a Widget,
/// a String or a Function returning a Widget or a String) to a Widget
/// If a Function is passed as [object], it can have as arguments either nothing
/// or:
/// * [parameter], [context], [updateParent]
/// * [parameter], [context]
/// * [parameter], [updateParent]
/// * [context], [updateParent]
/// * [parameter]
/// * [context]
/// * [updateParent]
Widget? prepareWidget(dynamic object,
    {dynamic parameter = const NotGiven(),
    Function? updateParent,
    BuildContext? context,
    Function? stringToWidgetFunction}) {
  if (object == null) {
    return (null);
  }
  if (object is Widget) {
    return (object);
  }
  if (object is String) {
    if (stringToWidgetFunction == null) {
      return (Text(
        object,
      ));
    } else {
      return (stringToWidgetFunction(object));
    }
  }
  if (object is Function) {
    dynamic objectResult = NotGiven();
    if (!(parameter is NotGiven) && context != null && updateParent != null) {
      try {
        objectResult = object(parameter, context, updateParent);
      } on NoSuchMethodError {
        objectResult = NotGiven();
      }
    }
    if (objectResult is NotGiven &&
        !(parameter is NotGiven) &&
        context != null) {
      try {
        objectResult = object(parameter, context);
      } on NoSuchMethodError {
        objectResult = NotGiven();
      }
    }
    if (objectResult is NotGiven &&
        !(parameter is NotGiven) &&
        updateParent != null) {
      try {
        objectResult = object(parameter, updateParent);
      } on NoSuchMethodError {
        objectResult = NotGiven();
      }
    }
    if (objectResult is NotGiven && context != null && updateParent != null) {
      try {
        objectResult = object(context, updateParent);
      } on NoSuchMethodError {
        objectResult = NotGiven();
      }
    }
    if (objectResult is NotGiven && !(parameter is NotGiven)) {
      try {
        objectResult = object(parameter);
      } on NoSuchMethodError {
        objectResult = NotGiven();
      }
    }
    if (objectResult is NotGiven && context != null) {
      try {
        objectResult = object(context);
      } on NoSuchMethodError {
        objectResult = NotGiven();
      }
    }
    if (objectResult is NotGiven && updateParent != null) {
      try {
        objectResult = object(updateParent);
      } on NoSuchMethodError {
        objectResult = NotGiven();
      }
    }
    if (objectResult is NotGiven) {
      try {
        objectResult = object();
      } on NoSuchMethodError {
        objectResult = Text(
          "Call failed",
          style: TextStyle(color: Colors.red),
        );
      }
    }
    return (prepareWidget(objectResult,
        stringToWidgetFunction: stringToWidgetFunction));
  }
  return (Text(
    "Unknown type: ${object.runtimeType.toString()}",
    style: TextStyle(color: Colors.red),
  ));
}
