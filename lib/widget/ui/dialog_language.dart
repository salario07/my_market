import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_market/helper/app_colors.dart';
import 'package:my_market/helper/constants.dart';
import 'package:my_market/helper/dimens.dart';
import 'package:my_market/helper/localization_service.dart';
import 'package:my_market/helper/shared_pref.dart';
import 'package:my_market/widget/component/text_content.dart';

class DialogLanguage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(Dimens.dialog_border_radius))),
      child: buildContent(),
    );
  }

  Padding buildContent() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildEnglishButton(),
          Divider(
            color: AppColors.colorDivider,
          ),
          buildPersianButton(),
        ],
      ),
    );
  }

  InkWell buildEnglishButton() {
    return InkWell(
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                TextContent(
                  'English',
                  textAlign: TextAlign.left,
                ),
              ],
            )),
        onTap: selectEnglish);
  }

  InkWell buildPersianButton() {
    return InkWell(
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
            TextContent('فارسی', textAlign: TextAlign.right),
              ],
            )),
        onTap: selectPersian);
  }

  void selectEnglish() {
    if (Get.locale != LocalizationService.locales[0]) {
      SharedPref.setLocale(Constants.locale_english);
      LocalizationService.changeLocale(LocalizationService.locales[0]);
      Get.back();
    } else {
      Get.back();
    }
  }

  void selectPersian() {
    if (Get.locale != LocalizationService.locales[1]) {
      SharedPref.setLocale(Constants.locale_persian);
      LocalizationService.changeLocale(LocalizationService.locales[1]);
      Get.back();
    } else {
      Get.back();
    }
  }
}
