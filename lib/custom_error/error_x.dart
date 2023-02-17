part of XError;

/// [XError] is base error class to throw for unhandled statusCode return default -1
abstract class XError extends DioError {
  final String? errorMsg;

  int? statusCode = -1;

  XError({
    required super.requestOptions,
    this.errorMsg,
    this.statusCode,
  });

  @override
  String toString() {
    return errorMsg!;
  }

  int? getStatusCode();
}
