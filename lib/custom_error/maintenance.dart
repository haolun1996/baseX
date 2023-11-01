part of 'index.dart';

/// Status Code is 503
/// will throw MaintenanceException
class MaintenanceException extends XError {
  MaintenanceException({
    required super.requestOptions,
    super.errorMsg,
    super.statusCode,
  });

  @override
  String toString() {
    return errorMsg ?? 'Engage Life is currently down for maintenance.';
  }

  @override
  int? getStatusCode() {
    return statusCode;
  }
}
