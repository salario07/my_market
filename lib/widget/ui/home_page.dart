import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_market/controller/home_page_controller.dart';
import 'package:my_market/generated/locales.g.dart';
import 'package:my_market/helper/app_colors.dart';
import 'package:my_market/widget/ui/item_category.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut<HomePageController>(() => HomePageController());
    return Scaffold(
      backgroundColor: AppColors.colorBackground,
      appBar: AppBar(
        title: Text(LocaleKeys.shared_app_name.tr),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(LocaleKeys.home_page_categories.tr,
                  textAlign: TextAlign.start)),
          Flexible(
            fit: FlexFit.loose,
            child: Obx(
              () => ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.all(8),
                itemBuilder: (context, index) =>
                    ItemCategory(_controller.categories()[index]),
                itemCount: _controller.categories().length,
                scrollDirection: Axis.horizontal,
              ),
            ),
          ),
          SizedBox(height: 16),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(LocaleKeys.home_page_populars.tr)),
          SizedBox(height: 16)
        ],
      ),
    );
  }

  HomePageController get _controller => Get.find<HomePageController>();
}
