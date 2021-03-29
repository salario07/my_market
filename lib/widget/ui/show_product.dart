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
      appBar: AppBar(
        title: Obx(() => Text(_controller.product().name)),
      ),
      body: Obx(
        () => Column(
          children: [
            /*Image.network(
              _controller.product().images[0],
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),*/
            Padding(
              padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      _controller.product().name,
                      textAlign: TextAlign.start,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
            ),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                child: Text(_controller.product().description,textAlign: TextAlign.start,)),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(LocaleKeys.show_product_stock.tr),
                  Text(
                      '${_controller.product().stock} ${LocaleKeys.show_product_items.tr}')
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: MyButton(Text(LocaleKeys.show_product_add_to_cart.tr), () {})),
    );
  }

  ShowProductController get _controller => Get.find<ShowProductController>();
}
