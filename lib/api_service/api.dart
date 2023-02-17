part of api_service;

enum HttpMethod { get, post, put, delete }

enum HeaderType { none, standard, authorized }

late BaseXHttp baseXHttp;

const String multipartHeader = 'multipart/form-data';
const Duration timeoutDuration = Duration(seconds: 60);

/// Api class will put on main.dart
class ApiXService {
  late Dio _dio;

  void _setBaseXHttp(BaseXHttp customHttp) {
    baseXHttp = customHttp;
  }

  String? get getEndpoint {
    return _dio.options.baseUrl;
  }

  ApiXService.init(
    Dio dio,
    Duration timeout, {
    BaseXHttp? customHttp,
    String? customEndpoint,
  }) : _dio = dio {
    _dio.options.connectTimeout = timeout;

    if (customEndpoint != null) {
      _dio.options.baseUrl = customEndpoint;
    } else {
      _dio.options.baseUrl = baseConstant.baseUrl;
    }

    _dio.interceptors.addAll([XLoggerInterceptors(), ApiInterceptors()]);

    if (customHttp != null) {
      _setBaseXHttp(customHttp);
    }

    XLogger.info('Api initialzed with (${_dio.options.baseUrl}) endpoint.');
  }

  /// [get] request
  /// * with [JSON] in [create]
  /// ```json
  ///   "data": {
  ///     "latest_app_version": "1.0.0"
  ///   }
  /// ```
  /// and use it
  /// ```dart
  ///   await defaultServ.get(
  ///     'app-version',
  ///     body,
  ///     onFail,
  ///     create: (JSON data) => data['latest_app_version'],
  ///   );
  /// ```
  /// * with [JSONLIST] in [create]
  /// ```json
  ///   "data": [
  ///     {
  ///       "code": "60",
  ///       "name": "Malaysia"
  ///     }
  ///   ]
  /// ```
  /// and use it
  /// ```dart
  ///   await defaultServ.get(
  ///     'app-version',
  ///     body,
  ///     onFail,
  ///     create: (JSONLIST data) => Country.listFromJson(data),
  ///   );
  /// ```
  Future get<T>(String endpoint, OnFail onFailed,
      {required FromJsonM<T> create,
      bool requiredToken = true,
      String? pathParam,
      JSON? queryParam}) async {
    try {
      await _getHeaderType(requiredToken);
      Response response = await _dio.get(_mixPathParam(endpoint, pathParam: pathParam),
          queryParameters: queryParam);
      XResponse aResponse = XResponse<T>.fromJson(response.data, create: create);
      return aResponse.data;
    } on Exception catch (e) {
      print('error in get: $e');
      _processError(e, onFailed);
    }
  }

  /// [post] request
  /// * with [JSON] in [create]
  /// ```json
  ///   "data": {
  ///     "latest_app_version": "1.0.0"
  ///   }
  /// ```
  /// and use it
  /// ```dart
  ///   await defaultServ.post(
  ///     'app-version',
  ///     body,
  ///     onFail,
  ///     create: (JSON data) => data['latest_app_version'],
  ///   );
  /// ```
  /// * with [JSONLIST] in [create]
  /// ```json
  ///   "data": [
  ///     {
  ///       "code": "60",
  ///       "name": "Malaysia"
  ///     }
  ///   ]
  /// ```
  /// and use it
  /// ```dart
  ///   await defaultServ.post(
  ///     'app-version',
  ///     body,
  ///     onFail,
  ///     create: (JSONLIST data) => Country.listFromJson(data),
  ///   );
  /// ```
  Future post<T>(String endpoint, JSON body, OnFail onFailed,
      {FromJsonM<T>? create, OnGenericCallBack? onSuccess, bool requiredToken = true}) async {
    try {
      await _getHeaderType(requiredToken);
      FormData formData = FormData.fromMap(body);
      Response response = await _dio.post(_mixPathParam(endpoint), data: formData);
      XResponse aResponse = XResponse<T>.fromJson(
        response.data,
        create: create,
      );

      if (onSuccess != null) {
        onSuccess(aResponse.message, aResponse.data);
      }

      return aResponse.data;
    } on Exception catch (e) {
      print('error in post: $e');
      _processError(e, onFailed);
    }
  }

