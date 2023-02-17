part of api_service;

class ApiInterceptors extends Interceptor with InterceptorMixin {
  // var _cache = <Uri, Response>{};

  /// Request on header
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.headers.containsKey('headerType')) {
      if (options.headers['headerType'] == HeaderType.authorized && X != null) {
        options.headers.addAll({HttpHeaders.authorizationHeader: 'Bearer ${X?.accessToken}'});
      }

      options.headers.remove('headerType');
      options.headers.addAll(header);
    }
    return super.onRequest(options, handler);
  }

  /// Request on error will throw custom Exception Error
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    DioError customError = NoConnectionException(
      requestOptions: err.requestOptions,
    );

    switch (err.type) {
      case DioErrorType.connectionTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        customError = TimeOutException(
            errorMsg: err.response?.data['message'],
            requestOptions: err.requestOptions,
            statusCode: err.response?.statusCode);
        break;
      case DioErrorType.badResponse:
        customError = onErrorProcess(
          err.response?.statusCode,
          err.response?.data['message'],
          err.requestOptions,
        );
        break;
      case DioErrorType.badCertificate:
      case DioErrorType.cancel:
        break;
      case DioErrorType.connectionError:
      case DioErrorType.unknown:
        customError = NoConnectionException(
          requestOptions: err.requestOptions,
          statusCode: XHttpType.unknown.value,
        );
        break;
    }

    // if (err.type == DioErrorType.connectTimeout || err.type == DioErrorType.other) {
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
      if (response.data['code'] > 200) {
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
