import 'package:flutter/foundation.dart';

import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:baseX/Core/index.dart';

class XController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    XLogger.info('XController is initialized.');
    platformSetup();
  }

  platformSetup() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    baseConstant.packageName.value = packageInfo.packageName;
    baseConstant.appVersion.value = packageInfo.version;

    if (defaultTargetPlatform == TargetPlatform.android) {
      AndroidId _androidId = AndroidId();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      baseConstant.deviceId.value = (await _androidId.getId())!;
      baseConstant.osVersion.value = androidInfo.version.release;
      baseConstant.deviceModel.value = '${androidInfo.manufacturer} ${androidInfo.model}';
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      baseConstant.deviceId.value = iosInfo.identifierForVendor!;
      baseConstant.osVersion.value = iosInfo.systemVersion;
      baseConstant.deviceModel.value = '${iosInfo.name} ${iosInfo.model}';
    }
  }
}
