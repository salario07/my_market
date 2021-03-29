import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_market/controller/show_product_controller.dart';
import 'package:my_market/generated/locales.g.dart';
import 'package:my_market/helper/app_colors.dart';
import 'package:my_market/helper/dimens.dart';
import 'package:my_market/widget/component/my_button.dart';
import 'package:my_market/widget/component/text_content.dart';
import 'package:my_market/widget/component/text_label.dart';
import 'package:my_market/widget/component/text_title.dart';
import 'package:number_picker/number_picker.dart';

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
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Obx(
          () => Padding(
            padding: EdgeInsets.only(top: 16, bottom: 24, right: 16, left: 16),
            child: Column(
              children: [
                Image.network(
                  _controller.product().images?.elementAt(0) ?? '',
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextTitle(
                        _controller.product()?.name ?? '',
                        textAlign: TextAlign.start,
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
                SizedBox(height: 16),
                Row(
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
                ),
                SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  child: TextContent(
                    _controller.product()?.description ?? '',
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      /*bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          child: MyButton(Text(LocaleKeys.show_product_add_to_cart.tr), () {})),*/
      bottomNavigationBar: NumberPicker(),
    );
  }

  ShowProductController get _controller => Get.find<ShowProductController>();
}
