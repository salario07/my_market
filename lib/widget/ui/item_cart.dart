import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_market/controller/cart_controller.dart';
import 'package:my_market/generated/locales.g.dart';
import 'package:my_market/helper/app_colors.dart';
import 'package:my_market/helper/dimens.dart';
import 'package:my_market/helper/helper.dart';
import 'package:my_market/model/shopping_item.dart';
import 'package:my_market/widget/component/text_content.dart';
import 'package:my_market/widget/component/text_label.dart';
import 'package:my_market/widget/ui/dialog_ask.dart';

import 'show_product.dart';

class ItemCart extends StatelessWidget {
  final int id;

  ItemCart(this.id);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildItemInfo(),
          buildItemPrice(),
        ],
      ),
    );
  }

  Row buildItemPrice() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [buildTotalPrice(), buildNumberPicker()],
    );
  }

  Widget buildTotalPrice() {
    return Expanded(
      child: Align(
        alignment: AlignmentDirectional.centerStart,
        child: Text(
          Helper.buildPriceText(calculateTotalPrice()),
          textAlign: TextAlign.end,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }

  Row buildItemInfo() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        buildImage(),
        SizedBox(width: 16),
        TextContent(getItem().product.name),
        Expanded(
          child: Align(
            alignment: AlignmentDirectional.centerEnd,
            child: TextLabel(
              Helper.buildPriceText(getItem().product.price),
              textAlign: TextAlign.end,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildImage() {
    return GestureDetector(
      onTap: navigateToShowProduct,
      child: Card(
        color: AppColors.colorSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimens.card_border_radius)),
        child: getItem().product.images.length > 0
            ? Image.network(
                getItem().product.images[0],
                width: 48,
                height: 48,
              )
            : SizedBox(width: 48, height: 48),
      ),
    );
  }

  void askToRemoveItem(ShoppingItem item) {
    showDialog(
        context: Get.context,
        builder: (context) => DialogAsk(
              title: LocaleKeys.cart_confirm.tr,
              message:
                  '${LocaleKeys.cart_sure_to_remove.tr} ${item.product.name} ${LocaleKeys.cart_from_cart_.tr}',
              negative: LocaleKeys.shared_cancel.tr,
              positive: LocaleKeys.shared_remove.tr,
              onPositiveTap: removeItemFromCart,
            ));
  }

  void removeItemFromCart() {
    _controller.removeItem(getItem().id);
  }

  void _onIncrement() {
    ShoppingItem item = getItem();
    if(item.product.stock>item.count){
      item.count = item.count + 1;
      _controller.updateItemCount(item);
    }
  }

  void _onDecrement() {
    ShoppingItem item = getItem();
    if (item.count > 1) {
      ShoppingItem item = getItem();
      item.count = item.count - 1;
      _controller.updateItemCount(item);
    } else {
      askToRemoveItem(item);
    }
  }

  Widget buildNumberPicker() {
    return Obx(
      () => Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          buildMinusButton(),
          buildCounterNumber(),
          buildPlusButton(),
        ],
      ),
    );
  }

  Container buildCounterNumber() => Container(
      width: 40,
      child: Text(
        getItem().count.toString(),
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        textAlign: TextAlign.center,
      ));

  ElevatedButton buildPlusButton() {
    return ElevatedButton(
        child: Icon(Icons.keyboard_arrow_up),
        onPressed:
            getItem().product.stock <= getItem().count ? null : _onIncrement);
  }

  OutlinedButton buildMinusButton() {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
          side: BorderSide(color: AppColors.colorPrimary)),
      child: Icon(Icons.keyboard_arrow_down),
      onPressed: _onDecrement,
    );
  }

  int calculateTotalPrice() {
    return getItem().count * getItem().product.price;
  }

  ShoppingItem getItem() {
    return _controller.shoppingItems().firstWhere((element) {
      if (element.product.id == id) Helper.logDebug('get item id is $id');
      return element.product.id == id;
    });
  }

  void navigateToShowProduct() {
    Get.to(() => ShowProduct(id))
        .then((value) => _controller.getShoppingList());
  }

  CartController get _controller => Get.find<CartController>();
}
