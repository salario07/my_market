import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:get/get.dart';
import 'package:my_market/controller/add_edit_product_controller.dart';
import 'package:my_market/generated/locales.g.dart';
import 'package:my_market/helper/app_colors.dart';
import 'package:my_market/helper/helper.dart';
import 'package:my_market/helper/validators.dart';
import 'package:my_market/model/product.dart';
import 'package:my_market/widget/component/my_text_field.dart';
import 'package:my_market/widget/component/text_label.dart';
import 'package:my_market/widget/component/text_title.dart';
import 'package:my_market/widget/ui/dialog_select_category.dart';

class AddEditProduct extends StatelessWidget {
  final bool isAddMode;
  final Product product;
  final TextEditingController _englishTitleController = TextEditingController();
  final TextEditingController _persianTitleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final MaskedTextController _priceController =
      MaskedTextController(mask: '000,000,000');
  final MaskedTextController _stockController =
      MaskedTextController(mask: '000,000');

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
            padding: EdgeInsets.only(top: 24, left: 16, right: 16, bottom: 88),
            child: Form(
              key: _controller.formKey,
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextLabel(LocaleKeys.add_edit_product_category.tr),
                      Expanded(child: TextTitle())
                    ],
                  ),
                  MyTextField(
                    validator: (text) => Validators.emptyValidator(text),
                    labelText:
                        LocaleKeys.add_edit_product_english_product_name.tr,
                    controller: _englishTitleController,
                    hintText: LocaleKeys
                        .add_edit_product_english_product_name_hint.tr,
                  ),
                  SizedBox(height: 16),
                  MyTextField(
                    validator: (text) => Validators.emptyValidator(text),
                    labelText:
                        LocaleKeys.add_edit_product_persian_product_name.tr,
                    controller: _persianTitleController,
                    hintText: LocaleKeys
                        .add_edit_product_persian_product_name_hint.tr,
                  ),
                  SizedBox(height: 16),
                  MyTextField(
                    validator: (text) => Validators.emptyValidator(text),
                    labelText: LocaleKeys.show_product_stock.tr,
                    controller: _stockController,
                    hintText: LocaleKeys.add_edit_product_stock_hint.tr,
                    textInputType: TextInputType.number,
                  ),
                  SizedBox(height: 16),
                  MyTextField(
                    validator: (text) => Validators.emptyValidator(text),
                    labelText: LocaleKeys.filter_price.tr,
                    controller: _priceController,
                    hintText: LocaleKeys.add_edit_product_price_hint.tr,
                    textInputType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                  ),
                  SizedBox(height: 16),
                  MyTextField(
                    validator: (text) => Validators.emptyValidator(text),
                    labelText: LocaleKeys.add_edit_product_description.tr,
                    controller: _descriptionController,
                    hintText: LocaleKeys.add_edit_product_description_hint.tr,
                    textInputType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    maxLines: 3,
                  ),
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
        width: double.infinity,
        color: AppColors.colorBackground,
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(mainAxisSize: MainAxisSize.max, children: [
          buildCancelButton(),
          SizedBox(width: 16),
          buildSaveButton()
        ]),
      ),
    );
  }

  Widget buildSaveButton() {
    return Expanded(
        child: ElevatedButton(
            child: Text(isAddMode
                ? LocaleKeys.add_edit_product_add_product.tr
                : LocaleKeys.add_edit_product_edit_product.tr),
            onPressed: onSave));
  }

  Widget buildCancelButton() {
    return OutlinedButton(
        child: Text(LocaleKeys.shared_cancel.tr), onPressed: () => Get.back());
  }

  void onSave() {
    if (_controller.formKey.currentState.validate()) {
      if (isAddMode) {
        _controller.addProduct(buildProductFromInput());
      } else {
        _controller.editProduct(buildProductFromInput());
      }
    }
  }

  Product buildProductFromInput() {
    if (isAddMode) {
      return Product(
          name: _englishTitleController.text,
          persianName: _persianTitleController.text,
          stock: int.parse(_stockController.text),
          price: int.parse(_priceController.text),
          description: _descriptionController.text);
    } else {
      return Product(
          id: this.product.id,
          name: _englishTitleController.text,
          persianName: _persianTitleController.text,
          stock: int.parse(_stockController.text),
          price: int.parse(_priceController.text),
          description: _descriptionController.text,
          images: this.product.images,
          categoryId: this.product.categoryId);
    }
  }

  void showSelectCategoryDialog() {
    showDialog(
        context: Get.context,
        builder: (context) => DialogSelectCategory()).then((value) {
      if (value != null) {
        _controller.category(value);
      }
    });
  }

  AddEditProductController get _controller =>
      Get.find<AddEditProductController>();
}
