part of 'index.dart';

/// Status Code is 500
/// will throw InternalServerErrorException
class InternalServerErrorException extends XError {
  InternalServerErrorException({
    required super.requestOptions,
    super.errorMsg,
    super.statusCode,
  });

  @override
  String toString() {
    return errorMsg ?? 'Something have went wrong, please try again later';
  }

  @override
  int? getStatusCode() {
    return statusCode;
  }
}
