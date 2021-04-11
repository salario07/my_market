import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_market/controller/categories_controller.dart';
import 'package:my_market/generated/locales.g.dart';
import 'package:my_market/helper/app_colors.dart';
import 'package:my_market/helper/helper.dart';
import 'package:my_market/widget/component/my_progress_indicator.dart';
import 'package:my_market/widget/component/text_content.dart';

import 'dialog_ask.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut<CategoriesController>(() => CategoriesController());
    return Scaffold(
      backgroundColor: AppColors.colorBackground,
      appBar: AppBar(
        title: Text(LocaleKeys.home_page_categories.tr),
      ),
      body: Container(
        child: Obx(
          () => _controller.isLoading()
              ? Center(child: MyProgressIndicator(40))
              : ListView.builder(
                  itemBuilder: (context, index) {
                    return buildCategoryItem(index);
                  },
                  itemCount: _controller.categories().length,
                  padding: EdgeInsets.all(8),
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: showDialogAddCategory,
      ),
    );
  }

  Widget buildCategoryItem(int index) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 16),
          Expanded(
              child: TextContent(Helper.isLocaleEnglish()
                  ? _controller.categories().elementAt(index).name
                  : _controller.categories().elementAt(index).persianName)),
          IconButton(
              icon: Icon(
                Icons.delete_forever,
                color: AppColors.colorError,
              ),
              onPressed: askToDeleteCategory),
          IconButton(
              icon: Icon(
                Icons.edit,
                color: AppColors.colorSecondary,
              ),
              onPressed: showDialogEditCategory),
        ],
      ),
    );
  }

  void showDialogAddCategory() {}

  void askToDeleteCategory() {
    showDialog(
      context: Get.context,
      builder: (context) => DialogAsk(
        title: LocaleKeys.shared_delete.tr,
        message: LocaleKeys.categories_sure_to_delete_category.tr,
        positive: LocaleKeys.shared_delete.tr,
        negative: LocaleKeys.shared_cancel.tr,
        onPositiveTap: deleteCategory,
      ),
    );
  }

  void showDialogEditCategory() {}

  void deleteCategory() {}

  CategoriesController get _controller => Get.find<CategoriesController>();
}
