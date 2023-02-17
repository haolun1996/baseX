import 'package:baseX/base_x.dart';
import 'package:flutter/material.dart';

class AppLocalizationsX<T> {
  final LabelUtilX labelUtil = LabelUtilX<T>();

  AppLocalizationsX();

  // Helper method to keep the code in the widgets concise
  // Localizations are accessed using an InheritedWidget "of" syntax
  static AppLocalizationsX? of(BuildContext context) {
    return Localizations.of<AppLocalizationsX>(context, AppLocalizationsX);
  }

  // Static member to have a simple access to the delegate from the MaterialApp
  LocalizationsDelegate<AppLocalizationsX<T>> delegate = _AppLocalizationsXDelegate();

  List<T> _labels = [];

  Future<bool> load() async {
    print('load');
    // Load the language from file
    _labels = await labelUtil.getLabels() as List<T>;

    return true;
  }

  // This method will be called from every widget which needs a localized text
  String? translate(String key) {
    return appTranslationX?.translate(key, baseConstant.languageCode.value, _labels);
  }
}

class _AppLocalizationsXDelegate<T> extends LocalizationsDelegate<AppLocalizationsX<T>> {
  // This delegate instance will never change (it doesn't even have fields!)
  // It can provide a constant constructor.
  const _AppLocalizationsXDelegate();

  @override
  bool isSupported(Locale locale) {
    // Include all of your supported language codes here
    return ["en"].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizationsX<T>> load(Locale locale) async {
    // AppLocalizations class is where the JSON loading actually runs
    AppLocalizationsX<T> localizations = AppLocalizationsX<T>();
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsXDelegate<T> old) => true;
}
