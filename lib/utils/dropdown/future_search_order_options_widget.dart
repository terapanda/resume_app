import 'package:flutter/material.dart';

import 'helper_classes.dart';
import 'prepare_widget.dart';

/// Widget displayed when there are order options in Future cases.
class FutureSearchOrderOptionsWidget extends StatelessWidget {
  /// See SearchChoices class.
  final Map<String, Map<String, dynamic>>? futureSearchOrderOptions;

  /// See SearchChoices class.
  final PointerThisPlease<int>? currentPage;

  final PointerThisPlease<bool?> orderAsc;

  final PointerThisPlease<String?> orderBy;

  final StateSetter setState;

  /// See SearchChoices class.
  final bool rightToLeft;

  final Function updateParentWithOptionalPop;

  FutureSearchOrderOptionsWidget({
    this.futureSearchOrderOptions,
    this.currentPage,
    required this.orderAsc,
    required this.orderBy,
    required this.setState,
    required this.rightToLeft,
    required this.updateParentWithOptionalPop,
  });

  @override
  Widget build(BuildContext context) {
    if (futureSearchOrderOptions == null || futureSearchOrderOptions!.isEmpty) {
      return (SizedBox.shrink());
    }
    Widget icon = Icon(
      Icons.sort,
      size: 17,
    );
    void Function() onPressed = () {
      showMenu(
          context: context,
          position: RelativeRect.fromLTRB(100, 30, 20, 100),
          items: futureSearchOrderOptions!
              .map<String, PopupMenuItem>((k, v) {
                return (MapEntry(
                    k,
                    PopupMenuItem(
                      child: SizedBox(
                        height: 30,
                        child: ElevatedButton(
                          onPressed: () {
                            currentPage?.value = 1;
                            if (k.isEmpty) {
                              orderAsc.value = true;
                              orderBy.value = null;
                            } else {
                              if (orderBy.value == k) {
                                orderAsc.value = (!(orderAsc.value ?? false));
                              } else {
                                orderAsc.value = futureSearchOrderOptions![k]
                                        ?["asc"] ??
                                    true;
                              }
                              setState(() {
                                orderBy.value = k;
                              });
                            }
                            Navigator.pop(context);
                          },
                          child: Row(
                            children: [
                              rightToLeft && k == orderBy.value
                                  ? orderArrowWidget
                                  : SizedBox.shrink(),
                              prepareWidget(
                                    v["icon"],
                                    parameter: orderAsc,
                                    updateParent: updateParentWithOptionalPop,
                                    context: context,
                                  ) ??
                                  Text(k),
                              !rightToLeft && k == orderBy.value
                                  ? orderArrowWidget
                                  : SizedBox.shrink()
                            ],
                          ),
                        ),
                      ),
                      value: k,
                    )));
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
                          Navigator.pop(context);
                          setState(() {
                            currentPage?.value = 1;
                            orderBy.value = null;
                            orderAsc.value = null;
                          });
                        },
                        child: Icon(
                          Icons.clear,
                          size: 17,
                        )),
                  ),
                )));
    };

    return SizedBox(
      height: 25,
      width: orderBy.value == null ? 48 : 70,
      child: (orderBy.value == null
          ? ElevatedButton(
              child: icon,
              onPressed: onPressed,
            )
          : ElevatedButton.icon(
              label: orderArrowWidget,
              icon: icon,
              onPressed: onPressed,
            )),
    );
  }

  Widget get orderArrowWidget {
    if (orderBy.value == null) {
      return (SizedBox.shrink());
    }
    return (Icon(
      orderAsc.value ?? true ? Icons.arrow_upward : Icons.arrow_downward,
      size: 17,
    ));
  }
}
