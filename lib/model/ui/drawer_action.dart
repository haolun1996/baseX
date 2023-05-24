import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

enum DrawerPosition { Left, Right }

class DrawerAction {
  final Drawer drawer;
  final DrawerPosition drawerPosition;
  final DragStartBehavior drawerDragStartBehavior;
  final double? drawerEdgeDragWidth;
  final Color? drawerScrimColor;

  /// Use for both [Scaffold.onDrawerChanged] OR [Scaffold.onEndDrawerChanged]
  final DrawerCallback? onDrawerChanged;

  /// Use for both [Scaffold.drawerEnableOpenDragGesture] OR [Scaffold.endDrawerEnableOpenDragGesture]
  final bool drawerEnableOpenDragGesture;

  DrawerAction({
    required this.drawer,
    this.drawerPosition = DrawerPosition.Left,
    this.drawerDragStartBehavior = DragStartBehavior.start,
    this.drawerEdgeDragWidth,
    this.drawerScrimColor,
    this.onDrawerChanged,
    this.drawerEnableOpenDragGesture = true,
  });
}
