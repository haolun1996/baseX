part of api_service;

/// [XResponse] is a base response to receive other param exclude data
class XResponse<T> extends XData {
  final String message;
  final dynamic data;

  XResponse({
    required this.message,
    this.data,
  });

  factory XResponse.fromJson(JSON json, {FromJsonM<T>? create}) {
    var jsonData = json['data'];
    return XResponse(
      message: json['message'],
      data: create != null ? create(jsonData) : null,
    );
  }

  @override
  JSON toJson() => {'message': message, 'data': data};
}
