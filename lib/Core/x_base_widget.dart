import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import 'package:baseX/base_x.dart';
import 'package:baseX/helper/scroll_behaviour.dart';
import 'package:get/get.dart';

abstract class BaseXWidget<T extends BaseXController> extends GetWidget<T> {
 T get c => controller;

  String get routeName;

  bool get safeArea => true;

  bool get resizeToAvoidBottomInset => false;

  Color get backgroundColor => baseConstant.defaultBackgroundColor;

  Widget loader() => baseConstant.defaultLoadingWidget;

  Widget? appBar(BuildContext context);

  Widget? body(BuildContext context);

  Widget? overlayChild() => null;

  Widget envBar() => baseConstant.envBar;

  @override
  Widget build(BuildContext context) {
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
            if (appBar(context) != null) appBar(context)!,
            if (body(context) != null)
              Expanded(
                child: hideScrollShadow(body(context)!),
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
    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      backgroundColor: backgroundColor,
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
