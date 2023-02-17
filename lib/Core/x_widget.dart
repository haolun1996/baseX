import 'dart:ffi';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

// T callPicker<T>(List model, Function(CountryDetail, int) selected,{ int initialIndex = 0}){

//     showCupertinoPicker(
//         model.map((e) {
//           return Center(child: Text('+ ${e.value}', style: bold(fontSize: header18)));
//         }).toList(), (index) {
//       storeIndex = index;
//       //c.selectedState.value = state[index];
//     },
//         itemExtend: 40,
//         index: initialIndex,
//         cancelButton: () {
//           Navigator.pop(Get.context);
//         },
//         doneButton: () {
//           selected(model[storeIndex], storeIndex);
//           Navigator.pop(Get.context);
//         });
//   }

Future<dynamic> showCupertinoPicker<T>(List<T> items,
// Function(int) onSelectedChangedFunction,
    {double itemExtend = 50,
    int index = 0,
    VoidCallback? done,
    VoidCallback? cancel,
    bool dismissible = false,
    Color? themeColor}) {
  return Get.bottomSheet(
      Container(
        height: 300,
        color: CupertinoColors.systemBackground,
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SizedBox(
            //   width: double.infinity,
            //   child: Align(
            //     alignment: Alignment.center,
            //     child: Container(
            //       height: 4,
            //       width: 30,
            //       decoration: BoxDecoration(
            //         color: Colors.grey[300],
            //         borderRadius: BorderRadius.circular(20),
            //       ),
            //     ),
            //   ),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  splashColor: Colors.transparent,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                          color: themeColor ?? CupertinoColors.activeBlue, fontSize: 16.0),
                    ),
                  ),
                  onTap: () {
                    cancel;
                    Get.back();
                  },
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    onTap: done,
                    child: Text(
                      'Done',
                      style: TextStyle(
                          color: themeColor ?? CupertinoColors.activeBlue,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                width: double.infinity,
                child: CupertinoPicker(
                  scrollController: FixedExtentScrollController(initialItem: index),
                  magnification: 1,
                  itemExtent: itemExtend,
                  looping: false,
                  onSelectedItemChanged: (index) {},
                  // onSelectedItemChanged: onSelectedChangedFunction,
                  children: List<Widget>.generate(items.length, (index) {
                    return Center(
                        child: Text(
                      '${items[index]}',
                    ));
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      backgroundColor: CupertinoColors.white);
}
