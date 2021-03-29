import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_market/generated/locales.g.dart';
import 'package:my_market/helper/app_colors.dart';
import 'package:my_market/widget/ui/home_page.dart';
import 'package:my_market/widget/ui/login.dart';
import 'sign_up.dart';

class Splash extends StatelessWidget {
  Splash() {
    navigateToLogin();
  }

  void navigateToLogin() {
    Future.delayed(Duration(seconds: 1)).then((value) {
      //Get.off(() => Login());
      Get.off(() => HomePage());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorPrimary,
      body: Container(
        child: Center(
          child: Column(
            children: [
              //TODO add image
              /*Image.asset(
                'assets/images/cart.svg',
                width: 120,
                height: 120,
              ),*/
              SizedBox(height: 32),
              Text(LocaleKeys.shared_app_name.tr,
                  style: TextStyle(
                      color: AppColors.colorTextOnPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 22)),
              SizedBox(height: 16),
              Text(LocaleKeys.shared_app_description.tr,
                  style: TextStyle(
                      color: AppColors.colorTextOnPrimary, fontSize: 17)),
            ],
          ),
        ),
      ),
    );
  }
}
