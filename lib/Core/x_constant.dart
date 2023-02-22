import 'package:flutter/material.dart';

import 'package:flutter_hms_gms_checker/flutter_hms_gms_checker.dart';

import 'package:get/get.dart';
import 'package:huawei_hmsavailability/huawei_hmsavailability.dart';

import 'package:baseX/base_x.dart';

enum Environment { Live, Staging }

enum Position { top, bottom }

/// [BaseXConstant] is a base class constant
abstract class BaseXConstant {
  abstract Environment appEnv;
  Position get position;

  abstract String baseUrl;
  abstract String uatBaseUrl;

  abstract bool success200;
  RxString get osVersion;
  RxString get deviceModel;
  RxString get appVersion;
  RxString get deviceId;
  RxString get packageName;

  Color get defaultBackgroundColor;

  Widget get defaultLoadingWidget;
  Widget get envBar;
  Widget customErrorWidget(FlutterErrorDetails error);

  Future<void> defaulOnFailedDialog(int statusCode, String message);
  Future<bool> isHMS();
  Future<bool> isGMS();

  GeneralErrorHandle get onFailed;
}

/// Default variable:
///
/// 1. baseUrl => Live url set in runEtcApp
/// 2. staginBaseUrl => Staging url set in runEtcApp
/// 3. languageCode => current language selected, by default is English, en. (if multi langauge is enable in runEtcApp)
/// 4. onFailed => global onFailed set in runEtcApp
class DefaultBaseConstant extends BaseXConstant {
  @override
  Color get defaultBackgroundColor => Colors.white;

  @override
  Widget get defaultLoadingWidget => SizedBox.shrink();

  @override
  Environment appEnv = Environment.Live;

  @override
  String baseUrl = '';

  @override
  String uatBaseUrl = '';

  @override
  bool success200 = false;

  @override
  RxString deviceModel = ''.obs;

  @override
  RxString osVersion = ''.obs;

  @override
  RxString appVersion = '1.0.0'.obs;

  @override
  RxString deviceId = ''.obs;

  @override
  RxString packageName = ''.obs;

  @override
  Position position = Position.bottom;

  @override
  Widget envBar = Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    color: Colors.greenAccent,
    child: Obx(
      () => Text(
        'Endpoint: Staging | Os-type: ${GetPlatform.isIOS ? 'ios' : 'android'} | Device-Model: ${baseConstant.deviceModel.value} | Os-version: ${baseConstant.osVersion.value}',
        style: TextStyle(
          fontSize: 8,
        ),
        textAlign: TextAlign.center,
      ),
    ),
  );

  @override
  late GeneralErrorHandle onFailed;

  /// 0: HMS Core (APK) is available.
  ///
  /// 1: No HMS Core (APK) is found on device.
  ///
  /// 2: HMS Core (APK) installed is out of date.
  ///
  /// 3: HMS Core (APK) installed on the device is unavailable.
  ///
  /// 9: HMS Core (APK) installed on the device is not the official version.
  ///
  /// 21: The device is too old to support HMS Core (APK)
  ///
  @override
  Future<bool> isHMS() async {
    if (GetPlatform.isIOS) return false;
    HmsApiAvailability client = HmsApiAvailability();
    int status = await client.isHMSAvailable();
    bool _isGMS = await isGMS();
    return status == 0 && !_isGMS;
    // -- Added !_isGMS to ensure the device have actually no GMS, else still can proceed GMS services.
  }

  @override
  Future<bool> isGMS() async {
    if (GetPlatform.isIOS) return true;
    bool result = await FlutterHmsGmsChecker.isGmsAvailable;
    return result;
  }

  @override
  Widget customErrorWidget(FlutterErrorDetails error) => SafeArea(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(children: <Widget>[
            Container(
                padding: EdgeInsets.only(top: 30, bottom: 10),
                child: Icon(Icons.announcement, size: 40, color: Colors.red)),
            Text(
              'An application error has occurred.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
            Container(
                padding: EdgeInsets.all(15),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Error message:',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline)),
                    Text(error.exceptionAsString()),
                  ],
                )),
            Expanded(
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Stack Trace:',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline)),
                      Expanded(child: SingleChildScrollView(child: Text(error.stack.toString()))),
                    ],
                  )),
            ),
            Container(
                padding: EdgeInsets.all(15),
                width: double.infinity,
                child: InkWell(
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                        child: Text('Send Bug Report',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ))),
                  ),
                )),
          ]),
        ),
      );

  @override
  Future<void> defaulOnFailedDialog(int statusCode, String message) => Get.dialog(AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
        content: Text(message),
      ));
}
