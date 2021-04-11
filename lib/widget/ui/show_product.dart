import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_market/controller/show_product_controller.dart';
import 'package:my_market/generated/locales.g.dart';
import 'package:my_market/helper/app_colors.dart';
import 'package:my_market/helper/dimens.dart';
import 'package:my_market/helper/helper.dart';
import 'package:my_market/widget/component/my_button.dart';
import 'package:my_market/widget/component/text_content.dart';
import 'package:my_market/widget/component/text_label.dart';
import 'package:my_market/widget/component/text_title.dart';
import 'package:number_picker/number_picker.dart';

import 'cart.dart';

class ShowProduct extends StatelessWidget {
  final int id;
  NumberPicker numberPicker;

  ShowProduct(this.id);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<ShowProductController>(() => ShowProductController(id,false));
    return Scaffold(
      backgroundColor: AppColors.colorBackground,
      appBar: buildAppBar(),
      body: Stack(
        children: [buildContent(), _buildBottomBar()],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Obx(() => Text(_controller.product()?.name ?? '')),
      actions: [buildCartIcon()],
    );
  }

  GestureDetector buildCartIcon() {
    return GestureDetector(
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Obx(
            () => buildBadge(),
          )),
      onTap: _navigateToCart,
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
          isProductAvailable()
              ? '${_controller.product().stock} ${LocaleKeys.show_product_items.tr}'
              : LocaleKeys.show_product_unavailable.tr,
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

  Widget _buildBottomBar() {
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
                    child: _controller.productCount() != 0
                        ? buildNumberPicker()
                        : buildAddToCartButton(),
                  )
          ]),
        ),
      ),
    );
  }

  NumberPicker buildNumberPicker() {
    numberPicker = NumberPicker(
      onIncrement: _isStockEmpty() ? null : _onIncrement,
      onDecrement: _onDecrement,
      initCount: _controller.productCount(),
      maxCount: _controller.product().stock,
    );
    return numberPicker;
  }

  Widget buildAddToCartButton() {
    return MyButton(Text(LocaleKeys.show_product_add_to_cart.tr),
        isProductAvailable() ? _onIncrement : null);
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
                TextTitle(Helper.buildPriceText(_calculateTotalPrice()))
              ],
            ),
          )
        : SizedBox();
  }

  Widget buildName() {
    return Expanded(
      child: TextTitle(
        Helper.isLocaleEnglish()
            ? _controller.product()?.name ?? ''
            : _controller.product()?.persianName,
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
          Helper.buildPriceText(_controller.product().price),
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: AppColors.colorPrimary),
        ),
      ),
    );
  }

  Widget buildImage() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: !Helper.isNullOrEmpty(_controller.product().image)
            ? Image.memory(
                base64Decode(_controller.product().image),
                width: double.infinity,
                fit: BoxFit.fitWidth,
              )
            : Icon(
                Icons.image,
                color: AppColors.colorDivider,
                size: 80,
              ));
  }

  void _onIncrement() {
    if (_controller.productCount() == 0) {
      _controller.addToShoppingList();
    }
    _controller.updateShoppingCount(_controller.productCount() + 1);
  }

  void _onDecrement() {
    if (_controller.productCount() == 1) {
      _controller.removeFromShoppingList();
    } else {
      _controller.updateShoppingCount(_controller.productCount() - 1);
    }
  }

  int _calculateTotalPrice() {
    return _controller.productCount() * _controller.product().price;
  }

  bool _isStockEmpty() {
    return _controller.product().stock <= _controller.productCount();
  }

  void _navigateToCart() {
    Get.to(() => Cart()).then((value) {
      _controller.updateData(id);
      Future.delayed(Duration(milliseconds: 300)).then((value) {
        numberPicker.setNumber(_controller.productCount());
      });
    });
  }

  bool isProductAvailable() {
    return _controller.product().stock > 0;
  }

  ShowProductController get _controller => Get.find<ShowProductController>();
}
