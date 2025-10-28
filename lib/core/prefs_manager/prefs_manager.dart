import 'package:event_app/core/resource/constant_manager/constant_manager.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsManager {
  static late SharedPreferences prefs;
  static Future<void> init() async
  {
    prefs = await SharedPreferences.getInstance();
  }
  static void  saveTheme(ThemeMode themeMood) async {
    String currentTheme = themeMood == ThemeMode.light ? "Light" : "Dark";
    prefs.setString(CasheConstant.themeKey, currentTheme);
  }

  static ThemeMode? getSavedTheme(){
    String? savedTheme = prefs.getString(CasheConstant.themeKey);
    if (savedTheme == null) {
      return null;
    } else {
      ThemeMode themeMode = savedTheme == "Light"
          ? ThemeMode.light
          : ThemeMode.dark;
      return themeMode;
    }
  }

 static String? saveLanguage(String newLang)
  {
    prefs.setString(CasheConstant.languageKey, newLang);
  }

  static getSavedLanguage(){
    String? savedLanguage = prefs.getString(CasheConstant.languageKey);
   return savedLanguage;
  }
  static Future<void> setBool(String key, bool value) async {
    await prefs.setBool(key, value);
  }

  static bool getBool(String key, {bool defaultValue = false}) {
    return prefs.getBool(key) ?? defaultValue;
  }
  static Future<void> remove(String key) async {
    await prefs.remove(key);
  }

}
