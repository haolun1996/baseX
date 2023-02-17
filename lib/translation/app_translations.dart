import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:baseX/base_x.dart';

class LanguageModel {
  final String title;
  final String code;
  LanguageModel({
    required this.title,
    required this.code,
  });
}

AppTranslationX? appTranslationX;

abstract class AppTranslationX<T> {
  Locale? appLocale;

  List<LanguageModel> get languageList;

  String? translate(String key, String languageCode, List<T> list);

  T? fromJson(dynamic source);

  // void onLanguageChanged(String languageCode);

  AppLocalizationsX<T> appLocalizationsX = AppLocalizationsX<T>();

  List<String> getLanguageList() {
    return languageList.map((e) => e.code).toList();
  }

  Future<File> writeLabel(String data) async {
    return await appLocalizationsX.labelUtil.writeLabel(data);
  }

  Locale? fetchLocale() {
    appLocale = Locale(X?.languageCode ?? 'en');
    return appLocale;
  }

  String fetchLanguageCode() {
    return X?.languageCode ?? 'en';
  }

  void changeLanguage(String langCode) async {
    appLocale = Locale(langCode);
    // onLanguageChanged(langCode);
    X?.languageCode = langCode;
    baseConstant.languageCode.value = langCode;
    Get.updateLocale(appLocale!);
  }
}
