import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_market/helper/app_colors.dart';
import 'package:my_market/helper/constants.dart';
import 'package:my_market/helper/shared_pref.dart';

import 'helper/localization_service.dart';
import 'widget/ui/splash.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      locale: getLocale(),
      fallbackLocale: LocalizationService.fallbackLocale,
      translations: LocalizationService(),
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: AppColors.myPrimaryColor,
      ),
      home: Splash(),
    );
  }

  Locale getLocale() {
    String locale = SharedPref?.getLocale() ?? Constants.locale_english;
    if (locale == Constants.locale_persian) {
      return LocalizationService.locales[1];
    } else {
      return LocalizationService.locales[0];
    }
  }
}
