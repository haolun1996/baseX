import 'package:flutter/material.dart';

import 'package:get/get.dart';

void changeDarkMode() {
  ThemeMode themeData = ThemeMode.light;
  if (Get.context!.isDarkMode) {
    themeData = ThemeMode.light;
  } else {
    themeData = ThemeMode.dark;
  }
  Get.changeThemeMode(themeData);
  print(Get.context!.isDarkMode);
}

/// Light Color, Dark Color
// Color setDarkModeColor(Color lightColor, Color darkColor) {
  
//   if (context == null) return lightColor;
//   return Get.theme
//       .copyWith(primaryColor: Get.context!.isDarkMode ? darkColor : lightColor)
//       .primaryColor;
// }
