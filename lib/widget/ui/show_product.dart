import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_market/controller/show_product_controller.dart';
import 'package:my_market/generated/locales.g.dart';
import 'package:my_market/helper/app_colors.dart';
import 'package:my_market/helper/dimens.dart';
import 'package:my_market/widget/component/my_button.dart';

class ShowProduct extends StatelessWidget {
  final int id;

  ShowProduct(this.id);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<ShowProductController>(() => ShowProductController(id));
    return Scaffold(
      backgroundColor: AppColors.colorBackground,
      appBar: AppBar(
        title: Obx(() => Text(_controller.product().name)),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Obx(
          () => Padding(
            padding: EdgeInsets.only(top: 16, bottom: 24, right: 16, left: 16),
            child: Column(
              children: [
                _controller.product().images.length > 0
                    ? Image.network(
                        _controller.product().images[0],
                        width: double.infinity,
                        fit: BoxFit.fitWidth,
                      )
                    : Container(
                        width: double.infinity,
                        child: FittedBox(
                            fit: BoxFit.fitWidth, child: Icon(Icons.image,color: AppColors.colorDivider,))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        _controller.product().name,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.colorPrimary),
                          borderRadius: BorderRadius.circular(
                              Dimens.edit_text_border_radius)),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        child: Text(
                          _controller.product().price.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: AppColors.colorPrimary),
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  width: double.infinity,
                  child: Text(
                    _controller.product().description,
                    textAlign: TextAlign.start,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(LocaleKeys.show_product_stock.tr),
                    Text(
                        '${_controller.product().stock} ${LocaleKeys.show_product_items.tr}',textAlign: TextAlign.end,)
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          child: MyButton(Text(LocaleKeys.show_product_add_to_cart.tr), () {})),
    );
  }

  ShowProductController get _controller => Get.find<ShowProductController>();
}
