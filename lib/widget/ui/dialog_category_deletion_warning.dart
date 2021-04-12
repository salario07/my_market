import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_market/controller/categories_controller.dart';
import 'package:my_market/generated/locales.g.dart';
import 'package:my_market/helper/app_colors.dart';
import 'package:my_market/helper/dimens.dart';
import 'package:my_market/helper/helper.dart';
import 'package:my_market/helper/json_parser.dart';
import 'package:my_market/model/product.dart';
import 'package:my_market/widget/component/my_divider.dart';
import 'package:my_market/widget/component/text_content.dart';
import 'package:my_market/widget/component/text_label.dart';
import 'package:my_market/widget/ui/show_product_admin.dart';

class DialogCategoryDeletionWarning extends StatelessWidget {
  final int categoryId;
  final List<Product> products;

  DialogCategoryDeletionWarning(this.categoryId, this.products){
    _controller.categoryProducts(products);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        scrollable: true,
        backgroundColor: AppColors.colorSurface,
        shape: _buildShape(),
        content: Obx(
          () => _controller.isProductsLoading()
                  ? buildLoading()
                  : buildListView(),
        ));
  }

  Widget buildListView() {
    return Column(
      children: [
        TextLabel(LocaleKeys.categories_category_deletion_warning.tr),
        ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.symmetric(vertical: 8),
            itemBuilder: (context, index) {
              return buildItemProduct(index);
            },
            physics: NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => MyDivider(),
            itemCount: _controller.categoryProducts().length)
      ],
    );
  }

  Center buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  InkWell buildItemProduct(int index) {
    return InkWell(
      onTap: () => navigateToShowProduct(
          _controller.categoryProducts().elementAt(index).id),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: TextContent(Helper.isLocaleEnglish()
            ? _controller.categoryProducts().elementAt(index).name
            : _controller.categoryProducts().elementAt(index).persianName),
      ),
    );
  }

  RoundedRectangleBorder _buildShape() {
    return RoundedRectangleBorder(
        borderRadius:
            BorderRadius.all(Radius.circular(Dimens.dialog_border_radius)));
  }

  void navigateToShowProduct(int productId) async {
    Get.to(() => ShowProductAdmin(productId)).then((value) async {
      await _controller.getCategoryProductsAsync(categoryId).then((response) {
        List<Product> thisCategoryProducts = Helper.getThisCategoryProductList(
            JsonParser.parseProducts(response.data), categoryId);
        if (thisCategoryProducts.length == 0) {
          Get.back();
        }
      });
    });
  }

  CategoriesController get _controller => Get.find<CategoriesController>();
}
