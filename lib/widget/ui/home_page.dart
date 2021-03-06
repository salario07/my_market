import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_market/controller/home_page_controller.dart';
import 'package:my_market/generated/locales.g.dart';
import 'package:my_market/helper/app_colors.dart';
import 'package:my_market/helper/dimens.dart';
import 'package:my_market/helper/json_parser.dart';
import 'package:my_market/helper/search_product.dart';
import 'package:my_market/helper/shared_pref.dart';
import 'package:my_market/model/filter.dart';
import 'package:my_market/model/product.dart';
import 'package:my_market/model/user.dart';
import 'package:my_market/widget/ui/bottom_sheet_filter.dart';
import 'package:my_market/widget/ui/cart.dart';
import 'package:my_market/widget/ui/dialog_ask.dart';
import 'package:my_market/widget/ui/dialog_language.dart';
import 'package:my_market/widget/ui/item_category.dart';
import 'package:my_market/widget/ui/item_product.dart';
import 'package:my_market/widget/ui/login.dart';
import 'package:my_market/widget/ui/show_product_list.dart';

import 'show_product.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut<HomePageController>(() => HomePageController(false));
    return Scaffold(
      backgroundColor: AppColors.colorBackground,
      appBar: buildAppBar(),
      body: buildContent(),
      drawer: buildDrawer(),
      floatingActionButton: buildFilterFloatingActionButton(),
    );
  }

  FloatingActionButton buildFilterFloatingActionButton() {
    return FloatingActionButton(
      child: Icon(Icons.filter_alt),
      backgroundColor: AppColors.colorAccent,
      onPressed: showBottomSheetFilter,
    );
  }

  Column buildContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [buildCategoriesListView(), buildProductsListView()],
    );
  }

  Flexible buildCategoriesListView() {
    return Flexible(
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
    );
  }

  Flexible buildProductsListView() {
    return Flexible(
      fit: FlexFit.loose,
      flex: 6,
      child: Obx(
        () => GridView.builder(
          padding: EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 80),
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 0.9),
          itemBuilder: (context, index) => ItemProduct(
              _controller.products()[index],
              () => navigateToShowProduct(_controller.products()[index])),
          scrollDirection: Axis.vertical,
          itemCount: _controller.products().length,
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text(LocaleKeys.shared_app_name.tr),
      actions: [buildCartIcon(), buildSearchIcon()],
    );
  }

  GestureDetector buildSearchIcon() {
    return GestureDetector(
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Icon(Icons.search)),
      onTap: () => showSearch(
          context: Get.context,
          delegate: SearchProduct(_controller.products())),
    );
  }

  GestureDetector buildCartIcon() {
    return GestureDetector(
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Obx(
            () => buildBadge(),
          )),
      onTap: navigateToCart,
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

  Drawer buildDrawer() {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildDrawerHeader(),
          buildDrawerItem(
              Icons.home, LocaleKeys.home_page_home.tr, () => Get.back(), true),
          Divider(height: 2, color: AppColors.colorDivider),
          buildDrawerItem(Icons.language, LocaleKeys.home_page_language.tr,
              changeLanguage, false),
          Divider(height: 2, color: AppColors.colorDivider),
          buildDrawerItem(
              Icons.logout, LocaleKeys.home_page_logout.tr, askToLogout, false),
        ],
      ),
    );
  }

  Widget buildDrawerHeader() {
    return Container(
      width: double.infinity,
      height: 160,
      decoration: BoxDecoration(color: AppColors.colorPrimary),
      child: Align(
        alignment: AlignmentDirectional.bottomStart,
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            '${LocaleKeys.home_page_hello.tr} ${SharedPref.getUserFullName()}',
            style: TextStyle(color: AppColors.colorSurface, fontSize: 16),
          ),
        ),
      ),
    );
  }

  InkWell buildDrawerItem(
      IconData iconData, String text, Function() onTap, bool isHome) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: buildDrawerItemContent(iconData, isHome, text),
      ),
    );
  }

  Row buildDrawerItemContent(IconData iconData, bool isHome, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(iconData,
            color: isHome ? AppColors.colorPrimary : AppColors.colorDivider),
        SizedBox(width: 8),
        Text(text)
      ],
    );
  }

  void askToLogout() {
    showDialog(
        context: Get.context,
        builder: (context) => DialogAsk(
              title: LocaleKeys.home_page_logout.tr,
              message: LocaleKeys.home_page_sure_to_logout.tr,
              negative: LocaleKeys.shared_cancel.tr,
              positive: LocaleKeys.home_page_logout_short.tr,
              onPositiveTap: logout,
            ));
  }

  void logout() {
    SharedPref.setUserLoggedIn(false);
    SharedPref.setUserAdmin(false);
    SharedPref.setUser(User());
    Get.offAll(() => Login());
  }

  void changeLanguage() {
    showDialog(context: Get.context, builder: (context) => DialogLanguage());
  }

  void navigateToShowProduct(Product product) {
    Get.to(() => ShowProduct(product?.id ?? 0))
        .then((value) => _controller.getShoppingListCount());
  }

  void showBottomSheetFilter() {
    Get.bottomSheet(BottomSheetFilter(),
            shape: buildBottomSheetShape(),
            backgroundColor: AppColors.colorSurface)
        .then((filterObject) =>
            filterObject != null ? onFilter(filterObject as Filter) : null);
  }

  void onFilter(Filter filter) {
    _controller.getProductsAsync().then((response) {
      List<Product> updatedProducts = JsonParser.parseProducts(response.data);
      _controller.products(updatedProducts);
      List<Product> filtered = [];
      for (Product product in updatedProducts) {
        if (isEligibleForFilter(filter, product)) {
          filtered.add(product);
        }
      }
      navigateToFilteredProducts(filtered);
    });
  }

  void navigateToFilteredProducts(List<Product> filtered) {
    Get.to(() => ShowProductList(
            LocaleKeys.show_product_list_filtered_products.tr, filtered))
        .then((value) => _controller.getShoppingListCount());
  }

  bool isEligibleForFilter(Filter filter, Product product) {
    return filter.min <= product.price &&
        filter.max >= product.price &&
        ((filter.onlyAvailableProducts && product.stock > 0) ||
            !filter.onlyAvailableProducts);
  }

  RoundedRectangleBorder buildBottomSheetShape() {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(Dimens.dialog_border_radius),
          topLeft: Radius.circular(Dimens.dialog_border_radius)),
    );
  }

  void navigateToCart() {
    Get.to(() => Cart()).then((value) => _controller.getShoppingListCount());
  }

  HomePageController get _controller => Get.find<HomePageController>();
}
