import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:my_market/generated/locales.g.dart';
import 'package:my_market/helper/helper.dart';
import 'package:my_market/helper/json_parser.dart';
import 'package:my_market/model/category.dart';
import 'package:my_market/model/product.dart';
import 'package:my_market/repository/add_edit_product_repo.dart';

class AddEditProductController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLoadingCategories = false.obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AddEditProductRepo repository = AddEditProductRepo();
  RxList<Category> categories = [].cast<Category>().obs;
  Rx<Category> category = Category(id: 0).obs;

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

  void getCategories() {
    isLoadingCategories(true);
    repository.getCategories().then((response) {
      categories(JsonParser.parseCategories(response.data));
    }).catchError((error) {
      Helper.errorSnackBar(LocaleKeys.shared_error.tr, error.toString());
    }).whenComplete(() => isLoadingCategories(false));
  }

  void getCategory(int id) {
    repository.getCategory(id).then((response) {
      category(JsonParser.parseCategories(response.data).elementAt(0));
    }).catchError((error) {
      Helper.errorSnackBar(LocaleKeys.shared_error.tr, error.toString());
    });
  }

  void navigateBack() {
    Get.back(result: true);
  }
}
