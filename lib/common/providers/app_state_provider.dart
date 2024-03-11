import 'package:flutter/material.dart';

class AppStateProvider extends ChangeNotifier {
  int _theme = 1;
  String _languageCode = 'en';

  AppStateProvider({int theme = 1, String language = 'en', String countryCode = 'IN'}) {
    _theme = theme;
  }

  Brightness get theme {
    Brightness systemTheme = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    return _theme == 2 ? systemTheme : _theme == 0 ? Brightness.dark : Brightness.light;
  }

  int get themeMode => _theme;

  String get languageCode => _languageCode;

  void updateTheme(int theme) {
    _theme = theme;
    notifyListeners();
  }

  void setInitialAppTheme(int theme) {
    _theme = theme;
  }

  void updateLanguage(String code) {
    if (_languageCode == code) {
      return;
    }
    _languageCode = code;
    notifyListeners();
  }
}
