import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_market/generated/locales.g.dart';
import 'package:my_market/helper/helper.dart';
import 'package:my_market/helper/json_parser.dart';
import 'package:my_market/model/category.dart';
import 'package:my_market/repository/categories_repo.dart';

class CategoriesController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<Category> categories = [].cast<Category>().obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  CategoriesRepo repository = CategoriesRepo();

  void getCategories() {
    isLoading(true);
    repository.getCategories().then((response) {
      categories(JsonParser.parseCategories(response.data));
    }).catchError((error) {
      Helper.errorSnackBar(LocaleKeys.shared_error.tr, error.toString());
    }).whenComplete(() => isLoading(false));
  }

  @override
  void onInit() {
    super.onInit();
    getCategories();
  }
}
