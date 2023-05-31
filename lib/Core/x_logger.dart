import 'package:flutter/material.dart';

enum LogType { error, warning, success, response }

class XLogger {
  /// ASCII for ESCAPE (ESC key on your keyboard)
  static const String _ansiEsc = '\x1b[';

  static const String _endingAnsi = '${_ansiEsc}0m';

  /// _foreground code with color
  static const String _foreground = '38;5;';

  /// _background code with color
  static const String _background = '48;5;';

  /// _background code with color
  static const String _bold = '1';

  static const String _darkGreyInBit = '37;';

  /// Yellow text
  /// param [msg] is the message to be logged to the console
  static void warning(Object? msg, {String? className}) {
    String text = 'WARNING';
    String result = '';

    if (className != null) {
      result = _orangeBackground(className);
    }

    result += ' ${_yellowBackground(text)}';

    debugPrint('$result $msg');
  }

  static String _yellowBackground(String text) {
    String colorInBit = '220';
    return _makeBackground(text, _darkGreyInBit, colorInBit);
  }

  /// Blue text
  /// param [msg] is the message to be logged to the console
  static void info(Object? msg, {String? className}) {
    String text = 'INFO';
    String result = '';

    if (className != null) {
      result = _orangeBackground(className);
    }

    result += ' ${_blueBackground(text)}';
    debugPrint('$result $msg');
  }

  static String _blueBackground(String text) {
    String colorInBit = '39';
    return _makeBackground(text, _darkGreyInBit, colorInBit);
  }

  /// Green text
  /// param [msg] is the message to be logged to the console
  static void success(Object? msg, {String? className}) {
    String text = 'SUCCESS';
    String result = '';

    if (className != null) {
      result = _orangeBackground(className);
    }

    result += ' ${_greenBackground(text)}';

    debugPrint('$result $msg');
  }

  /// Red text
  /// param [msg] is the message to be logged to the console
  static void error(Object? msg, {String? className}) {
    String text = 'ERROR';
    String result = '';

    if (className != null) {
      result = _orangeBackground(className);
    }

    result += ' ${_redBackground(text)}';

    debugPrint('$result $msg');
  }

  static String _redBackground(String text) {
    String colorInBit = '124';
    return _makeBackground(text, _darkGreyInBit, colorInBit);
  }

  static String _redForeground(String text) {
    String colorInBit = '124';
    return _makeForeground(text, colorInBit);
  }

  static String _orangeBackground(String text) {
    String colorInBit = '202';
    return _makeBackground(text, _darkGreyInBit, colorInBit);
  }

  static String _orangeForeground(String text) {
    String colorInBit = '202';
    return _makeForeground(text, colorInBit);
  }

  static String _greenBackground(String text) {
    String colorInBit = '41';
    return _makeBackground(text, _darkGreyInBit, colorInBit);
  }

  static String _greenForeground(String text) {
    String colorInBit = '41';
    return _makeForeground(text, colorInBit);
  }

  static void _body(String text, LogType type) {
    if (type == LogType.response) {
      debugPrint(_orangeForeground(text));
    } else if (type == LogType.error) {
      debugPrint(_redForeground(text));
    } else if (type == LogType.success) {
      debugPrint(_greenForeground(text));
    }
  }

  static void _header(String mid, LogType type,
      {String start = '══════════━━━━━━━━━━', String end = '━━━━━━━━━━━━════════════'}) {
    if (type == LogType.response) {
      debugPrint('${_orangeBackground(start)} ${_orangeForeground(mid)} ${_orangeBackground(end)}');
    } else if (type == LogType.error) {
      debugPrint('${_redBackground(start)} ${_redForeground(mid)} ${_redBackground(end)}');
    } else if (type == LogType.success) {
      debugPrint('${_greenBackground(start)} ${_greenForeground(mid)} ${_greenBackground(end)}');
    }
  }

  static reqBody(String text) {
    return _body(text, LogType.success);
  }

  static void reqHead(String mid) {
    return _head(mid, LogType.success);
  }

  static void reqTail(String mid) {
    return _tail(mid, LogType.success);
  }

  static resBody(String text) {
    return _body(text, LogType.response);
  }

  static void resHead(String mid) {
    return _head(mid, LogType.response);
  }

  static void resTail(String mid) {
    return _tail(mid, LogType.response);
  }

  static void _head(String mid, LogType type, {String start = '╔══════════━━━━━━━━━━━'}) {
    return _header(mid, type, start: start);
  }

  static void _tail(String mid, LogType type, {String start = '╚══════════━━━━━━━━━━━'}) {
    return _header(mid, type, start: start);
  }

  static errorBody(String text) {
    return _body(text, LogType.error);
  }

  static void errorHead(String mid) {
    return _head(mid, LogType.error);
  }

  static void errorTail(String mid) {
    return _tail(mid, LogType.error);
  }

  static String _makeBackground(String text, String _foregroundColor, String _backgroundColor) {
    return '$_ansiEsc$_foreground${_setForegroundColor(_foregroundColor)}$_bold;$_background${_setBackgroundColor(_backgroundColor)}$text$_endingAnsi';
  }

  static String _makeForeground(String text, String _foregroundColor) {
    return '$_ansiEsc$_foreground${_setForegroundColor(_foregroundColor)}${_bold}m$text$_endingAnsi';
  }

  static String _setForegroundColor(String colorInBit) {
    return '$colorInBit;';
  }

  static String _setBackgroundColor(String colorInBit) {
    return '${colorInBit}m';
  }

// static String getEmoji(LogStatus status) {
//     switch (status) {
//       case LogStatus.success:
//         return '🟢';
//       case LogStatus.error:
//         return '🔴';
//       case LogStatus.warning:
//         return '🟠';
//       case LogStatus.info:
//         return '🟣';
//       case LogStatus.debug:
//         return '🔵';
//       case LogStatus.none:
//       default:
//         return '⚪️';
//     }
//   }
}
