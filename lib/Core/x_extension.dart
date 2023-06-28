import 'package:flutter/material.dart';

import 'package:baseX/Core/x_get_app.dart';
import 'package:intl/intl.dart';

extension TextUtilsStringExtension on String? {
  /// Returns true if string is:
  /// - null
  /// - empty
  /// - whitespace string.
  bool get isStringNullEmpty => this == null || this!.isEmpty || this!.trim().isEmpty;

  /// Returns true if string is NOT:
  /// - null
  /// - empty
  /// - whitespace string.
  bool get isStringNotNullEmpty => this != null && this!.isNotEmpty && this!.trim().isNotEmpty;

  String? firstCap() {
    if (isStringNullEmpty) return null;
    return '${this![0].toUpperCase()}${this!.substring(1).toLowerCase()}';
  }

  String? toTitleCase() {
    if (isStringNullEmpty) return null;
    return this!.replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.firstCap()).join(' ');
  }

  String? get xtr {
    return defaultLangController?.translate(this!);
  }

  String get lr {
    return defaultLangController?.translate(this!) ?? this!;
  }
}

extension GeneralUtilsObjectExtension on Object? {
  /// Returns true if object is:
  /// - null `Object`
  /// - empty `String`
  /// - empty `Iterable` (list, set, ...)
  /// - empty `Map`
  bool get isObjectNullEmpty =>
      _isNull || _isStringObjectEmpty || _isIterableObjectEmpty || _isMapObjectEmpty;

  /// Returns true if object is:
  /// - null `Object`
  /// - empty `String`
  /// - empty `Iterable` (list, map, set, ...)
  /// - false `bool`
  // bool get isNullEmptyOrFalse => isNull || _isStringObjectEmpty || _isIterableObjectEmpty || _isMapObjectEmpty || _isBoolObjectFalse;

  /// Returns true if object is:
  /// - null `Object`
  /// - empty `String`
  /// - empty `Iterable` (list, map, set, ...)
  /// - false `bool`
  /// - zero `num`
  // bool get isNullEmptyFalseOrZero => isNull || _isStringObjectEmpty || _isIterableObjectEmpty || _isMapObjectEmpty || _isBoolObjectFalse || _isNumObjectZero;

  // ------- PRIVATE EXTENSION HELPERS -------
  /// **Private helper**
  ///
  /// Returns true if object is:
  ///
  /// - null `Object`
  /// - null `String`
  bool get _isNull => this == null;

  /// **Private helper**
  ///
  /// If `String` object, return String's method `isEmpty`
  ///
  /// Otherwise return `false` to not affect logical-OR expression. As `false` denotes undefined or N/A since object is not `String`
  bool get _isStringObjectEmpty => (this is String) ? (this as String).isEmpty : false;

  /// **Private helper**
  ///
  /// If `Iterable` object, return Iterable's method `isEmpty`
  ///
  /// Otherwise return `false` to not affect logical-OR expression. As `false` denotes undefined or N/A since object is not `Iterable`
  bool get _isIterableObjectEmpty => (this is Iterable) ? (this as Iterable).isEmpty : false;

  /// **Private helper**
  ///
  /// If `Map` object, return Map's method `isEmpty`
  ///
  /// Otherwise return `false` to not affect logical-OR expression. As `false` denotes undefined or N/A since object is not `Map`
  bool get _isMapObjectEmpty => (this is Map) ? (this as Map).isEmpty : false;

  /// **Private helper**
  ///
  /// If `bool` object, return `isFalse` expression
  ///
  /// Otherwise return `false` to not affect logical-OR expression. As `false` denotes undefined or N/A since object is not `bool`
  // bool get _isBoolObjectFalse => (this is bool) ? (this as bool) == false : false;

  /// **Private helper**
  ///
  /// If `num` object, return `isZero` expression
  ///
  /// Otherwise return `false` to not affect logical-OR expression. As `false` denotes undefined or N/A since object is not `num`
  // bool get _isNumObjectZero => (this is num) ? (this as num) == 0 : false;
}

extension Unique<E, Id> on List<E> {
  List<E> unique([Id Function(E element)? id, bool inplace = true]) {
    final ids = <dynamic>{};
    var list = inplace ? this : List<E>.from(this);
    list.retainWhere((x) => ids.add(id != null ? id(x) : x as Id));
    return list;
  }
}

extension DateTimeExtension on DateTime {
  String convertToAgo() {
    Duration diff = DateTime.now().difference(this);

    if (diff.inDays > 1) {
      return "${DateFormat("dd MMM yyyy").format(this)} at ${DateFormat("h:mm a").format(this)}";
    } else if (diff.inDays == 1) {
      return '${diff.inDays} day(s) ago';
    } else if (diff.inHours >= 1) {
      return '${diff.inHours} hour(s) ago';
    } else if (diff.inMinutes >= 1) {
      return '${diff.inMinutes} minute(s) ago';
    } else if (diff.inSeconds >= 1) {
      return '${diff.inSeconds} second(s) ago';
    } else {
      return 'just now';
    }
  }
}

extension HexColorOnNull on Color? {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String? hexString) {
    assert(hexString.isStringNullEmpty, 'hexString is required in Color');
    assert(hexString!.length != 7 || !hexString.contains('#'), 'hexString must include with #');
    // if (hexString == null) return null;
    // if (hexString.length != 7 && !hexString.contains('#')) return null;
    final buffer = StringBuffer();
    buffer.write('ff');
    buffer.write(hexString!.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
