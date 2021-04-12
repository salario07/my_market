import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_market/controller/categories_controller.dart';
import 'package:my_market/generated/locales.g.dart';
import 'package:my_market/helper/app_colors.dart';
import 'package:my_market/helper/helper.dart';
import 'package:my_market/helper/json_parser.dart';
import 'package:my_market/model/product.dart';
import 'package:my_market/widget/component/my_divider.dart';
import 'package:my_market/widget/component/my_progress_indicator.dart';
import 'package:my_market/widget/component/text_content.dart';
import 'package:my_market/widget/ui/dialog_add_edit_category.dart';
import 'package:my_market/widget/ui/dialog_category_deletion_warning.dart';

import 'dialog_ask.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut<CategoriesController>(() => CategoriesController());
    return Scaffold(
      backgroundColor: AppColors.colorBackground,
      appBar: buildAppBar(),
      body: buildBody(),
      floatingActionButton: buildFloatingActionButton(),
    );
  }

  Container buildBody() {
    return Container(
      child: Obx(
        () => _controller.isLoading() ? buildLoadingView() : buildListView(),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text(LocaleKeys.home_page_categories.tr),
    );
  }

  FloatingActionButton buildFloatingActionButton() {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: showDialogAddCategory,
    );
  }

  Center buildLoadingView() => Center(child: MyProgressIndicator(40));

  ListView buildListView() {
    return ListView.separated(
      itemBuilder: (context, index) {
        return buildCategoryItem(index);
      },
      itemCount: _controller.categories().length,
      padding: EdgeInsets.all(8),
      separatorBuilder: (context, index) => MyDivider(),
    );
  }

  Widget buildCategoryItem(int index) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 16),
          Expanded(
              child: TextContent(Helper.isLocaleEnglish()
                  ? _controller.categories().elementAt(index).name
                  : _controller.categories().elementAt(index).persianName)),
          buildDeleteButton(index),
          buildEditButton(index),
        ],
      ),
    );
  }

  IconButton buildDeleteButton(int index) {
    return IconButton(
        icon: Icon(
          Icons.delete_forever,
          color: AppColors.colorError,
        ),
        onPressed: () => askToDeleteCategory(index));
  }

  IconButton buildEditButton(int index) {
    return IconButton(
        icon: Icon(
          Icons.edit,
          color: AppColors.colorSecondary,
        ),
        onPressed: () => showDialogEditCategory(index));
  }

  void showDialogAddCategory() {
    showDialog(
      context: Get.context,
      builder: (context) => DialogAddEditCategory(true),
    ).then((value) {
      if (value != null && value) {
        Helper.successSnackBar(LocaleKeys.shared_success.tr,
            LocaleKeys.categories_category_added_successfully.tr);
      }
    });
  }

  void askToDeleteCategory(index) {
    showDialog(
      context: Get.context,
      builder: (context) => DialogAsk(
        title: LocaleKeys.shared_delete.tr,
        message: LocaleKeys.categories_sure_to_delete_category.tr,
        positive: LocaleKeys.shared_delete.tr,
        negative: LocaleKeys.shared_cancel.tr,
        onPositiveTap: () => deleteCategory(index),
      ),
    );
  }

  void showDialogEditCategory(int index) {
    showDialog(
      context: Get.context,
      builder: (context) => DialogAddEditCategory(
        false,
        category: _controller.categories().elementAt(index),
      ),
    ).then((value) {
      if (value != null && value) {
        Helper.successSnackBar(LocaleKeys.shared_success.tr,
            LocaleKeys.categories_category_edited_successfully.tr);
      }
    });
  }

  void deleteCategory(int index) async {
    int categoryId = _controller.categories().elementAt(index).id;
    await _controller.getCategoryProductsAsync(categoryId).then((response) {
      List<Product> thisCategoryProducts = Helper.getThisCategoryProductList(
          JsonParser.parseProducts(response.data), categoryId);
      if (thisCategoryProducts.length > 0) {
        buildDialogDeletionWarning(categoryId, thisCategoryProducts);
      } else {
        _controller.deleteCategory(_controller.categories().elementAt(index));
      }
    });
  }

  void buildDialogDeletionWarning(
      int categoryId, List<Product> thisCategoryProducts) {
    showDialog(
      context: Get.context,
      builder: (context) =>
          DialogCategoryDeletionWarning(categoryId, thisCategoryProducts),
    );
  }

  CategoriesController get _controller => Get.find<CategoriesController>();
}
