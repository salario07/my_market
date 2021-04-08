import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_market/generated/locales.g.dart';
import 'package:my_market/helper/helper.dart';
import 'package:my_market/model/product.dart';
import 'package:my_market/repository/add_edit_product_repo.dart';

class AddEditProductController extends GetxController {
  RxBool isLoading = false.obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AddEditProductRepo repository = AddEditProductRepo();

  void editProduct(Product product) {
    isLoading(true);
    repository.editProduct(product).then((response) {
      navigateBack();
    }).catchError((error) {
      Helper.errorSnackBar(LocaleKeys.shared_error.tr, error.toString());
    }).whenComplete(() => isLoading(false));
  }

  void addProduct(Product product) {
    isLoading(true);
    repository.addProduct(product).then((response) {
      navigateBack();
    }).catchError((error) {
      Helper.errorSnackBar(LocaleKeys.shared_error.tr, error.toString());
    }).whenComplete(() => isLoading(false));
  }

  void navigateBack() {
    Get.back(result: true);
  }
}
