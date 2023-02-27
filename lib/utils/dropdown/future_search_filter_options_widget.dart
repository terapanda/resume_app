import 'package:flutter/material.dart';

import 'helper_classes.dart';
import 'prepare_widget.dart';

/// Widget displayed when there are filter options in Future cases.
class FutureSearchFilterOptionsWidget extends StatelessWidget {
  /// See SearchChoices class.
  final Map<String, Map<String, Object>>? futureSearchFilterOptions;

  final PointerThisPlease<List<Tuple2<String, String>>?> filters;

  final Function updateParentWithOptionalPop;

  /// See SearchChoices class.
  final bool rightToLeft;

  /// See SearchChoices class.
  final PointerThisPlease<int>? currentPage;

  /// See SearchChoices class.
  final bool dialogBox;

  final StateSetter setState;

  FutureSearchFilterOptionsWidget({
    this.futureSearchFilterOptions,
    required this.filters,
    required this.updateParentWithOptionalPop,
    required this.rightToLeft,
    this.currentPage,
    required this.dialogBox,
    required this.setState,
  });

  @override
  Widget build(BuildContext context) {
    if (futureSearchFilterOptions == null ||
        futureSearchFilterOptions!.isEmpty) {
      return (SizedBox.shrink());
    }
    return SizedBox(
      height: 25,
      width: 48,
      child: (ElevatedButton(
        child: Icon(
          filters.value == null || filters.value!.isEmpty
              ? Icons.filter
              : filters.value!.length == 1
                  ? Icons.filter_1
                  : filters.value!.length == 2
                      ? Icons.filter_2
                      : filters.value!.length == 3
                          ? Icons.filter_3
                          : filters.value!.length == 4
                              ? Icons.filter_4
                              : filters.value!.length == 5
                                  ? Icons.filter_5
                                  : filters.value!.length == 6
                                      ? Icons.filter_6
                                      : filters.value!.length == 7
                                          ? Icons.filter_7
                                          : filters.value!.length == 8
                                              ? Icons.filter_8
                                              : filters.value!.length == 9
                                                  ? Icons.filter_9
                                                  : Icons.filter_9_plus_sharp,
          size: 17,
        ),
        onPressed: () {
          showMenu(
              context: context,
              position: RelativeRect.fromLTRB(100, 30, 20, 100),
              items: futureSearchFilterOptions!
                  .map<String, PopupMenuItem>((k, v) {
                    bool exclusive = v.containsKey("exclusive")
                        ? v["exclusive"] as bool
                        : false;
                    return (MapEntry(
                        k,
                        PopupMenuItem(
                            child: Column(
                          children: ((v["values"] ?? []) as List<dynamic>)
                              .map<Widget>((
                            value,
                          ) {
                            Widget inner;
                            String fk;
                            if (value is Map<String, dynamic>) {
                              assert((value).length == 1,
                                  "filter object not well built");
                              fk = (value).keys.first;
                              dynamic fv = (value).values.first ?? null;

                              inner = (prepareWidget(
                                    fv ?? fk,
                                    parameter: filters.value,
                                    updateParent: updateParentWithOptionalPop,
                                    context: context,
                                  ) ??
                                  fk) as Widget;
                            } else {
                              fk = value;
                              inner = prepareWidget(
                                    value,
                                    parameter: filters.value,
                                    updateParent: updateParentWithOptionalPop,
                                    context: context,
                                  ) ??
                                  value;
                            }
                            bool isSelected = false;
                            if (filters.value
                                    ?.any((Tuple2<String, String> element) {
                                  return (element.item1 == k &&
                                      element.item2 == fk);
                                }) ??
                                false) {
                              isSelected = true;
                            }
                            return (Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: (SizedBox(
                                height: 30,
                                child: (ElevatedButton(
                                  child: Row(
                                    children: [
                                      rightToLeft && isSelected
                                          ? Icon(Icons.check)
                                          : SizedBox.shrink(),
                                      inner,
                                      !rightToLeft && isSelected
                                          ? Icon(Icons.check)
                                          : SizedBox.shrink()
                                    ],
                                  ),
                                  onPressed: () {
                                    currentPage?.value = 1;
                                    if (filters.value == null) {
                                      filters.value = [];
                                    }
                                    bool isSelected = false;
                                    if (filters.value?.any(
                                            (Tuple2<String, String> element) {
                                          return (element.item1 == k &&
                                              element.item2 == fk);
                                        }) ??
                                        false) {
                                      isSelected = true;
                                    }
                                    if (isSelected) {
                                      filters.value!.removeWhere((element) =>
                                          element.item1 == k &&
                                          element.item2 == fk);
                                    } else {
                                      if (exclusive) {
                                        filters.value!.removeWhere(
                                            (element) => element.item1 == k);
                                      }
                                      filters.value!.add(Tuple2(k, fk));
                                    }
                                    if (dialogBox) {
                                      setState(() {});
                                    }
                                    Navigator.pop(context);
                                    if (!dialogBox) {
                                      setState(() {});
                                    }
                                  },
                                )),
                              )),
                            ));
                          }).toList()
                            ..insert(
                              0,
                              PopupMenuItem(
                                child: SizedBox(
                                  height: 30,
                                  child: prepareWidget(
                                        v["icon"] ?? k,
                                        parameter: filters.value,
                                        updateParent:
                                            updateParentWithOptionalPop,
                                        context: context,
                                      ) ??
                                      Text(k),
                                ),
                              ),
                            ),
                        ))));
                  })
                  .values
                  .toList()
                ..insert(
                    0,
                    PopupMenuItem(
                      child: SizedBox(
                        height: 30,
                        child: ElevatedButton(
                            onPressed: () {
                              currentPage?.value = 1;
                              filters.value?.clear();
                              Navigator.pop(context);
                              if (!dialogBox) {
                                setState(() {});
                              }
                            },
                            child: Icon(
                              Icons.clear,
                              size: 17,
                            )),
                      ),
                    )));
        },
      )),
    );
  }
}
