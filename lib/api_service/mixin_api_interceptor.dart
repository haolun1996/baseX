part of 'index.dart';

mixin InterceptorMixin {
  DioError onErrorProcess(
    int? statusCode,
    String message,
    RequestOptions requestOptions, {
    int? code,
  }) {
    XHttpType x = XHttpType.fromValue(statusCode, useCustom: !(baseXHttp.runtimeType == BaseXHttp));

    switch (x) {
      case XHttpType.invalidRequest:
        if (code != null && code != 40000) {
          return InvalidRequestException(
            errorMsg: message,
            requestOptions: requestOptions,
            statusCode: code,
          );
        } else {
          return InvalidRequestException(
            errorMsg: message,
            requestOptions: requestOptions,
            statusCode: statusCode,
          );
        }
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
