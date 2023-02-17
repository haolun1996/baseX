import 'dart:convert';
import 'dart:io';

import 'package:baseX/translation/translation.dart';
import 'package:path_provider/path_provider.dart';

class LabelUtilX<T> {
  // write the label into file
  Future<File> writeLabel(String data) async {
    final file = await _labelFile;

    final completeFile = file.writeAsString(data);

    return completeFile;
  }

  // get label version
  Future<String> get labelVersion async {
    try {
      final file = await _labelFile;

      // Read the file.
      String contents = await file.readAsString();

      final parsed = jsonDecode(contents);

      return parsed['latest_label_version'] ?? '1.0.0';
    } catch (e) {
      return '1.0.0';
    }
  }

  Future<List<T>> getLabels() async {
    try {
      final file = await _labelFile;
      // Read the file.
      String contents = await file.readAsString();

      final parsed = jsonDecode(contents);

      final parsedLabel = parsed;

      return parsedLabel.map<T>((json) => appTranslationX?.fromJson(json)).toList();
    } catch (e) {
      print(e);
      return [];
    }
  }

  // get document path
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  // get the label file
  static Future<File> get _labelFile async {
    final path = await _localPath;
    return File('$path/label.txt');
  }
}
