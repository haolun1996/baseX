part of 'index.dart';

class DefaultBaseXHttp extends BaseXHttp {}

/// [BaseXHttp] is abstract class to let external to be override
/// for certain value
abstract class BaseXHttp {
  int get unknown => -1;
  int get forceUpdate => 426;
  int get internalserver => 500;
  int get invalidRequest => 400;
  int get maintenanceMode => 503;
  int get notFound => 404;
  int get tooManyRequest => 429;
  int get unauthorized => 401;
  int get validationRequest => 422;
  int get versionOutdate => 409;
}

enum XHttpType {
  unknown(-1),
  forceUpdate(426),
  internalserver(500),
  invalidRequest(400),
  maintenanceMode(503),
  notFound(404),
  tooManyRequest(429),
  unauthorized(401),
  validationRequest(422),
  versionOutdate(409),
  ;

  final int value;
  const XHttpType(this.value);

  factory XHttpType.fromValue(int? value, {bool useCustom = false}) =>
      values.firstWhere((x) => x.codeX(useCustom) == value, orElse: () => unknown);

  int defaultCodeX() {
    return value;
  }

  int customCodeX() {
    switch (this) {
      case XHttpType.forceUpdate:
        return baseXHttp.forceUpdate;
      case XHttpType.internalserver:
        return baseXHttp.internalserver;
      case XHttpType.invalidRequest:
        return baseXHttp.invalidRequest;
      case XHttpType.maintenanceMode:
        return baseXHttp.maintenanceMode;
      case XHttpType.notFound:
        return baseXHttp.notFound;
      case XHttpType.tooManyRequest:
        return baseXHttp.tooManyRequest;
      case XHttpType.unauthorized:
        return baseXHttp.unauthorized;
      case XHttpType.validationRequest:
        return baseXHttp.validationRequest;
      case XHttpType.versionOutdate:
        return baseXHttp.versionOutdate;
      case XHttpType.unknown:
        return baseXHttp.unknown;
      default:
        return XHttpType.unknown.value;
    }
  }

  int codeX(bool useCustom) {
    if (useCustom) {
      return customCodeX();
    } else {
      return defaultCodeX();
    }
  }
}
