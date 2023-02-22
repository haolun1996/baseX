import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import 'package:baseX/Core/index.dart';
import 'package:baseX/model/index.dart';

//  XLangController<TestLable, TestLanguage> langc = Get.find();
//  XLangController is used just can overwrite those method
// class LanguageController<T extends XLabel, K extends XLanguage>
//    extends XLangController<TestLable, TestLanguage> {
//   @override
//   void onInit() {
//     super.onInit();
//     init();
//   }

//   void init() async {
//     super.initData(create: (JSONLIST data) => XLabel.listFromJson(data));
//   }

//   @override
//   List<LanguageX> get languageList => [
//         LanguageX('English', Locale('en')),
//         LanguageX('简体中文', Locale('zh')),
//         LanguageX('Bahasa Malaysia', Locale('ms')),
//       ];
// }

abstract class XLangController<T extends XLabel, K extends XLanguage> extends GetxService {
  List<T> labels = [];
  List<K> get languageList;

  String? _labelVersion;

  FromJsonM<JSONLIST>? create;

  @override
  void onInit() {
    super.onInit();
    XLogger.info('XLangController is initialized.');
    // initData();
  }

  void initData({required FromJsonM<JSONLIST> create}) async {
    this.create = create;
    if (labels.isEmpty) {
      labels = await getLabels();
    }
    if (X?.languageCode != null) {
      changeLanguage(X!.languageCode);
    }
  }

  Future<List<T>> getLabels() async {
    try {
      File file = await _labelFile;

      String fileContent = await file.readAsString();

      final parsedJson = jsonDecode(fileContent);

      _labelVersion ??= parsedJson['latest_label_version'] ?? '1.0.0';

      if (parsedJson != null) {
        return create!(parsedJson['labels']);
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  void changeLanguage(Locale locale) async {
    X?.languageCode = locale;
    // baseConstant.languageCode.value = locale;
    Get.updateLocale(locale);
  }

  /// write the label into file
  Future<File> writeLabel(String data) async {
    File file = await _labelFile;
    File completeFile = await file.writeAsString(data);

    return completeFile;
  }

  // get the label file
  Future<File> get _labelFile async {
    Directory directory = await getApplicationDocumentsDirectory();

    File tempFile = File('${directory.path}/label.txt');
    if (tempFile.existsSync()) {
      return tempFile;
    } else {
      return await tempFile.create();
    }
  }

  // get label version
  String get labelVersion {
    return _labelVersion!;
  }

  String? translate(String key) {
    try {
      String? value;
      if (Get.locale!.languageCode == 'en') {
        value = labels.firstWhere((item) => item.key == key).enValue;
      } else if (Get.locale!.languageCode == 'ms') {
        value = labels.firstWhere((item) => item.key == key).bmValue;
      } else {
        value = labels.firstWhere((item) => item.key == key).cnValue;
      }

      return value;
    } catch (e) {
      return null;
    }
  }
}
