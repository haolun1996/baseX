part of 'index.dart';

/// Status Code is DioErrorType sendTimeout / connectTimeout / receiveTimeout
/// will throw TimeOutException
class TimeOutException extends XError {
  TimeOutException({
    required super.requestOptions,
    super.errorMsg,
    super.statusCode,
  });

  @override
  String toString() {
    return errorMsg ?? 'The connection has timed out, please try again later.';
  }

  @override
  int? getStatusCode() {
    return statusCode;
  }
}
