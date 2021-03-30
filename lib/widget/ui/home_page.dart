import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_market/controller/home_page_controller.dart';
import 'package:my_market/generated/locales.g.dart';
import 'package:my_market/helper/app_colors.dart';
import 'package:my_market/widget/ui/item_category.dart';
import 'package:my_market/widget/ui/item_product.dart';
import 'package:number_picker/number_picker.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut<HomePageController>(() => HomePageController());
    return Scaffold(
      backgroundColor: AppColors.colorBackground,
      appBar: AppBar(
        title: Text(LocaleKeys.shared_app_name.tr),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(LocaleKeys.home_page_categories.tr,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15))),
              Flexible(
                fit: FlexFit.loose,
                flex: 1,
                child: Obx(
                  () => ListView.builder(
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
                  child: Text(LocaleKeys.home_page_populars.tr,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15))),
              Flexible(
                fit: FlexFit.tight,
                flex: 6,
                child: Obx(
                  () => GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.all(8),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemBuilder: (context, index) =>
                        ItemProduct(_controller.products()[index]),
                    scrollDirection: Axis.vertical,
                    itemCount: _controller.products().length,
                  ),
                ),
              ),
              SizedBox(height: 16)
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 160,
              child: ColoredBox(color: AppColors.colorPrimary),
            ),
            buildDrawerItem(Icons.home, LocaleKeys.home_page_home.tr, () => Get.back(), true),
            Divider(height: 1, color: AppColors.colorDivider),
          ],
        ),
      ),
    );
  }

  InkWell buildDrawerItem(
      IconData iconData, String text, Function() onTap, bool isHome) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(iconData,
                color:
                    isHome ? AppColors.colorPrimary : AppColors.colorDivider),
            SizedBox(width: 8),
            Text(text)
          ],
        ),
      ),
    );
  }

  HomePageController get _controller => Get.find<HomePageController>();
}
