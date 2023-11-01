import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:baseX/Core/x_declaration.dart';
import 'package:baseX/helper/index.dart';
import 'package:baseX/model/index.dart';

// ignore: must_be_immutable
class XPicker<T extends XPickerItem> extends StatefulWidget {
  XPicker({
    required this.items,
    required this.selectedItem,
    super.key,
    this.itemExtent = 50,
    this.isDismissible = true,
    this.contentPadding = const EdgeInsets.fromLTRB(30, 0, 30, 0),
    this.themeColor,
    this.onDone,
    this.onCancel,
  }) : assert(itemExtent > 0);

  final List<T> items;
  final double itemExtent;
  T selectedItem;
  final bool isDismissible;
  final Color? themeColor;
  final OnDoneCallBack? onDone;
  final VoidCallback? onCancel;
  final EdgeInsets contentPadding;

  @override
  State<StatefulWidget> createState() => _XPickerState<T>();
}

class _XPickerState<T> extends State<XPicker> {
  int initialIndex = 0;

  @override
  void initState() {
    super.initState();

    int index = widget.items.indexOf(widget.selectedItem);
    if (index == -1) {
      initialIndex = 0;
      widget.selectedItem = widget.items[initialIndex];
    } else {
      initialIndex = index;
    }
  }

  void _handleSelectedItemChanged(int index) {
    widget.selectedItem = widget.items[index];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      color: CupertinoColors.systemBackground,
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                height: 4,
                width: 30,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
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
                        color: widget.themeColor ?? CupertinoColors.activeBlue, fontSize: 16.0),
                  ),
                ),
                onTap: () {
                  widget.onCancel;
                  Get.back();
                },
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: InkWell(
                  splashColor: Colors.transparent,
                  onTap: (() {
                    if (widget.onDone != null) {
                      widget.onDone!(widget.selectedItem);
                    }
                    Get.back();
                  }),
                  child: Text(
                    'Done',
                    style: TextStyle(
                        color: widget.themeColor ?? CupertinoColors.activeBlue,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: widget.contentPadding,
              child: hideScrollShadow(
                CupertinoPicker(
                  scrollController: FixedExtentScrollController(initialItem: initialIndex),
                  magnification: 1,
                  itemExtent: widget.itemExtent,
                  looping: false,
                  onSelectedItemChanged: _handleSelectedItemChanged,
                  children: List<Widget>.generate(widget.items.length, (index) {
                    return Center(
                        child: Text(
                      widget.items[index].value,
                    ));
                  }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// [T] is a model class OR String type
/// ```dart
///   List<T> items = [...];
///   T selectedPicker;
///   T? result = await showXPicker<T?>(
///     items,
///     selectedPicker,
///   );
///
///   if (result != null) {
///     selectedPicker = result;
///   }
/// ```
Future<T?> showXPicker<T extends XPickerItem>(
  List<T> items,
  T selectedItem, {
  double itemExtend = 50,
  OnDoneCallBack? onDone,
  VoidCallback? onCancel,
  bool isDismissible = true,
  Color? themeColor,
  EdgeInsets contentPadding = const EdgeInsets.fromLTRB(30, 0, 30, 0),
}) {
  return Get.bottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    elevation: 3,
    backgroundColor: CupertinoColors.white,
    isDismissible: isDismissible,
    XPicker<T>(
      items: items,
      contentPadding: contentPadding,
      selectedItem: selectedItem,
      onDone: (item) {
        if (onDone != null) {
          onDone(item);
        }
      },
      onCancel: onCancel,
    ),
  );
}
