import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:baseX/base_x.dart';

/// onFailedDialog => Function will run when super.onFailed return false, by default will show a dialog set in BaseConfig file.
///
/// onFailed => onFailed function for api, by default will run onFailedDialog.
abstract class BaseXController<T> extends FullLifeCycleController
    with FullLifeCycleMixin
    implements GeneralCallBack, RequiredCallBack {
  RxBool isLoading = false.obs;
  double horizontalDown = 0;
  T page = Get.arguments;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void onClose() {
    super.onClose();
    print('$runtimeType - onClose called');
  }

  @override
  void onDetached() {
    print('$runtimeType - onDetached called');
  }

  @override
  void onInactive() {
    print('$runtimeType - onInactive called');
  }

  @override
  void onPaused() {
    print('$runtimeType - onPaused called');
  }

  @override
  void onResumed() {
    print('$runtimeType - onResumed called');
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
  Future<bool> onBack() async => true;
}

abstract class GeneralCallBack {
  bool onFailed(int code, String msg, dynamic data, {Function? tryAgain});
}

abstract class RequiredCallBack {
  Future<bool> onBack() async => true;
}
