import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:get/get.dart';
import 'package:my_market/controller/add_edit_product_controller.dart';
import 'package:my_market/generated/locales.g.dart';
import 'package:my_market/helper/app_colors.dart';
import 'package:my_market/helper/dimens.dart';
import 'package:my_market/helper/helper.dart';
import 'package:my_market/helper/validators.dart';
import 'package:my_market/helper/constants.dart';
import 'package:my_market/model/product.dart';
import 'package:my_market/widget/component/my_progress_indicator.dart';
import 'package:my_market/widget/component/my_text_field.dart';
import 'package:my_market/widget/component/text_content.dart';
import 'package:my_market/widget/component/text_label.dart';
import 'package:my_market/widget/ui/dialog_select_category.dart';

class AddEditProduct extends StatelessWidget {
  final bool isAddMode;
  final Product product;
  final TextEditingController _englishTitleController = TextEditingController();
  final TextEditingController _persianTitleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final MaskedTextController _priceController =
      MaskedTextController(mask: Constants.masked_text_pattern);
  final MaskedTextController _stockController =
      MaskedTextController(mask: Constants.masked_text_pattern);

  AddEditProduct(this.isAddMode, {this.product}) {
    if (!isAddMode) {
      _englishTitleController.text = product.name;
      _persianTitleController.text = product.persianName;
      _descriptionController.text = product.description;
      _stockController.text = product.stock.toString();
      _priceController.text = product.price.toString();
      //_controller.getCategory(product.categoryId);
    }
  }

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<AddEditProductController>(
        () => AddEditProductController(isAddMode, product?.categoryId ?? 0));
    return Scaffold(
      backgroundColor: AppColors.colorBackground,
      appBar: buildAppBar(),
      body: buildContent(),
    );
  }

  Stack buildContent() {
    return Stack(
      children: [
        SingleChildScrollView(
          padding: EdgeInsets.only(top: 24, left: 16, right: 16, bottom: 88),
          child: buildForm(),
        ),
        _buildBottomBar()
      ],
    );
  }

  Form buildForm() {
    return Form(
      key: _controller.formKey,
      child: Column(
        children: [
          Center(
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(Dimens.card_border_radius)),
              child: Container(
                width: 160,
                height: 160,
                child: Text(''),
              ),
            ),
          ),
          SizedBox(height: 16),
          buildCategory(),
          SizedBox(height: 16),
          buildEnglishNameTextField(),
          SizedBox(height: 16),
          buildPersianNameTextField(),
          SizedBox(height: 16),
          buildStockTextField(),
          SizedBox(height: 16),
          buildPriceTextField(),
          SizedBox(height: 16),
          buildDescriptionTextField(),
        ],
      ),
    );
  }

  MyTextField buildEnglishNameTextField() {
    return MyTextField(
      validator: (text) => Validators.emptyValidator(text),
      labelText: LocaleKeys.add_edit_product_english_product_name.tr,
      controller: _englishTitleController,
      hintText: LocaleKeys.add_edit_product_english_product_name_hint.tr,
    );
  }

  MyTextField buildPersianNameTextField() {
    return MyTextField(
      validator: (text) => Validators.emptyValidator(text),
      labelText: LocaleKeys.add_edit_product_persian_product_name.tr,
      controller: _persianTitleController,
      hintText: LocaleKeys.add_edit_product_persian_product_name_hint.tr,
    );
  }

  MyTextField buildStockTextField() {
    return MyTextField(
      validator: (text) => Validators.emptyValidator(text),
      labelText: LocaleKeys.show_product_stock.tr,
      controller: _stockController,
      hintText: LocaleKeys.add_edit_product_stock_hint.tr,
      textInputType: TextInputType.number,
    );
  }

  MyTextField buildPriceTextField() {
    return MyTextField(
      validator: (text) => Validators.emptyValidator(text),
      labelText: LocaleKeys.filter_price.tr,
      controller: _priceController,
      hintText: LocaleKeys.add_edit_product_price_hint.tr,
      textInputType: TextInputType.number,
      textInputAction: TextInputAction.done,
    );
  }

  MyTextField buildDescriptionTextField() {
    return MyTextField(
      validator: (text) => Validators.emptyValidator(text),
      labelText: LocaleKeys.add_edit_product_description.tr,
      controller: _descriptionController,
      hintText: LocaleKeys.add_edit_product_description_hint.tr,
      textInputType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
      maxLines: 3,
    );
  }

  InkWell buildCategory() {
    return InkWell(
      onTap: showSelectCategoryDialog,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextLabel(LocaleKeys.add_edit_product_category.tr),
            SizedBox(width: 16),
            Obx(
              () => buildCategoryName(),
            ),
            SizedBox(width: 4),
            Icon(Icons.arrow_drop_down)
          ],
        ),
      ),
    );
  }

  TextContent buildCategoryName() {
    return TextContent(
      _controller.category().id == 0
          ? LocaleKeys.add_edit_product_not_selected.tr
          : Helper.isLocaleEnglish()
              ? _controller.category().name
              : _controller.category().persianName,
      textAlign: TextAlign.end,
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: buildSaveButtonText(),
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
        child: Obx(
      () => ElevatedButton(
          child: _controller.isLoading()
              ? buildSaveButtonLoadingContent()
              : buildSaveButtonText(),
          onPressed: _controller.isLoading() ? null : onSave),
    ));
  }

  Row buildSaveButtonLoadingContent() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        MyProgressIndicator(20),
        SizedBox(width: 12),
        buildSaveButtonText()
      ],
    );
  }

  Text buildSaveButtonText() {
    return Text(isAddMode
        ? LocaleKeys.add_edit_product_add_product.tr
        : LocaleKeys.add_edit_product_edit_product.tr);
  }

  Widget buildCancelButton() {
    return OutlinedButton(
        child: Text(LocaleKeys.shared_cancel.tr), onPressed: () => Get.back());
  }

  void onSave() {
    if (_controller.formKey.currentState.validate() && checkInput()) {
      if (isAddMode) {
        _controller.addProduct(buildProductFromInput());
      } else {
        _controller.editProduct(buildProductFromInput());
      }
    }
  }

  bool checkInput() {
    if (_controller.category().id == 0) {
      Helper.errorSnackBar(LocaleKeys.add_edit_product_category_not_selected.tr,
          LocaleKeys.add_edit_product_please_select_category.tr);
      return false;
    } else {
      return true;
    }
  }

  Product buildProductFromInput() {
    if (isAddMode) {
      return Product(
          name: _englishTitleController.text,
          persianName: _persianTitleController.text,
          stock: int.parse(_stockController.text),
          price: int.parse(_priceController.text),
          description: _descriptionController.text,
          categoryId: _controller.category().id);
    } else {
      return Product(
          id: this.product.id,
          name: _englishTitleController.text,
          persianName: _persianTitleController.text,
          stock: int.parse(_stockController.text),
          price: int.parse(_priceController.text),
          description: _descriptionController.text,
          images: this.product.images,
          categoryId: _controller.category().id);
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
