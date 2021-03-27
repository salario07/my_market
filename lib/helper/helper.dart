import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:my_market/helper/app_colors.dart';
import 'package:my_market/helper/constants.dart';

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
}
