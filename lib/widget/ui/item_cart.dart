import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_market/controller/cart_controller.dart';
import 'package:my_market/generated/locales.g.dart';
import 'package:my_market/helper/app_colors.dart';
import 'package:my_market/helper/dimens.dart';
import 'package:my_market/model/shopping_item.dart';
import 'package:my_market/widget/component/text_content.dart';
import 'package:my_market/widget/component/text_label.dart';
import 'package:my_market/widget/component/text_title.dart';

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
          calculateTotalPrice().toString(),
          textAlign: TextAlign.end,
          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
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
              getItem().product.price.toString(),
              textAlign: TextAlign.end,
            ),
          ),
        ),
      ],
    );
  }

  Card buildImage() {
    return Card(
      color: AppColors.colorSurface,
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimens.card_border_radius)),
      child: getItem().product.images.length > 0
          ? Image.network(
              getItem().product.images[0],
              width: 40,
              height: 40,
            )
          : SizedBox(width: 40, height: 40),
    );
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
        child: Icon(Icons.keyboard_arrow_up), onPressed: _onIncrement);
  }

  OutlinedButton buildMinusButton() {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
          side: BorderSide(color: AppColors.colorPrimary)),
      child: Icon(Icons.keyboard_arrow_down),
      onPressed: _onDecrement,
    );
  }

  void _onDecrement() {
    ShoppingItem item = getItem();
    int index = getIndex();
    _controller.shoppingItems().elementAt(index).count = item.count - 1;
    _updateItem();
  }

  void _onIncrement() {
    ShoppingItem item = getItem();
    int index = getIndex();
    _controller.shoppingItems().elementAt(index).count = item.count + 1;
    _updateItem();
  }

  int calculateTotalPrice() {
    return getItem().count * getItem().product.price;
  }

  ShoppingItem getItem() {
    return _controller.shoppingItems().firstWhere((element) {
      return element.product.id == id;
    });
  }

  int getIndex() {
    return _controller.shoppingItems().indexWhere((element) {
      return element.product.id == id;
    });
  }

  void _updateItem() {
    List<ShoppingItem> items = [];
    items.addAll(_controller.shoppingItems());
    items.firstWhere((element) => element.product.id == id);
    _controller.shoppingItems(items);
  }

  CartController get _controller => Get.find<CartController>();
}
