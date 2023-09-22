import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_localizations_delegate.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of(context, AppLocalizations);
  }

  static LocalizationsDelegate<AppLocalizations> delegate =
      AppLocalizationsDelegate();

  late Map<String, Map<String, String>> _localizedString;

  Future<void> load() async {
    // String filename = locale.languageCode == 'vi' ? "st_vi_vn" : "st_en_us";
    String filename = "dictionary";

    String jsonString =
        await rootBundle.loadString('assets/languages/$filename.json');
    // Map<String, dynamic> jsonMap = json.decode(jsonString);
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    // _localizedString = jsonMap
    //     .map<String, String>((key, value) => MapEntry(key, value.toString()));
    _localizedString = jsonMap.map<String, Map<String, String>>((key, value) {
      final Map<String, dynamic> valueJson = json.decode(json.encode(value));
      final Map<String, String> childJson = valueJson
          .map<String, String>((key, value) => MapEntry(key, value.toString()));

      return MapEntry(
        key,
        childJson,
      );
    });
  }

  String translate(String key) =>
      _localizedString[key]?[locale.languageCode] ?? key;

  bool get isVnLocale => locale.languageCode == 'vi';
}
