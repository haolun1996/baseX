part of api_service;

mixin InterceptorMixin {
  Map<String, String?> header = {
    Headers.acceptHeader: Headers.jsonContentType,
    'App-Version': baseConstant.appVersion.value,
    'Os-Type': GetPlatform.isIOS ? 'ios' : 'android',
    'Label-Version': baseConstant.labelVersion.value,
    'Accept-Language': baseConstant.languageCode.value,
    'Device-Model': baseConstant.deviceModel.value,
    if (baseConstant.deviceId.value != '') 'Device-ID': baseConstant.deviceId.value,
    if (baseConstant.osVersion.value != '') 'Os-Version': baseConstant.osVersion.value,
    // 'Device-Type': Platform.isIOS ? 'ios' : 'android',
    // 'Version-Type': baseConstant.versionType,
    // 'API-Version': baseConstant.api_version,
  };

  DioError onErrorProcess(int? statusCode, String message, RequestOptions requestOptions) {
    XHttpType x = XHttpType.fromValue(statusCode, useCustom: !(baseXHttp.runtimeType == BaseXHttp));

    switch (x) {
      case XHttpType.invalidRequest:
        return InvalidRequestException(
          errorMsg: message,
          requestOptions: requestOptions,
          statusCode: statusCode,
        );
      case XHttpType.unauthorized:
        return UnauthorizedException(
          errorMsg: message,
          requestOptions: requestOptions,
          statusCode: statusCode,
        );
      case XHttpType.notFound:
        return NotFoundException(
          errorMsg: message,
          requestOptions: requestOptions,
          statusCode: statusCode,
        );
      case XHttpType.validationRequest:
        return ValidationException(
          errorMsg: message,
          requestOptions: requestOptions,
          statusCode: statusCode,
        );
      case XHttpType.tooManyRequest:
        return TooManyRequestException(
          errorMsg: message,
          requestOptions: requestOptions,
          statusCode: statusCode,
        );
      case XHttpType.forceUpdate:
        return ForceUpdateException(
          errorMsg: message,
          requestOptions: requestOptions,
          statusCode: statusCode,
        );
      case XHttpType.maintenanceMode:
        return MaintenanceException(
          errorMsg: message,
          requestOptions: requestOptions,
          statusCode: statusCode,
        );
      default:
        return InternalServerErrorException(
          errorMsg: message,
          requestOptions: requestOptions,
          statusCode: statusCode,
        );
    }
  }
}
