import 'package:baseX/base_x.dart';
import 'package:baseX/helper/scroll_behaviour.dart';
import 'package:baseX/x_widget/x_keyboard_dismiss_on_tap.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

abstract class BaseXWidget<T extends BaseXController> extends GetWidget<T> {
  /// make [GetWidget.controller] to [c] as shortcut can be used on class who extended to [BaseXWidget]
  T get c => controller;

  String get routeName;

  bool get topSafeArea => false;
  bool get bottomSafeArea => false;

  bool get resizeToAvoidBottomInset => false;

  /// non-negative value that indicate how much should touch into appbar
  /// ```dart
  /// @override
  /// double get stackedAppBar => 15;
  /// ```
  double? get stackedAppBar => null;

  bool get isReversedStackAppBar => false;

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
  DrawerAction? get drawerAction => baseConstant.drawerAction;

  @override
  Widget build(BuildContext context) {
    if (c.hasFloatingButton.value) {
      assert(!(baseConstant.floatingAction == null && floatingAction == null),
          'Please put your floating button to either app constant or page \n');
    }

    if (c.hasDrawer.value) {
      assert(!(baseConstant.drawerAction == null && drawerAction == null),
          'Please put your drawer to app constant \n');
    }

    return GetPlatform.isIOS
        ? _scaffoldChild(context)
        : WillPopScope(
            onWillPop: controller.onBack, child: _scaffoldChild(context));
  }

  Widget _contentBody(BuildContext context) {
    bool isPage = true;

    if (c.page != null &&
        (c.page.runtimeType is int ||
            c.page.runtimeType is double ||
            c.page.runtimeType is String ||
            c.page.runtimeType is bool)) {
      assert(
          !(c.page.runtimeType is int ||
              c.page.runtimeType is double ||
              c.page.runtimeType is String ||
              c.page.runtimeType is bool),
          'Please do not re-assign new value to c.page | page in controller \n');
    } else {
      if (c.page != null) {
        isPage = (c.page as BaseXWidget).routeName == routeName;
      }
    }
    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            if (baseConstant.position == Position.top &&
                baseConstant.appEnv == Environment.Staging &&
                isPage)
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
                    children: isReversedStackAppBar
                        ? (stackedChildren(context).reversed.toList())
                        : stackedChildren(context),
                  ),
                ),
              ),
            if (baseConstant.position == Position.bottom &&
                baseConstant.appEnv == Environment.Staging &&
                isPage)
              envBar(),
          ],
        ),
        if (overlayChild() != null) Positioned.fill(child: overlayChild()!),
        Obx(() => controller.isLoading.value ? loader() : SizedBox.shrink()),
        if (kDebugMode && routeName.isNotEmpty) _nameOfPageTag(),
      ],
    );
  }

  List<Widget> stackedChildren(BuildContext context) {
    return [
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
    ];
  }

  Widget _nameOfPageTag() {
    return Positioned(
      left: 5,
      top: 20.0 + (topSafeArea ? 0 : Get.mediaQuery.viewPadding.top),
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
    if (c.hasDrawer.value) {
      isDrawerLeft = drawerAction!.drawerPosition == DrawerPosition.Left;
    }

    return Obx(
      () => Scaffold(
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        backgroundColor: backgroundColor,
        floatingActionButton: c.hasFloatingButton.value
            ? floatingAction?.floatingActionButton
            : null,
        floatingActionButtonLocation: c.hasFloatingButton.value
            ? floatingAction?.floatingActionButtonLocation
            : null,
        floatingActionButtonAnimator: c.hasFloatingButton.value
            ? floatingAction?.floatingActionButtonAnimator
            : null,
        drawer: c.hasDrawer.value && isDrawerLeft ? drawerAction!.drawer : null,
        onDrawerChanged: c.hasDrawer.value && isDrawerLeft
            ? drawerAction!.onDrawerChanged
            : null,
        drawerEnableOpenDragGesture: c.hasDrawer.value && isDrawerLeft
            ? drawerAction!.drawerEnableOpenDragGesture
            : true,
        endDrawer:
            c.hasDrawer.value && !isDrawerLeft ? drawerAction!.drawer : null,
        onEndDrawerChanged: c.hasDrawer.value && !isDrawerLeft
            ? drawerAction!.onDrawerChanged
            : null,
        endDrawerEnableOpenDragGesture: c.hasDrawer.value && !isDrawerLeft
            ? drawerAction!.drawerEnableOpenDragGesture
            : true,
        drawerDragStartBehavior: c.hasDrawer.value
            ? drawerAction!.drawerDragStartBehavior
            : DragStartBehavior.start,
        drawerEdgeDragWidth:
            c.hasDrawer.value ? drawerAction!.drawerEdgeDragWidth : null,
        drawerScrimColor:
            c.hasDrawer.value ? drawerAction!.drawerScrimColor : null,
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
            child: topSafeArea || bottomSafeArea
                ? SafeArea(
                    top: topSafeArea,
                    bottom: bottomSafeArea,
                    child: _contentBody(context),
                  )
                : _contentBody(context),
          ),
        ),
      ),
    );
  }
}
