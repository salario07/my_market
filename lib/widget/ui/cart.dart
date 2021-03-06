import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_market/controller/cart_controller.dart';
import 'package:my_market/generated/locales.g.dart';
import 'package:my_market/helper/dimens.dart';
import 'package:my_market/widget/component/my_progress_indicator.dart';
import 'package:my_market/widget/component/text_content.dart';
import 'package:my_market/widget/component/text_label.dart';
import 'package:my_market/widget/ui/dialog_ask.dart';
import 'package:my_market/widget/ui/item_cart.dart';
import 'package:my_market/helper/app_colors.dart';

class Cart extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    Get.lazyPut<CartController>(() => CartController());
    return Scaffold(
      backgroundColor: AppColors.colorBackground,
      appBar: AppBar(
        title: Text(LocaleKeys.cart_cart.tr),
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [buildShoppingList(), buildBottomBar()],
      ),
    );
  }

  Align buildBottomBar() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        color: AppColors.colorBackground,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            children: [
              buildTotalPrice(),
              SizedBox(width: 16),
              buildBuyButton()
            ],
          ),
        ),
      ),
    );
  }

  Expanded buildBuyButton() {
    return Expanded(
      child: Obx(
        () => ElevatedButton(
            child: _buildBuyButtonChild(),
            onPressed: _controller.shoppingItems().length <= 0 ||
                    _controller.isPurchaseLoading()
                ? null
                : askToBuy,
            style: buildBuyButtonStyle()),
      ),
    );
  }

  ButtonStyle buildBuyButtonStyle() {
    return ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(Dimens.button_border_radius))));
  }

  Widget _buildBuyButtonChild() {
    return _controller.isPurchaseLoading()
        ? Row(
            children: [MyProgressIndicator(24), Text(LocaleKeys.cart_buy.tr)],
          )
        : Text(LocaleKeys.cart_buy.tr);
  }

  Widget buildShoppingList() {
    return Obx(
      () => _controller.shoppingItems().length > 0
          ? ListView.separated(
              padding: EdgeInsets.only(bottom: 80),
              itemBuilder: (context, index) => ItemCart(
                  _controller.shoppingItems().elementAt(index).product.id),
              scrollDirection: Axis.vertical,
              itemCount: _controller.shoppingItems().length,
              separatorBuilder: (context, index) =>
                  Divider(color: AppColors.colorDivider, height: 1),
            )
          : buildEmptyItem(),
    );
  }

  Widget buildEmptyItem() => Center(
          child: TextContent(
        LocaleKeys.cart_cart_is_empty.tr,
        textAlign: TextAlign.center,
      ));

  Widget buildTotalPrice() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextLabel(LocaleKeys.show_product_total_price.tr),
        Obx(() => Text(
              calculateTotalPrice().toString(),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ))
      ],
    );
  }

  int calculateTotalPrice() {
    int totalPrice = 0;
    _controller.shoppingItems().forEach((element) {
      totalPrice += element.product.price * element.count;
    });
    return totalPrice;
  }

  void askToBuy() {
    showDialog(
      context: Get.context,
      builder: (context) => DialogAsk(
        title: LocaleKeys.cart_confirm.tr,
        message: LocaleKeys.cart_are_you_sure_to_buy_these_items_.tr,
        positive: LocaleKeys.cart_buy.tr,
        negative: LocaleKeys.shared_cancel.tr,
        onPositiveTap: () => _controller.purchase(),
      ),
    );
  }

  CartController get _controller => Get.find<CartController>();

  Cart({bool updateData = false}){
    Future.delayed(Duration(milliseconds: 300)).then((value) {
      _controller.getShoppingList();
    });
  }
}
