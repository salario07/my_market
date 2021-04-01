import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_market/controller/show_product_controller.dart';
import 'package:my_market/generated/locales.g.dart';
import 'package:my_market/helper/app_colors.dart';
import 'package:my_market/helper/dimens.dart';
import 'package:my_market/widget/component/text_content.dart';
import 'package:my_market/widget/component/text_label.dart';
import 'package:my_market/widget/component/text_title.dart';
import 'package:number_picker/number_picker.dart' hide LocaleKeys;

import 'cart.dart';

class ShowProduct extends StatelessWidget {
  final int id;

  ShowProduct(this.id);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<ShowProductController>(() => ShowProductController(id));
    return Scaffold(
      backgroundColor: AppColors.colorBackground,
      appBar: AppBar(
        title: Obx(() => Text(_controller.product()?.name ?? '')),
        actions: [
          GestureDetector(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Obx(
                  () => Badge(
                      position: BadgePosition.topStart(top: 2, start: 8),
                      badgeColor: AppColors.colorSecondary,
                      showBadge: _controller.cartCount() > 0,
                      animationType: BadgeAnimationType.scale,
                      animationDuration: Duration(milliseconds: 200),
                      badgeContent: Text(_controller.cartCount().toString()),
                      child: Icon(Icons.shopping_cart)),
                )),
            onTap: () => Get.to(() => Cart()),
          )
        ],
      ),
      body: Stack(
        children: [buildContent(), buildNumberPicker()],
      ),
    );
  }

  SingleChildScrollView buildContent() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Obx(
        () => Padding(
          padding: EdgeInsets.only(top: 16, bottom: 88, right: 16, left: 16),
          child: buildProductInfo(),
        ),
      ),
    );
  }

  Column buildProductInfo() {
    return Column(
      children: [
        buildImage(),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [buildName(), buildPrice()],
        ),
        SizedBox(height: 16),
        buildStockCount(),
        SizedBox(height: 16),
        buildDescription(),
      ],
    );
  }

  Row buildStockCount() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextLabel(LocaleKeys.show_product_stock.tr),
        SizedBox(width: 8),
        TextContent(
          '${_controller.product().stock} ${LocaleKeys.show_product_items.tr}',
          textAlign: TextAlign.end,
        )
      ],
    );
  }

  Container buildDescription() {
    return Container(
      width: double.infinity,
      child: TextContent(
        _controller.product()?.description ?? '',
        textAlign: TextAlign.start,
      ),
    );
  }

  Widget buildNumberPicker() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        color: AppColors.colorBackground,
        child: Obx(
          () => Row(children: [
            buildTotalPrice(),
            !_controller.isProductCountLoaded()
                ? SizedBox()
                : Expanded(
                  child: NumberPicker(
                      onIncrement: isStockEmpty() ? null : onIncrement,
                      onDecrement: onDecrement,
                      initCount: _controller.productCount(),
                      maxCount: _controller.product().stock,
                    ),
                )
          ]),
        ),
      ),
    );
  }

  Widget buildTotalPrice() {
    return _controller.productCount() != 0
        ? Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextLabel(LocaleKeys.show_product_total_price.tr),
                TextTitle(calculateTotalPrice().toString())
              ],
            ),
          )
        : SizedBox();
  }

  Widget buildName() {
    return Expanded(
      child: TextTitle(
        _controller.product()?.name ?? '',
        textAlign: TextAlign.start,
      ),
    );
  }

  Widget buildPrice() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.colorPrimary),
          borderRadius: BorderRadius.circular(Dimens.edit_text_border_radius)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Text(
          _controller.product().price.toString(),
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: AppColors.colorPrimary),
        ),
      ),
    );
  }

  Widget buildImage() {
    return _controller.product().images.length > 0
        ? Image.network(
            _controller.product().images?.elementAt(0) ?? '',
            width: double.infinity,
            fit: BoxFit.fitWidth,
          )
        : Icon(
            Icons.image,
            color: AppColors.colorDivider,
            size: 80,
          );
  }

  void onIncrement() {
    if (_controller.productCount() == 0) {
      _controller.addToShoppingList();
    } else {
      _controller.updateShoppingCount(_controller.productCount() + 1);
    }
  }

  void onDecrement() {
    if (_controller.productCount() == 1) {
      _controller.removeFromShoppingList();
    } else {
      _controller.updateShoppingCount(_controller.productCount() - 1);
    }
  }

  int calculateTotalPrice() {
    return _controller.productCount() * _controller.product().price;
  }

  bool isStockEmpty() {
    return _controller.product().stock <= _controller.productCount();
  }

  ShowProductController get _controller => Get.find<ShowProductController>();
}
