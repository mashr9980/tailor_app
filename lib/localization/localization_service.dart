
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../language/ar_ku.dart';
import '../language/en_us.dart';
var text_direction = TextDirection.ltr;
var text_direction_fix = TextDirection.ltr;
var text_align = TextAlign.left;
class LocalizationService extends Translations {
  // Default locale
  static final locale = Locale('en', 'US');

  // fallbackLocale saves the day when the locale gets in trouble
  static final fallbackLocale = Locale('ar', 'AR');


  // Supported languages
  // Needs to be same order with locales
  static final langs = [
    'English',
    'Arabic',
  ];

  // Supported locales
  // Needs to be same order with langs
  static final locales = [
    Locale('en', 'US'),
    Locale('ar', 'AR'),
  ];

  // Keys and their translations
  // Translations are separated maps in `lang` file
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': enUS, // lang/en_us.dart
    'ar_AR': arAR, // lang/tr_tr.dart
  };

  // Gets locale from language, and updates the locale
  void changeLocale(String lang) {
    if(lang=="English"){
      text_align = TextAlign.left;
      text_direction=TextDirection.ltr;
    }
    else{
      text_align = TextAlign.right;
      text_direction=TextDirection.rtl;
    }
    final locale = _getLocaleFromLanguage(lang);

    Get.updateLocale(locale!);
  }

  // Finds language in `langs` list and returns it as Locale
  Locale? _getLocaleFromLanguage(String lang) {
    for (int i = 0; i < langs.length; i++) {
      if (lang == langs[i]) return locales[i];
    }
    return Get.locale;
  }
}
