import 'package:flutter/material.dart';

class HideShadowBehavior extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return ClampingScrollPhysics();
  }

  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

Widget hideScrollShadow(Widget child) {
  return ScrollConfiguration(
    behavior: HideShadowBehavior(),
    child: child,
  );
}
