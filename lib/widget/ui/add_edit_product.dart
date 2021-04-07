import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_market/controller/AddEditProductController.dart';
import 'package:my_market/generated/locales.g.dart';
import 'package:my_market/helper/app_colors.dart';
import 'package:my_market/helper/validators.dart';
import 'package:my_market/model/product.dart';
import 'package:my_market/widget/component/my_button.dart';
import 'package:my_market/widget/component/my_text_field.dart';

class AddEditProduct extends StatelessWidget {
  final bool isAddMode;
  final Product product;
  final TextEditingController _englishTitleController = TextEditingController();
  final TextEditingController _persianTitleController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  AddEditProduct(this.isAddMode, {this.product}) {
    if (!isAddMode) {
      _englishTitleController.text = product.name;
      _persianTitleController.text = product.persianName;
      _descriptionController.text = product.description;
      _stockController.text = product.stock.toString();
      _priceController.text = product.price.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<AddEditProductController>(() => AddEditProductController());
    return Scaffold(
      backgroundColor: AppColors.colorBackground,
      appBar: buildAppBar(),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Form(
              key: _controller.formKey,
              child: Column(
                children: [
                  MyTextField(
                    validator: (text) => Validators.emptyValidator(text),
                    labelText:
                        LocaleKeys.add_edit_product_english_product_name.tr,
                    controller: _englishTitleController,
                    hintText: LocaleKeys
                        .add_edit_product_english_product_name_hint.tr,
                    enabled: true,
                  ),
                  MyTextField(
                    validator: (text) => Validators.emptyValidator(text),
                    labelText:
                        LocaleKeys.add_edit_product_persian_product_name.tr,
                    controller: _persianTitleController,
                    hintText: LocaleKeys
                        .add_edit_product_persian_product_name_hint.tr,
                  ),
                  MyTextField(
                    validator: (text) => Validators.emptyValidator(text),
                    labelText: LocaleKeys.add_edit_product_description.tr,
                    controller: _descriptionController,
                    hintText: LocaleKeys.add_edit_product_description_hint.tr,
                  ),
                  MyTextField(
                    validator: (text) => Validators.emptyValidator(text),
                    labelText: LocaleKeys.show_product_stock.tr,
                    controller: _stockController,
                    hintText: LocaleKeys.add_edit_product_stock_hint.tr,
                  ),
                  MyTextField(
                    validator: (text) => Validators.emptyValidator(text),
                    labelText: LocaleKeys.filter_price.tr,
                    controller: _priceController,
                    hintText: LocaleKeys.add_edit_product_price_hint.tr,
                  )
                ],
              ),
            ),
          ),
          _buildBottomBar()
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text(isAddMode
          ? LocaleKeys.add_edit_product_add_product.tr
          : LocaleKeys.add_edit_product_edit_product.tr),
    );
  }

  Widget _buildBottomBar() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        color: AppColors.colorBackground,
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [buildCancelButton(), buildSaveButton()]),
      ),
    );
  }

  Widget buildSaveButton() {
    return MyButton(Text(LocaleKeys.add_edit_product_save.tr), () {});
  }

  Widget buildCancelButton() {
    return OutlinedButton(
        child: Text(LocaleKeys.shared_cancel.tr), onPressed: () {});
  }

  AddEditProductController get _controller =>
      Get.find<AddEditProductController>();
}
