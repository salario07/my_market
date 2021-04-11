import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_market/controller/categories_controller.dart';
import 'package:my_market/generated/locales.g.dart';
import 'package:my_market/helper/app_colors.dart';
import 'package:my_market/helper/dimens.dart';
import 'package:my_market/helper/validators.dart';
import 'package:my_market/model/category.dart';
import 'package:my_market/widget/component/my_text_field.dart';

class DialogAddEditCategory extends StatelessWidget {
  final bool isAddMode;
  final Category category;
  final TextEditingController _englishNameController = TextEditingController();
  final TextEditingController _persianNameController = TextEditingController();

  DialogAddEditCategory(this.isAddMode, {this.category}) {
    if (!isAddMode) {
      _englishNameController.text = category.name;
      _persianNameController.text = category.persianName;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: false,
      backgroundColor: AppColors.colorSurface,
      shape: _buildShape(),
      content: buildForm(),
    );
  }

  Form buildForm() {
    return Form(
      key: _controller.formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildEnglishNameTextField(),
          SizedBox(height: 16),
          buildPersianNameTextField(),
          SizedBox(height: 24),
          buildButtons()
        ],
      ),
    );
  }

  Row buildButtons() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton(
            onPressed: () => Get.back(),
            child: Text(LocaleKeys.shared_cancel.tr)),
        SizedBox(width: 16),
        ElevatedButton(
            onPressed: _controller.isAddEditLoading() ? null : onSave,
            child: _controller.isAddEditLoading()
                ? buildLoadingSaveButton()
                : buildSaveButtonText())
      ],
    );
  }

  MyTextField buildPersianNameTextField() {
    return MyTextField(
      validator: (text) => Validators.emptyValidator(text),
      labelText: LocaleKeys.categories_category_persian_name.tr,
      hintText: LocaleKeys.categories_category_persian_name_label.tr,
      controller: _persianNameController,
    );
  }

  MyTextField buildEnglishNameTextField() {
    return MyTextField(
      validator: (text) => Validators.emptyValidator(text),
      labelText: LocaleKeys.categories_category_english_name.tr,
      hintText: LocaleKeys.categories_category_english_name_label.tr,
      controller: _englishNameController,
    );
  }

  Row buildLoadingSaveButton() {
    return Row(
      children: [
        SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(),
        ),
        buildSaveButtonText()
      ],
    );
  }

  Text buildSaveButtonText() {
    return Text(isAddMode
        ? LocaleKeys.categories_add.tr
        : LocaleKeys.home_page_admin_edit.tr);
  }

  void onSave() {
    if (_controller.formKey.currentState.validate()) {
      if (isAddMode) {
        _controller.addCategory(buildCategoryFromInput());
      } else {
        _controller.editCategory(buildCategoryFromInput());
      }
    }
  }

  Category buildCategoryFromInput() {
    if (isAddMode) {
      return Category(
          name: _englishNameController.text,
          persianName: _persianNameController.text);
    } else {
      return Category(
          id: this.category.id,
          name: _englishNameController.text,
          persianName: _persianNameController.text);
    }
  }

  RoundedRectangleBorder _buildShape() {
    return RoundedRectangleBorder(
        borderRadius:
            BorderRadius.all(Radius.circular(Dimens.dialog_border_radius)));
  }

  CategoriesController get _controller => Get.find<CategoriesController>();
}
