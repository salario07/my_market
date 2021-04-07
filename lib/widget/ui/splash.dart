import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_market/generated/locales.g.dart';
import 'package:my_market/helper/app_colors.dart';
import 'package:my_market/helper/shared_pref.dart';
import 'package:my_market/widget/ui/home_page.dart';
import 'package:my_market/widget/ui/home_page_admin.dart';
import 'package:my_market/widget/ui/login.dart';

import '../../helper/constants.dart';
import '../../helper/shared_pref.dart';

class Splash extends StatelessWidget {
  Splash() {
    navigate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorPrimary,
      body: Container(
        height: double.infinity,
        child: buildBrandInfo(),
      ),
    );
  }

  Center buildBrandInfo() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildIcon(),
          SizedBox(height: 32),
          buildTitleText(),
          SizedBox(height: 16),
          buildDescriptionText(),
        ],
      ),
    );
  }

  Icon buildIcon() {
    return Icon(Icons.shopping_cart_sharp,
        color: AppColors.colorTextOnPrimary, size: 144);
  }

  Text buildTitleText() {
    return Text(LocaleKeys.shared_app_name.tr,
        style: TextStyle(
            color: AppColors.colorTextOnPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 22));
  }

  Text buildDescriptionText() {
    return Text(LocaleKeys.shared_app_description.tr,
        style: TextStyle(color: AppColors.colorTextOnPrimary, fontSize: 17));
  }

  void navigate() {
    Future.delayed(Duration(seconds: Constants.splash_delay_seconds))
        .then((value) {
      if (!SharedPref.isUserLoggedIn()) {
        Get.off(() => Login());
      } else if (SharedPref.isUserAdmin()) {
        Get.off(() => HomePageAdmin());
      } else {
        Get.off(() => HomePage());
      }
    });
  }
}
