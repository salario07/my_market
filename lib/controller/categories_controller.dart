import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:my_market/generated/locales.g.dart';
import 'package:my_market/helper/helper.dart';
import 'package:my_market/helper/json_parser.dart';
import 'package:my_market/model/category.dart';
import 'package:my_market/model/product.dart';
import 'package:my_market/repository/categories_repo.dart';

class CategoriesController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isAddEditLoading = false.obs;
  RxBool isProductsLoading = false.obs;
  RxList<Category> categories = [].cast<Category>().obs;
  RxList<Product> categoryProducts = [].cast<Product>().obs;
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

  void addCategory(Category category) {
    isAddEditLoading(true);
    repository.addCategory(category).then((value) {
      getCategories();
      Get.back(result: true);
    }).catchError((error) {
      Helper.errorSnackBar(LocaleKeys.shared_error.tr, error.toString());
    }).whenComplete(() => isAddEditLoading(false));
  }

  void editCategory(Category category) {
    isAddEditLoading(true);
    repository.editCategory(category).then((value) {
      getCategories();
      Get.back(result: true);
    }).catchError((error) {
      Helper.errorSnackBar(LocaleKeys.shared_error.tr, error.toString());
    }).whenComplete(() => isAddEditLoading(false));
  }

  void deleteCategory(Category category) {
    repository.deleteCategory(category).then((value) {
      getCategories();
      Helper.successSnackBar(LocaleKeys.shared_success.tr,
          LocaleKeys.categories_category_deleted_successfully.tr);
    }).catchError((error) {
      Helper.errorSnackBar(LocaleKeys.shared_error.tr, error.toString());
    });
  }

  void getCategoryProducts(int categoryId) {
    isProductsLoading(true);
    repository.getProducts().then((response) {
      List<Product> allProducts = JsonParser.parseProducts(response.data);
      categoryProducts(Helper.getThisCategoryProductList(allProducts, categoryId));
    }).catchError((error) {
      Helper.errorSnackBar(LocaleKeys.shared_error.tr, error.toString());
    }).whenComplete(() => isProductsLoading(false));
  }

  Future<Response> getCategoryProductsAsync(int categoryId) async{
    return await repository.getProducts();
  }


  @override
  void onInit() {
    super.onInit();
    getCategories();
  }
}
