import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_market/controller/add_edit_product_controller.dart';
import 'package:my_market/generated/locales.g.dart';
import 'package:my_market/helper/app_colors.dart';
import 'package:my_market/helper/dimens.dart';
import 'package:my_market/helper/helper.dart';
import 'package:my_market/widget/component/text_content.dart';

class DialogSelectCategory extends StatelessWidget {
  DialogSelectCategory() {
    _controller.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: buildDialogShape(),
      child: buildContent(),
    );
  }

  RoundedRectangleBorder buildDialogShape() {
    return RoundedRectangleBorder(
        borderRadius:
            BorderRadius.all(Radius.circular(Dimens.dialog_border_radius)));
  }

  Widget buildContent() {
    return Obx(() =>
        _controller.categories().isEmpty ? buildEmptyText() : buildListView());
  }

  ListView buildListView() {
    return ListView.separated(
      itemBuilder: (context, index) {
        return buildCategoryItem(index);
      },
      itemCount: _controller.categories().length,
      scrollDirection: Axis.vertical,
      separatorBuilder: (context, index) => buildDivider(),
    );
  }

  Center buildEmptyText() {
    return Center(
      child: TextContent(LocaleKeys.home_page_no_item_found.tr),
    );
  }

  Divider buildDivider() => Divider(height: 1, color: AppColors.colorDivider);

  InkWell buildCategoryItem(int index) {
    return InkWell(
      onTap: () {
        Get.back(result: _controller.categories().elementAt(index));
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: TextContent(Helper.isLocaleEnglish()
            ? _controller.categories().elementAt(index).name
            : _controller.categories().elementAt(index).persianName),
      ),
    );
  }

  AddEditProductController get _controller =>
      Get.find<AddEditProductController>();
}
