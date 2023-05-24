import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import 'package:baseX/base_x.dart';
import 'package:baseX/helper/scroll_behaviour.dart';
import 'package:baseX/model/ui/drawer_action.dart';
import 'package:baseX/model/ui/floating_action.dart';
import 'package:get/get.dart';

abstract class BaseXWidget<T extends BaseXController> extends GetWidget<T> {
  /// make [GetWidget.controller] to [c] as shortcut can be used on class who extended to [BaseXWidget]
  T get c => controller;

  String get routeName;

  bool get safeArea => true;

  bool get resizeToAvoidBottomInset => false;

  /// non-negative value that indicate how much should touch into appbar
  /// ```dart
  /// @override
  /// double get stackedAppBar => 15;
  /// ```
  double? get stackedAppBar => null;

  Color get backgroundColor => baseConstant.defaultBackgroundColor;

  Widget loader() => baseConstant.defaultLoadingWidget;

  Widget? appBar(BuildContext context);

  Widget? body(BuildContext context);

  Widget? overlayChild() => null;

  Widget envBar() => baseConstant.envBar;

  /// Override [floatingAction] with [FloatingAction] in your widget page with enable [hasFloatingButton] = true
  /// ```dart
  /// @override
  /// FloatingAction? get floatingAction => FloatingAction(
  ///   floatingActionButton: FloatingActionButton(
  ///   onPressed: () {
  ///     //TODO Add your onPressed code here!
  ///   },
  ///   backgroundColor: Colors.blue,
  ///   child: Icon(Icons.add),
  ///  ),
  /// );
  /// ```
  FloatingAction? get floatingAction => baseConstant.floatingAction;

  /// [hasFloatingButton] needed to set to true to displaying floatingaction button
  bool get hasFloatingButton => false;

  /// Override [drawerAction] with [DrawerAction] in your widget page with enable [hasDrawer] = true
  /// ```dart
  /// @override
  /// DrawerAction get drawerAction => DrawerAction(
  ///    drawerPosition: DrawerPosition.Right,
  ///    drawer: Drawer(
  ///      child: ListView(
  ///        padding: EdgeInsets.zero,
  ///        children: [
  ///          DrawerHeader(
  ///            decoration: BoxDecoration(
  ///              color: Colors.blue,
  ///            ),
  ///            child: Text('Drawer Header 2'),
  ///          ),
  ///          ListTile(
  ///            title: Text('Item 2'),
  ///            onTap: () {
  ///              // TODO update onTap
  ///            },
  ///          ),
  ///        ],
  ///      ),
  ///    ),
  /// );
  /// ```
  DrawerAction get drawerAction => baseConstant.drawerAction!;

  /// [hasDrawer] needed to set to true to displaying drawer
  bool get hasDrawer => false;

  @override
  Widget build(BuildContext context) {
    if (hasFloatingButton) {
      assert(!(baseConstant.floatingAction == null),
          'Please put your floating button to app constant \n');
    }

    if (hasDrawer) {
      assert(!(baseConstant.drawerAction == null), 'Please put your drawer to app constant \n');
    }

    return GetPlatform.isIOS
        ? _scaffoldChild(context)
        : WillPopScope(onWillPop: controller.onBack, child: _scaffoldChild(context));
  }

  Widget _contentBody(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            if (baseConstant.position == Position.top && baseConstant.appEnv == Environment.Staging)
              envBar(),
            if (stackedAppBar == null)
              Expanded(
                child: Column(
                  children: [
                    if (appBar(context) != null) appBar(context)!,
                    if (body(context) != null)
                      Expanded(
                        child: hideScrollShadow(body(context)!),
                      ),
                  ],
                ),
              ),
            if (stackedAppBar != null)
              Expanded(
                child: hideScrollShadow(
                  Stack(
                    children: [
                      if (appBar(context) != null) appBar(context)!,
                      Positioned.fill(
                        top: -stackedAppBar!,
                        left: 0,
                        right: 0,
                        child: Column(
                          children: [
                            if (appBar(context) != null)
                              Visibility(
                                visible: false,
                                maintainState: true,
                                maintainSize: true,
                                maintainAnimation: true,
                                child: appBar(context)!,
                              ),
                            if (body(context) != null) hideScrollShadow(body(context)!),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            if (baseConstant.position == Position.bottom &&
                baseConstant.appEnv == Environment.Staging)
              envBar(),
          ],
        ),
        if (overlayChild() != null) Positioned.fill(child: overlayChild()!),
        Obx(() => controller.isLoading.value ? loader() : SizedBox.shrink()),
        if (kDebugMode && routeName.isNotEmpty) _nameOfPageTag(),
      ],
    );
  }

  Widget _nameOfPageTag() {
    return Positioned(
      left: 5,
      top: 20.0 + (safeArea ? 0 : Get.mediaQuery.viewPadding.top),
      child: IgnorePointer(
        child: RotationTransition(
          turns: AlwaysStoppedAnimation(330 / 360),
          child: Container(
            padding: EdgeInsets.fromLTRB(5, 0, 5, 3),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              routeName.replaceAll('/', ''),
              style: TextStyle(
                color: Colors.red,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _scaffoldChild(BuildContext context) {
    bool isDrawerLeft = true;
    if (hasDrawer) {
      isDrawerLeft = drawerAction.drawerPosition == DrawerPosition.Left;
    }

    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      backgroundColor: backgroundColor,
      floatingActionButton: hasFloatingButton ? floatingAction?.floatingActionButton : null,
      floatingActionButtonLocation:
          hasFloatingButton ? floatingAction?.floatingActionButtonLocation : null,
      floatingActionButtonAnimator:
          hasFloatingButton ? floatingAction?.floatingActionButtonAnimator : null,
      drawer: hasDrawer && isDrawerLeft ? drawerAction.drawer : null,
      onDrawerChanged: hasDrawer && isDrawerLeft ? drawerAction.onDrawerChanged : null,
      drawerEnableOpenDragGesture:
          hasDrawer && isDrawerLeft ? drawerAction.drawerEnableOpenDragGesture : true,
      endDrawer: hasDrawer && !isDrawerLeft ? drawerAction.drawer : null,
      onEndDrawerChanged: hasDrawer && !isDrawerLeft ? drawerAction.onDrawerChanged : null,
      endDrawerEnableOpenDragGesture:
          hasDrawer && !isDrawerLeft ? drawerAction.drawerEnableOpenDragGesture : true,
      drawerDragStartBehavior:
          hasDrawer ? drawerAction.drawerDragStartBehavior : DragStartBehavior.start,
      drawerEdgeDragWidth: hasDrawer ? drawerAction.drawerEdgeDragWidth : null,
      drawerScrimColor: hasDrawer ? drawerAction.drawerScrimColor : null,
      body: GestureDetector(
        onHorizontalDragDown: (details) {
          controller.horizontalDown = details.localPosition.dx;
        },
        onHorizontalDragEnd: (details) async {
          if (controller.horizontalDown < 5) {
            bool needPop = await controller.onBack();
            if (needPop) Get.back();
          }
        },
        child: KeyboardDismissOnTap(
          dismissOnCapturedTaps: true,
          child: safeArea ? SafeArea(child: _contentBody(context)) : _contentBody(context),
        ),
      ),
    );
  }
}
