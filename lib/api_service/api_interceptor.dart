part of 'index.dart';

class ApiInterceptors extends Interceptor with InterceptorMixin {
  // var _cache = <Uri, Response>{};

  /// Request on header
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    Map<String, String?> header = {
      Headers.acceptHeader: Headers.jsonContentType,
      'App-Version': baseConstant.appVersion.value,
      'Os-Type': GetPlatform.isIOS ? 'ios' : 'android',
      if (defaultLangController != null)
        'Label-Version': defaultLangController?.labelVersion,
      if (Get.locale != null) 'Accept-Language': Get.locale?.languageCode,
      'Device-Model': baseConstant.deviceModel.value,
      if (baseConstant.deviceId.value != '')
        'Device-ID': baseConstant.deviceId.value,
      if (baseConstant.osVersion.value != '')
        'Os-Version': baseConstant.osVersion.value,
      // 'Device-Type': Platform.isIOS ? 'ios' : 'android',
      // 'Version-Type': baseConstant.versionType,
      // 'API-Version': baseConstant.api_version,
    };

    if (options.headers.containsKey('headerType')) {
      if (options.headers['headerType'] == HeaderType.authorized && X != null) {
        options.headers.addAll(
            {HttpHeaders.authorizationHeader: 'Bearer ${X?.accessToken}'});
      }

      options.headers.remove('headerType');
      options.headers.addAll(header);
    }
    return super.onRequest(options, handler);
  }

  /// Request on error will throw custom Exception Error
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    DioException customError = NoConnectionException(
      requestOptions: err.requestOptions,
    );

    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        customError = TimeOutException(
            requestOptions: err.requestOptions,
            errorMsg: err.response?.data['message'],
            statusCode: err.response?.statusCode);
        break;
      case DioExceptionType.badResponse:
        customError = onErrorProcess(
          err.response?.statusCode,
          err.response?.data['message'],
          err.requestOptions,
          code: err.response?.data['code'],
        );
        break;
      case DioExceptionType.badCertificate:
      case DioExceptionType.cancel:
        break;
      case DioExceptionType.connectionError:
      case DioExceptionType.unknown:
        customError = NoConnectionException(
          requestOptions: err.requestOptions,
          statusCode: XHttpType.unknown.value,
        );
        break;
    }

    // if (err.type == DioException.connectTimeout || err.type == DioErrorType.other) {
    //   Response cachedResponse = _cache[err.requestOptions.uri];
    //   print('>>>>>1>>>>');
    //   if (cachedResponse != null) {
    //     print('>>>>>2>>>>');
    //     return handler.resolve(cachedResponse);
    //   }
    // }

    return super.onError(customError, handler);
  }

  /// Request on response
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (response.data.containsKey('code') && baseConstant.success200) {
      if (response.data['code'] >= 200 && !response.data['status']) {
        return handler.reject(
          onErrorProcess(
            response.data['code'],
            response.data['message'],
            response.requestOptions,
          ),
        );
      }
    }

    // _cache[response.requestOptions.uri] = response;
    return super.onResponse(response, handler);
  }
}
