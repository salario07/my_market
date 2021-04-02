import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:my_market/generated/locales.g.dart';
import 'package:my_market/helper/app_colors.dart';
import 'package:my_market/helper/constants.dart';
import 'package:my_market/helper/localization_service.dart';

class Helper {
  static bool isNullOrEmpty(String text) {
    return text == null || text.isEmpty;
  }

  static void logDebug(String text, {String className = ''}) {
    print('${Constants.debug_tag} $className : $text');
  }

  static void successSnackBar(String title, String text) {
    Get.snackbar(title, text,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.colorSuccess,
        colorText: AppColors.colorOnSuccess,
        margin: EdgeInsets.all(16));
  }

  static void errorSnackBar(String title, String text) {
    Get.snackbar(title, text,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.colorError,
        colorText: AppColors.colorOnError,
        margin: EdgeInsets.all(16));
  }

  static String buildPriceText(String price) {
    if (Get.locale == LocalizationService.locales[0]) {
      return '${LocaleKeys.shared_currency.tr} $price';
    } else {
      return '$price ${LocaleKeys.shared_currency.tr}';
    }
  }

  static bool isSuccessful(int statusCode) {
    return statusCode == 200 || statusCode == 201;
  }


}
