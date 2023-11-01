part of 'index.dart';

/// Status Code is 404
/// will throw NotFoundException
class NotFoundException extends XError {
  NotFoundException({
    required super.requestOptions,
    super.errorMsg,
    super.statusCode,
  });

  @override
  String toString() {
    return errorMsg ?? 'The requested information could not be found';
  }

  @override
  int? getStatusCode() {
    return statusCode;
  }
}
