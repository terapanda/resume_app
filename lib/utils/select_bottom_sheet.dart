import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void selectBottomSheet(BuildContext context, selectChildren,
    onSelectedItemChanged, resultAction, rejectAction) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height / 3,
          child: Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: TextButton(
                        child: const Text('キャンセル',
                            style: TextStyle(color: Colors.grey, fontSize: 16)),
                        onPressed: rejectAction,
                      ),
                    ),
                    TextButton(
                      child: const Text('完了',
                          style: TextStyle(color: Colors.blue, fontSize: 16)),
                      onPressed: resultAction,
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 4,
                child: CupertinoPicker(
                  itemExtent: 40,
                  children: selectChildren,
                  onSelectedItemChanged: onSelectedItemChanged,
                ),
              )
            ],
          ),
        );
      });
}
