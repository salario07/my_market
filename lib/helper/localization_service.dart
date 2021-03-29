import 'dart:ui';

import 'package:get/get.dart';
import 'package:my_market/generated/locales.g.dart';

class LocalizationService extends Translations {
  Map<String, String>? faIR;
  Map<String, String>? enUS;

  static final defaultLocale = locales[0];

  static final fallbackLocale = locales[0];

  static final locales = [
    Locale('en', 'US'),
    Locale('fa', 'IR'),
  ];

  LocalizationService() {
    faIR = {};
    enUS = {};
    faIR?.addAll(Locales.fa_IR);
    enUS?.addAll(Locales.en_US);
  }

  @override
  Map<String, Map<String, String>?> get keys => {'fa_IR': faIR, 'en_US': enUS};

  void changeLocale(Locale locale) {
    Get.updateLocale(locale);
  }
}