  /// [put] request
  Future put(
    String endpoint,
    JSON? body,
    OnFail onFailed, {
    OnGenericCallBack? onSuccess,
    bool requiredToken = true,
  }) async {
    try {
      await _getHeaderType(requiredToken);
      Response response = await _dio.put(_mixPathParam(endpoint), data: body);
      XResponse aResponse = XResponse.fromJson(response.data);
      if (onSuccess != null) {
        onSuccess(aResponse.message, aResponse.data);
      }
      return aResponse.data;
    } on Exception catch (e) {
      print('error in put: $e');
      _processError(e, onFailed);
    }
  }

  /// [delete] request
  Future delete(String endpoint, String pathParam, OnFail onFailed,
      {FromJsonM? create,
      OnGenericCallBack? onSuccess,
      bool requiredToken = true,
      JSON? queryParam}) async {
    try {
      await _getHeaderType(requiredToken);
      Response response = await _dio.delete(_mixPathParam(endpoint, pathParam: pathParam),
          queryParameters: queryParam);
      XResponse aResponse = XResponse.fromJson(response.data);
      if (onSuccess != null) {
        onSuccess(aResponse.message, aResponse.data);
      }
      return aResponse.data;
    } on Exception catch (e) {
      print('error in delete: $e');
      _processError(e, onFailed);
    }
  }

  setNewEndpoint(String endPoint) async {
    _dio.options.baseUrl = endPoint;
  }

  /// Put authorized or not based on requiredToken bool
  Future<void> _getHeaderType(bool requiredToken) async {
    if (requiredToken) {
      _dio.options.headers.addAll({'headerType': HeaderType.authorized});
    } else {
      _dio.options.headers.addAll({'headerType': HeaderType.standard});
    }
  }

  /// Put api endpoint with path param combination if both value not null
  String _mixPathParam(String endpoint, {String? pathParam}) {
    return '/$endpoint${pathParam.isStringNotNullEmpty ? '/$pathParam' : ''}';
  }

  Future<void> _processError(Exception exception, OnFail onFailed) async {
    if ((exception.runtimeType == InvalidRequestException) &&
        (exception as XError).errorMsg == '') {
      return;
    }

    Map<String, dynamic> exec;
    switch (exception.runtimeType) {
      case InvalidRequestException:
        exec = {
          'statusCode': 400,
          'message': exception.toString(),
        };
        break;
      case InternalServerErrorException:
        exec = {
          'statusCode': 500,
          'message': exception.toString(),
        };
        break;
      case UnauthorizedException:
        exec = {
          'statusCode': 401,
          'message': exception.toString(),
        };
        break;
      case NotFoundException:
        exec = {
          'statusCode': 404,
          'message': exception.toString(),
        };
        break;
      case NoConnectionException:
        exec = {
          'statusCode': -1, //exception.getStatusCode(),
          'message': exception.toString(),
        };
        break;
      case TimeOutException:
        exec = {
          'statusCode': -1,
          'message': exception.toString(),
        };
        break;
      case TooManyRequestException:
        exec = {
          'statusCode': 429,
          'message': exception.toString(),
        };
        break;
      case ValidationException:
        exec = {
          'statusCode': 422,
          'message': exception.toString(),
        };
        break;
      case ForceUpdateException:
        exec = {
          'statusCode': 409,
          'message': exception.toString(),
        };
        break;
      case MaintenanceException:
        exec = {
          'statusCode': 503,
          'message': 'Under Maintenance. We will be back soon.', //exception.toString(),
        };
        break;
      default:
        if (kDebugMode) {
          if (exception is TypeError) {
            TypeError err = exception as TypeError;
            exec = {
              'statusCode': -99999,
              'message': '$exception -  ${err.stackTrace}',
            };
            XLogger.error(err.stackTrace);
          } else {
            exec = {
              'statusCode': -99999,
              'message': '$exception -  ${exception.runtimeType}',
            };
          }
        } else {
          exec = {
            'statusCode': 520,
            'message': 'Server error. Please try again later.', //exception.toString(),
          };
        }

        break;
    }
    onFailed(exec['statusCode'], exec['message'], null);
  }
}
