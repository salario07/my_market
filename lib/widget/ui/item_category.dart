import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_market/controller/home_page_controller.dart';
import 'package:my_market/helper/dimens.dart';
import 'package:my_market/model/category.dart';
import 'package:my_market/model/product.dart';
import 'package:my_market/widget/ui/show_product_list.dart';

class ItemCategory extends StatelessWidget {
  final Category category;

  ItemCategory(this.category);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimens.card_border_radius)),
      margin: EdgeInsets.all(8),
      child: InkWell(
        onTap: navigateToProductList,
        child: buildContent(),
      ),
    );
  }

  Padding buildContent() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Center(
        child: Text(
          category?.name ?? '',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }

  void navigateToProductList() {
    Get.to(() => ShowProductList(category.name, getThisCategoryProductList()))
        .then((value) => _controller.getShoppingListCount());
  }

  List<Product> getThisCategoryProductList() {
    List<Product> categorizedProducts = [];
    _controller.products().forEach((element) {
      if (element.categoryId == category.id) {
        categorizedProducts.add(element);
      }
    });
    return categorizedProducts;
  }

  HomePageController get _controller => Get.find<HomePageController>();
}
