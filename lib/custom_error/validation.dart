part of 'index.dart';

/// Status Code is 422
/// will throw ValidationException
class ValidationException extends XError {
  ValidationException({
    required super.requestOptions,
    super.errorMsg,
    super.statusCode,
  });

  @override
  String toString() {
    return errorMsg!;
  }

  @override
  int? getStatusCode() {
    return statusCode;
  }
}
