import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_market/controller/show_product_list_controller.dart';
import 'package:my_market/generated/locales.g.dart';
import 'package:my_market/helper/app_colors.dart';
import 'package:my_market/helper/search_product.dart';
import 'package:my_market/model/product.dart';
import 'package:my_market/widget/component/text_content.dart';
import 'package:my_market/widget/ui/item_product.dart';

import 'cart.dart';
import 'show_product.dart';

class ShowProductList extends StatelessWidget {
  final String title;
  final List<Product> products;

  ShowProductList(this.title, this.products);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<ShowProductListController>(() => ShowProductListController());
    return Scaffold(
      backgroundColor: AppColors.colorBackground,
      appBar: buildAppBar(),
      body: buildContent(),
    );
  }

  Widget buildContent() {
    return products.isEmpty
        ? Center(
            child: TextContent(LocaleKeys.home_page_no_item_found.tr),
          )
        : GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, index) => ItemProduct(
                products[index], () => navigateToShowProduct(products[index])),
            itemCount: products.length,
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.all(8),
          );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text(title),
      actions: [buildCartIcon(), buildSearchIcon()],
    );
  }

  GestureDetector buildSearchIcon() {
    return GestureDetector(
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Icon(Icons.search)),
      onTap: () =>
          showSearch(context: Get.context, delegate: SearchProduct(products)),
    );
  }

  GestureDetector buildCartIcon() {
    return GestureDetector(
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Obx(
            () => buildBadge(),
          )),
      onTap: () => Get.to(() => Cart()),
    );
  }

  Badge buildBadge() {
    return Badge(
        position: BadgePosition.topStart(top: 2, start: 8),
        badgeColor: AppColors.colorSecondary,
        showBadge: _controller.cartCount() > 0,
        animationType: BadgeAnimationType.scale,
        animationDuration: Duration(milliseconds: 200),
        badgeContent: Text(_controller.cartCount().toString()),
        child: Icon(Icons.shopping_cart));
  }

  void navigateToShowProduct(Product product) {
    Get.to(() => ShowProduct(product?.id ?? 0))
        .then((value) => _controller.getShoppingListCount());
  }

  ShowProductListController get _controller =>
      Get.find<ShowProductListController>();
}
