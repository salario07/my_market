import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_market/helper/app_colors.dart';

import 'helper/localization_service.dart';
import 'widget/ui/splash.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      locale: LocalizationService.defaultLocale,
      fallbackLocale: LocalizationService.fallbackLocale,
      translations: LocalizationService(),
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: AppColors.myPrimaryColor,
      ),
      home: Splash(),
    );
  }
}
