part of XError;

/// Status Code is 409
/// will throw VersionOutdateException
class VersionOutdateException extends XError {
  VersionOutdateException({
    required super.requestOptions,
    super.errorMsg,
    super.statusCode,
  });

  @override
  String toString() {
    String platformStr = '';
    if (GetPlatform.isIOS) {
      platformStr = 'Please update the app by visiting the App Store';
    } else if (GetPlatform.isAndroid) {
      platformStr = 'Please update the app by visiting the Play Store';
    }

    return errorMsg ?? 'There is a new version available for download! $platformStr';
  }

  @override
  int? getStatusCode() {
    return statusCode;
  }
}
