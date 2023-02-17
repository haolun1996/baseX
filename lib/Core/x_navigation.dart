import 'package:flutter/material.dart';

import 'package:baseX/Core/x_base_controller.dart';
import 'package:baseX/Core/x_base_widget.dart';
import 'package:get/get.dart';

GetPage onGetPage<T extends BaseXWidget>(
  String routeName,
  GetPageBuilder pageBuilder, {
  Bindings? binding,
  List<GetMiddleware>? middlewares,
}) =>
    GetPage(
      name: routeName,
      page: () => pageBuilder(),
      binding: binding,
      middlewares: middlewares,
    );

GetPage cGetPageInitial<T extends BaseXWidget>(T page, {Bindings? binding}) {
  // return GetPage(name: page.routeName, page: () => page, binding: binding);
  return onGetPage(page.routeName, () => page, binding: binding);
}

GetPage cGetPage<T extends BaseXWidget>(
  T page, {
  Bindings? binding,
  List<GetMiddleware>? middlewares,
}) {
  // return GetPage(
  //   name: page.routeName,
  //   page: () {
  //     T _page = Get.arguments;
  //     return _page;
  //   },
  //   binding: binding,
  //   middlewares: middlewares,
  // );
  return onGetPage(
    page.routeName,
    () {
      T _page = Get.arguments;
      return _page;
    },
    binding: binding,
    middlewares: middlewares,
  );
}

Future<dynamic> loadPage(BaseXWidget page, {bool preventDuplicates = true}) async {
  var result =
      await Get.toNamed(page.routeName, arguments: page, preventDuplicates: preventDuplicates);
  return result;
}

loadPageWithRemovePrevious(BaseXWidget toRoute, BaseXWidget fromRoute) {
  Get.offNamedUntil(toRoute.routeName, ModalRoute.withName(fromRoute.routeName),
      arguments: toRoute);
}

loadPageWithRemoveAllPrevious(
  BaseXWidget page,
) {
  Get.offNamedUntil(page.routeName, (route) => route == null, arguments: page);
}

backTo(BaseXWidget page) {
  Get.until((route) => Get.currentRoute == page.routeName);
}

T? getController<T extends BaseXController>() {
  if (Get.isRegistered<T>()) {
    return Get.find<T>();
  } else {
    return null;
  }
}
