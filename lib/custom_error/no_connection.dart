part of 'index.dart';

/// Status Code is other than status code not listed
/// will throw NoConnectionException
class NoConnectionException extends XError {
  NoConnectionException({
    required super.requestOptions,
    super.errorMsg,
    super.statusCode,
  });

  @override
  String toString() {
    return errorMsg ?? 'No internet connection detected, please try again later.';
  }

  @override
  int? getStatusCode() {
    return statusCode;
  }
}
