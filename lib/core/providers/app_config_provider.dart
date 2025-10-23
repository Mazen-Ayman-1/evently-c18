import 'package:flutter/material.dart';

class AppConfigProvider extends ChangeNotifier {
  ThemeMode appTheme = ThemeMode.light;
  String locale = "en";

  void changeLocale(String newLocale){
    if(locale == newLocale) return;
    locale = newLocale;
    notifyListeners();
  }

  void changeTheme(ThemeMode newTheme) {
    if (newTheme == appTheme) return;
    appTheme = newTheme;
    notifyListeners();
  }

  bool isDark(){
    return appTheme == ThemeMode.dark;
  }

  bool isEn(){
    return locale == "en";
  }
}
