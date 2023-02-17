part of api_service;

class LoggerInterceptors extends Interceptor with InterceptorMixin {
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
    Logger.reqHead('START REQUEST');
    Logger.reqBody('║');
    Logger.reqBody('╟ METHOD: ${options.method.toUpperCase()}');
    Logger.reqBody('╟ BASEURL: ${options.baseUrl}');
    Logger.reqBody('╟ PATH: ${options.path}');
    Logger.reqBody('║');
    Logger.reqBody('╟ ########## HEADER ##########');
    if (options.headers.isNotEmpty) {
      options.headers.forEach((k, v) => Logger.reqBody('║ $k: $v'));
    } else {
      Logger.reqBody('║ NO HEADER');
    }
    Logger.reqBody('╟ ########## HEADER ##########');
    Logger.reqBody('║');
    if (options.method.toUpperCase() == 'GET') {
      Logger.reqBody('╟ QUERY PARAM: ${options.queryParameters.toString()}');
    }
    Logger.reqBody('║');
    Logger.reqBody('╟ ########## BODY ##########');
    if (options.data != null) {
      final Map<String, dynamic> bodyMap = Map<String, dynamic>.fromEntries(options.data.fields);
      Logger.reqBody('║ ${bodyMap.toString()}');
    } else {
      Logger.reqBody('║ NO BODY');
    }
    Logger.reqBody('╟ ########## BODY ##########');

    Logger.reqBody('║ ');
    Logger.reqTail(' END REQUEST ');

    return super.onRequest(options, handler);
  }

  /// Request on error will throw custom Exception Error
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    Logger.errorHead('START ERROR');
    Logger.errorBody('║');
    Logger.errorBody('╟ RESPONSE STATUS CODE: ${err.response?.statusCode}');
    Logger.errorBody('╟ SERVER STATUS MESSAGE: ${err.response?.statusMessage}');
    Logger.errorBody('╟ RAW DATA: ${err.response?.data}');
    // if (err.response?.data != null)
    //   print('ERROR_KEY : ${err.response?.data['error_key']}');
    if (err.response?.statusCode == 422) {
      Logger.errorBody('╟ ERROR ON STATUS CODE: 422');
      Logger.errorBody('║ ${err.response?.data['message']}');
    }
    Logger.errorBody('║');
    Logger.errorTail(' END ERROR ');
    return super.onError(err, handler);
  }

  /// Request on response
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (response.data.containsKey('code') && baseConstant.success200) {
      if (response.data['code'] > 200) {
        Logger.errorHead('START ERROR');
        Logger.errorBody('║');
        Logger.errorBody('╟ RESPONSE STATUS CODE: ${response.data['code']}');
        Logger.errorBody('╟ SERVER STATUS MESSAGE: ${response.data['message']}');
        Logger.errorBody('╟ RAW DATA: ${response.data}');
        // if (err.response?.data != null)
        //   print('ERROR_KEY : ${err.response?.data['error_key']}');
        if (response.data['code'] == 422) {
          Logger.errorBody('╟ ERROR ON STATUS CODE: 422');
          Logger.errorBody('║ ${response.data['message']}');
        }
        Logger.errorBody('║');
        Logger.errorTail(' END ERROR ');

        return handler.reject(
          onErrorProcess(
            response.data['code'],
            response.data['message'],
            response.requestOptions,
          ),
        );
      }
    }
    Logger.resHead('START RESPONSE');
    Logger.resBody('║');
    Logger.resBody('╟ Response: ${response.data}');
    Logger.resBody('╟ Status Code: ${response.data['code']}');
    Logger.resBody('║');
    Logger.resTail(' END RESPONSE ');

    return handler.next(response);
  }
}
