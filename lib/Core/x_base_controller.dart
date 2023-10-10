import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:baseX/Core/x_get_app.dart';
import 'package:get/get.dart';

/// onFailedDialog => Function will run when super.onFailed return false, by default will show a dialog set in BaseConfig file.
///
/// onFailed => onFailed function for api, by default will run onFailedDialog.
abstract class BaseXController<T> extends FullLifeCycleController
    with FullLifeCycleMixin
    implements GeneralCallBack, RequiredCallBack {
  RxBool isLoading = false.obs;
  double horizontalDown = 0;
  T page = Get.arguments;

  /// [hasFloatingButton] needed to set to true to displaying floatingaction button
  RxBool hasFloatingButton = false.obs;

  /// [hasDrawer] needed to set to true to displaying drawer
  RxBool hasDrawer = false.obs;

  /// Accepts a [RxBool], Default value : true
  /// Set [isAllowBack] to false to disallow user to get back.
  RxBool isAllowBack = true.obs;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void onClose() {
    super.onClose();
    if (kDebugMode) {
      print('$runtimeType - onClose called');
    }
  }

  @override
  void onDetached() {
    if (kDebugMode) {
      print('$runtimeType - onDetached called');
    }
  }

  @override
  void onInactive() {
    if (kDebugMode) {
      print('$runtimeType - onInactive called');
    }
  }

  @override
  void onPaused() {
    if (kDebugMode) {
      print('$runtimeType - onPaused called');
    }
  }

  @override
  void onResumed() {
    if (kDebugMode) {
      print('$runtimeType - onResumed called');
    }
  }

  @override
  void onHidden() {
    if (kDebugMode) {
      print('$runtimeType - onHidden called');
    }
  }

  void onFailedDialog(int code, String msg, dynamic data) {
    if (!(Get.isDialogOpen ?? false)) {
      baseConstant.defaulOnFailedDialog(code, msg);
    }
  }

  @override
  bool onFailed(int code, String msg, dynamic data, {Function? tryAgain}) {
    isLoading.value = false;
    // dismissKeyboard(Get.context);
    if (Get.context == null) return true;
    if (!(baseConstant.onFailed(Get.context!, code, msg, tryAgain: tryAgain))) {
      onFailedDialog(code, msg, data);
    }
    return true;
  }

  @override
  Future<bool> onBack() async {
    return isAllowBack.value;
  }

  @override
  Future<void> onBackButton() async {
    bool needPop = await onBack();

    return needPop ? Get.back() : null;
  }
}

abstract class GeneralCallBack {
  bool onFailed(int code, String msg, dynamic data, {Function? tryAgain});
}

abstract class RequiredCallBack {
  Future<bool> onBack();

  void onBackButton();
}
