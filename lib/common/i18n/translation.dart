import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'index.dart';

class Translation extends Translations {
  // 默认语言 Locale(语言代码, 国家代码)
  static const fallbackLocale = Locale('en');

  static const supportedLocales = [
    Locale('zh'),
    Locale('en'),
    Locale('es'),
  ];

  @override
  Map<String, Map<String, String>> get keys => {
        'zh': zh,
        'en': en,
      };

  static const localizationsDelegates = [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];
}
