import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  final Locale locale;
  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of(context, AppLocalizations);
  }

  final Map<String, String> _localizedString = {};
  Future<void> load([bool isLocal = false]) async {
    var jsonString = '';

    jsonString = await rootBundle.loadString(
      'assets/languages/${locale.languageCode}.json',
    );

    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    _localizedString.addAll(jsonMap.map(
      (key, value) => MapEntry(key, value.toString()),
    ));
  }

  String text(String key) {
    return _localizedString[key] ?? '';
  }

  static const supportedLocales = [
    Locale('en'),
    Locale('ta'),
  ];

  static Locale? localeResolutionCallBack(Locale? locale, Iterable<Locale> supportedLocales) {
    if (locale != null) {
      return supportedLocales.firstWhere((element) => element.languageCode == locale.languageCode, orElse: () => supportedLocales.first);
    }

    return null;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _LocalizationServiceDelegate();
  static const LocalizationsDelegate<AppLocalizations> fileDelegate = LocalizationFileDelegate();
}

class _LocalizationServiceDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _LocalizationServiceDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations service = AppLocalizations(locale);
    await service.load();
    return service;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) {
    return false;
  }
}

class LocalizationFileDelegate extends LocalizationsDelegate<AppLocalizations> {
  const LocalizationFileDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations service = AppLocalizations(locale);
    await service.load();
    return service;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) {
    return false;
  }
}
