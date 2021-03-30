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
      body: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Obx(
              () => Padding(
                padding:
                    EdgeInsets.only(top: 16, bottom: 64, right: 16, left: 16),
                child: buildProductInfo(),
              ),
            ),
          ),
          buildNumberPicker()
        ],
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
    );
  }

  Widget buildNumberPicker() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Obx(
        () => Expanded(
          child: Row(children: [
            _controller.number() != 0
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextLabel(LocaleKeys.show_product_total_price.tr),
                      TextTitle(calculateTotalPrice().toString())
                    ],
                  )
                : SizedBox(),
            NumberPicker(
              onIncrement: () => _controller.number(_controller.number() + 1),
              onDecrement: () => _controller.number(
                _controller.number() - 1,
              ),
            )
          ]),
        ),
      ),
    );
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

  int calculateTotalPrice() {
    return _controller.number() * _controller.product().price;
  }

  ShowProductController get _controller => Get.find<ShowProductController>();
}
