part of XError;

/// Status Code is 426
/// will throw ForceUpdateException
class ForceUpdateException extends XError {
  ForceUpdateException({
    required super.requestOptions,
    super.errorMsg,
    super.statusCode,
  });

  @override
  String toString() {
    return errorMsg ?? 'New version required to update';
  }

  @override
  int? getStatusCode() {
    return statusCode;
  }
}
