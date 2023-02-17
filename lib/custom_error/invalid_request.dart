part of XError;

/// Status Code is 400 will throw InvalidRequestException.
/// - message from server is not empty will throw error message
/// - else if message from server  is empty will not throw error message
class InvalidRequestException extends XError {
  InvalidRequestException({
    required super.requestOptions,
    super.errorMsg,
    super.statusCode,
  });

  @override
  String toString() {
    return errorMsg ?? 'Invalid data, please enter the correct data';
  }

  @override
  int? getStatusCode() {
    return statusCode;
  }
}
