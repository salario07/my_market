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
      content: Form(
        key: _controller.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MyTextField(
              validator: (text) => Validators.emptyValidator(text),
              labelText: LocaleKeys.categories_category_english_name,
              hintText: LocaleKeys.categories_category_english_name_label,
              controller: _englishNameController,
            ),
            MyTextField(
              validator: (text) => Validators.emptyValidator(text),
              labelText: LocaleKeys.categories_category_persian_name,
              hintText: LocaleKeys.categories_category_persian_name_label,
              controller: _persianNameController,
            ),
            SizedBox(height: 24),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                    onPressed: () => Get.back(),
                    child: Text(LocaleKeys.shared_cancel.tr)),
                SizedBox(width: 16),
                ElevatedButton(
                    onPressed: onSave,
                    child: Text(isAddMode
                        ? LocaleKeys.categories_add.tr
                        : LocaleKeys.home_page_admin_edit.tr))
              ],
            )
          ],
        ),
      ),
    );
  }

  void onSave() {
    if (_controller.formKey.currentState.validate()) {
      if(isAddMode){

      }else{

      }
    }
  }

  RoundedRectangleBorder _buildShape() {
    return RoundedRectangleBorder(
        borderRadius:
            BorderRadius.all(Radius.circular(Dimens.dialog_border_radius)));
  }

  CategoriesController get _controller => Get.find<CategoriesController>();
}
