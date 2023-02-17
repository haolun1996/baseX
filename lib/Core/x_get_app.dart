import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

import 'package:baseX/base_x.dart';

late DefaultBaseConstant baseConstant;
late ApiXService defaultService;

/// * [title] => Title for when hold minimized app will hold
/// * [theme] => Set Project app theme
/// * [themeMode] => Enable dark mode, if null being pass, will disable dark mode. Default value is null
/// * [currentEnv] => Set current environment. Staging or Live
/// * [liveBaseUrl] => Set live base url. Required if currentEnv is live
/// * [staginBaseUrl] => Set staging base url. Required if currentEnv is staging
/// * [allowOrientationList] => Set allowed Orientation List
/// * [onFailed] => Set Global onFailed
/// * [firebaseNotificationController] => Enable FCM, will disable function if no object being pass
/// * [appLanguage] => Enable App Langauge, will disable function if no object being pass
/// * [getPages] => Register all page route with binding (if any)
/// * [initialBinding] => Set Global Binding
/// * [additionalFunction] => Add additional function before runEtcApp
/// * [additionalWidget] => Add additional widget before material app
/// * [required200] => Set api whether always receive http code 200
/// * [timeOutDurationInSecond] => Set api timeoutDuration to this field in seconds
void runXApp({
  required String title,
  required ThemeData lightTheme,
  required ThemeData darkTheme,
  required String liveBaseUrl,
  required String staginBaseUrl,
  // required bool requireSharePref,
  required VoidCallback sharedPref,
  required List<GetPage<dynamic>> getPages,
  required BaseXWidget initialPage,
  required Bindings initialBinding,
  required GeneralErrorHandle onFailed,
  ThemeMode? themeMode,
  Environment currentEnv = Environment.Staging,
  bool? required200,
  Duration timeOutDurationInSecond = timeoutDuration,
  List<DeviceOrientation> allowOrientationList = const [DeviceOrientation.portraitUp],
  FirebaseNotificationController? firebaseNotificationController,
  DefaultBaseConstant? constantConfig,
  AppTranslationX? appLanguage,
  Function? additionalFunction,
  AddtionalWidget? additionalWidget,
  BaseXHttp? customHttp,
}) {
  //Check required field
  // assert(!(appLanguage != null && !requireSharePref),
  //     'Required Share Preference to enable App Language');
  // assert(!(firebaseNotificationController != null && !requireSharePref),
  // 'Required Share Preference to enable Firebase Notification');
  assert((Uri.tryParse(staginBaseUrl)?.isAbsolute ?? false), 'Please enter a valid staging url');
  assert((Uri.tryParse(liveBaseUrl)?.isAbsolute ?? false), 'Please enter a valid live url');

  WidgetsFlutterBinding.ensureInitialized();

  //Set available orientation
  SystemChrome.setPreferredOrientations(allowOrientationList);

  //Set Constant File
  baseConstant = constantConfig ?? DefaultBaseConstant();

  //Set Base Url
  baseConstant.uatBaseUrl = staginBaseUrl;
  baseConstant.baseUrl = liveBaseUrl;
  baseConstant.appEnv = currentEnv;

  // Set api whether always receive http code 200
  if (required200 != null) {
    baseConstant.success200 = required200;
  }

  sharedPref();

  //Set Gloabal onFailed
  baseConstant.onFailed = onFailed;

  //Initialize Firebase Notification Controller if Exists
  firebaseNotificationController?.initialize();

  //Set App Language
  if (appLanguage != null) {
    appTranslationX = appLanguage;
  }

  //Additional Function required before run app
  if (additionalFunction != null) {
    additionalFunction();
  }
  Dio _dio = Dio();
  if (customHttp != null) {
    defaultService = ApiXService.init(_dio, timeOutDurationInSecond, customHttp: customHttp);
  } else {
    defaultService = ApiXService.init(_dio, timeOutDurationInSecond);
  }

  runApp(MyApp(
    title: title,
    lightTheme: lightTheme,
    darkTheme: darkTheme,
    getPages: getPages,
    initialPage: initialPage,
    initialBinding: initialBinding,
    appLanguage: appLanguage,
    themeMode: themeMode,
    additionalWidget: additionalWidget,
  ));
}

class MyApp extends StatelessWidget {
  final String title;
  final ThemeData lightTheme;
  final ThemeData darkTheme;
  final ThemeMode? themeMode;
  final List<GetPage<dynamic>> getPages;
  final BaseXWidget initialPage;
  final Bindings initialBinding;
  final AppTranslationX? appLanguage;
  final AddtionalWidget? additionalWidget;
  const MyApp({
    required this.title,
    required this.lightTheme,
    required this.darkTheme,
    required this.getPages,
    required this.initialPage,
    required this.initialBinding,
    this.appLanguage,
    this.themeMode,
    this.additionalWidget,
  });

  Widget materialApp() {
    return GetMaterialApp(
      title: title,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.light,
      getPages: getPages,
      initialRoute: initialPage.routeName,
      initialBinding: initialBinding,
      locale: appLanguage?.appLocale,
      localizationsDelegates: appLanguage == null
          ? []
          : [
              appLanguage!.appLocalizationsX.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              DefaultCupertinoLocalizations.delegate
            ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return additionalWidget == null ? materialApp() : additionalWidget!(materialApp());
  }
}
