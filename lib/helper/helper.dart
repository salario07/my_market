import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_market/generated/locales.g.dart';
import 'package:my_market/helper/app_colors.dart';
import 'package:my_market/helper/constants.dart';
import 'package:my_market/helper/localization_service.dart';
import 'package:my_market/model/product.dart';

import 'shared_pref.dart';

class Helper {
  static bool isNullOrEmpty(String text) {
    return text == null || text.isEmpty;
  }

  static bool isListNullOrEmpty(List<String> list) {
    return list == null || list.isEmpty;
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

  static String buildPriceText(int price) {
    if (Get.locale == LocalizationService.locales[0]) {
      return '${LocaleKeys.shared_currency.tr} ${addCommaSeparator(price)}';
    } else {
      return '${addCommaSeparator(price)} ${LocaleKeys.shared_currency.tr}';
    }
  }

  static bool isSuccessful(int statusCode) {
    return statusCode == 200 || statusCode == 201;
  }

  static String addCommaSeparator(int price) {
    var formatter = NumberFormat('###,###,###');
    return formatter.format(price);
  }

  static bool isLocaleEnglish() {
    return Get.locale == LocalizationService.locales[0];
  }

  static String removeThousandsCommaSeparator(String text) {
    return text.replaceAll(',', '');
  }

  static int parseNumberTextFieldText(String text) {
    return int.parse(removeThousandsCommaSeparator(text));
  }

  static List<Product> getThisCategoryProductList(
      List<Product> allProducts, int categoryId) {
    List<Product> categorizedProducts = [];
    allProducts.forEach((element) {
      if (element.categoryId == categoryId) {
        categorizedProducts.add(element);
      }
    });
    return categorizedProducts;
  }
}
