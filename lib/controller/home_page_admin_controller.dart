import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:my_market/generated/locales.g.dart';
import 'package:my_market/helper/constants.dart';
import 'package:my_market/helper/helper.dart';
import 'package:my_market/helper/json_parser.dart';
import 'package:my_market/model/category.dart';
import 'package:my_market/model/product.dart';
import 'package:my_market/repository/home_page_repo.dart';

import '../model/category.dart';
import '../model/category.dart';
import '../model/category.dart';

class HomePageAdminController extends GetxController {
  RxList<Category> categories = [].cast<Category>().obs;
  RxList<Product> products = [].cast<Product>().obs;
  RxDouble rangeMin = Constants.minRangeSlider.obs;
  RxDouble rangeMax = Constants.maxRangeSlider.obs;
  RxBool onlyAvailableProducts = false.obs;

  HomePageRepo repository = HomePageRepo();

  void getCategories() {
    repository.getCategories().then((response) {
      List<Category> allCategories = JsonParser.parseCategories(response.data);
      allCategories.add(Category());
      categories(allCategories);
    }).catchError((error) {
      Helper.errorSnackBar(LocaleKeys.shared_error.tr, error.toString());
    });
  }

  void getProducts() {
    repository.getProducts().then((response) {
      products(JsonParser.parseProducts(response.data));
    }).catchError((error) {
      Helper.logDebug(error.toString());
      Helper.errorSnackBar(LocaleKeys.shared_error.tr, error.toString());
    });
  }

  Future<Response> getProductsAsync() async {
    return await repository.getProducts();
  }

  @override
  void onInit() {
    super.onInit();
    getCategories();
    getProducts();
  }
}
