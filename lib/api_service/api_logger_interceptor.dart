part of 'index.dart';

class XLoggerInterceptors extends Interceptor with InterceptorMixin {
  // var _cache = <Uri, Response>{};

  /// Request on header
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    Map<String, String?> header = {
      Headers.acceptHeader: Headers.jsonContentType,
      'App-Version': baseConstant.appVersion.value,
      'Os-Type': GetPlatform.isIOS ? 'ios' : 'android',
      if (defaultLangController != null) 'Label-Version': defaultLangController?.labelVersion,
      if (Get.locale != null) 'Accept-Language': Get.locale?.languageCode,
      'Device-Model': baseConstant.deviceModel.value,
      if (baseConstant.deviceId.value != '') 'Device-ID': baseConstant.deviceId.value,
      if (baseConstant.osVersion.value != '') 'Os-Version': baseConstant.osVersion.value,
      // 'Device-Type': Platform.isIOS ? 'ios' : 'android',
      // 'Version-Type': baseConstant.versionType,
      // 'API-Version': baseConstant.api_version,
    };

    if (options.headers.containsKey('headerType')) {
      if (options.headers['headerType'] == HeaderType.authorized && X != null) {
        options.headers.addAll({HttpHeaders.authorizationHeader: 'Bearer ${X?.accessToken}'});
      }

      options.headers.remove('headerType');
      options.headers.addAll(header);
    }
    XLogger.reqHead('START REQUEST');
    XLogger.reqBody('║');
    XLogger.reqBody('╟ METHOD: ${options.method.toUpperCase()}');
    XLogger.reqBody('╟ BASEURL: ${options.baseUrl}');
    XLogger.reqBody('╟ PATH: ${options.path}');
    XLogger.reqBody('║');
    XLogger.reqBody('╟ ########## HEADER ##########');
    if (options.headers.isNotEmpty) {
      options.headers.forEach((k, v) => XLogger.reqBody('║ $k: $v'));
    } else {
      XLogger.reqBody('║ NO HEADER');
    }
    XLogger.reqBody('╟ ########## HEADER ##########');
    XLogger.reqBody('║');
    if (options.method.toUpperCase() == 'GET') {
      XLogger.reqBody('╟ QUERY PARAM: ${options.queryParameters.toString()}');
    }
    XLogger.reqBody('║');
    XLogger.reqBody('╟ ########## BODY ##########');
    if (options.data != null) {
      final Map<String, dynamic> bodyMap = Map<String, dynamic>.fromEntries(options.data.fields);
      XLogger.reqBody('║ ${bodyMap.toString()}');
    } else {
      XLogger.reqBody('║ NO BODY');
    }
    XLogger.reqBody('╟ ########## BODY ##########');

    XLogger.reqBody('║ ');
    XLogger.reqTail(' END REQUEST ');

    return handler.next(options);
  }

  /// Request on error will throw custom Exception Error
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    XLogger.errorHead('START ERROR');
    XLogger.errorBody('║');
    XLogger.errorBody('╟ RESPONSE STATUS CODE: ${err.response?.statusCode}');
    XLogger.errorBody('╟ SERVER STATUS MESSAGE: ${err.response?.statusMessage}');
    if (err.response?.data.containsKey('code') && err.response?.data['code'] != 40000) {
      XLogger.errorBody('╟ CODE: ${err.response?.data['code']}');
    }
    XLogger.errorBody('╟ RAW DATA: ${err.response?.data}');
    // if (err.response?.data != null)
    //   print('ERROR_KEY : ${err.response?.data['error_key']}');
    if (err.response?.statusCode == 422) {
      XLogger.errorBody('╟ ERROR ON STATUS CODE: 422');
      XLogger.errorBody('║ ${err.response?.data['message']}');
    }
    XLogger.errorBody('║');
    XLogger.errorTail(' END ERROR ');
    return handler.next(err);
  }

  /// Request on response
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (response.data.containsKey('code') && baseConstant.success200) {
      if (response.data['code'] >= 200 && !response.data['status']) {
        XLogger.errorHead('START ERROR');
        XLogger.errorBody('║');
        XLogger.errorBody('╟ RESPONSE STATUS CODE: ${response.data['code']}');
        XLogger.errorBody('╟ SERVER STATUS MESSAGE: ${response.data['message']}');
        XLogger.errorBody('╟ RAW DATA: ${response.data}');
        // if (err.response?.data != null)
        //   print('ERROR_KEY : ${err.response?.data['error_key']}');
        if (response.data['code'] == 422) {
          XLogger.errorBody('╟ ERROR ON STATUS CODE: 422');
          XLogger.errorBody('║ ${response.data['message']}');
        }
        XLogger.errorBody('║');
        XLogger.errorTail(' END ERROR ');

        return handler.next(response);
      }
    }
    XLogger.resHead('START RESPONSE');
    XLogger.resBody('║');
    XLogger.resBody('╟ Response: ${response.data}');
    XLogger.resBody('╟ Status Code: ${response.data['code']}');
    XLogger.resBody('║');
    XLogger.resTail(' END RESPONSE ');

    return handler.next(response);
  }
}
