import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_market/controller/show_product_controller.dart';
import 'package:my_market/generated/locales.g.dart';
import 'package:my_market/helper/app_colors.dart';
import 'package:my_market/helper/dimens.dart';
import 'package:my_market/helper/helper.dart';
import 'package:my_market/widget/component/text_content.dart';
import 'package:my_market/widget/component/text_label.dart';
import 'package:my_market/widget/component/text_title.dart';
import 'package:my_market/widget/ui/add_edit_product.dart';

class ShowProductAdmin extends StatelessWidget {
  final int id;

  ShowProductAdmin(this.id);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<ShowProductController>(() => ShowProductController(id));
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
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(children: [Expanded(child: buildEditButton())]),
      ),
    );
  }

  Widget buildEditButton() {
    return OutlinedButton(
        child: Text(LocaleKeys.home_page_admin_edit.tr),
        onPressed: navigateToEditProduct);
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
        child: _controller.product().images.length > 0
            ? Image.network(
                _controller.product().images?.elementAt(0) ?? '',
                width: double.infinity,
                fit: BoxFit.fitWidth,
              )
            : Icon(
                Icons.image,
                color: AppColors.colorDivider,
                size: 80,
              ));
  }

  bool isProductAvailable() {
    return _controller.product().stock > 0;
  }

  void navigateToEditProduct() {
    Get.to(() => AddEditProduct(
          false,
          product: _controller.product(),
        )).then((value) {
      if (value != null && value) {
        Helper.successSnackBar(LocaleKeys.shared_success.tr,
            LocaleKeys.add_edit_product_product_edited_successfully.tr);
        _controller.getProduct(id);
      }
    });
  }

  ShowProductController get _controller => Get.find<ShowProductController>();
}
