part of 'index.dart';

/// Status Code is 401
/// will throw UnauthorizedException
class UnauthorizedException extends XError {
  UnauthorizedException({
    required super.requestOptions,
    super.errorMsg,
    super.statusCode,
  });

  @override
  String toString() {
    return errorMsg ?? 'Access token has expired, please proceed to login';
  }

  @override
  int? getStatusCode() {
    return statusCode;
  }
}
