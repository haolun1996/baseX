part of model;

class XLabel extends XData {
  final String? key;
  final String? enValue;
  final String? bmValue;
  final String? cnValue;

  XLabel({required this.key, this.enValue, this.bmValue, this.cnValue});

  factory XLabel.fromJson(Map<String, dynamic> json) {
    return XLabel(
      key: json['key'],
      enValue: json['en'],
      bmValue: json['bm'],
      cnValue: json['cn'],
    );
  }

  static List<XLabel> listFromJson(List json) {
    List<XLabel> list = [];
    for (var item in json) {
      list.add(XLabel.fromJson(item));
    }
    return list;
  }

  @override
  JSON toJson() => {
        'key': key,
        'enValue': enValue,
        'bmValue': bmValue,
        'cnValue': cnValue,
      };
}
