import 'package:get/get.dart';
import 'package:my_market/generated/locales.g.dart';
import 'package:my_market/helper/helper.dart';
import 'package:my_market/helper/json_parser.dart';
import 'package:my_market/model/category.dart';
import 'package:my_market/model/product.dart';
import 'package:my_market/repository/home_page_repo.dart';

class HomePageController extends GetxController {
  RxList<Category> categories = [].cast<Category>().obs;
  RxList<Product> products = [].cast<Product>().obs;
  RxBool searchMode = false.obs;
  RxInt cartCount = 0.obs;

  HomePageRepo repository = HomePageRepo();

  void getCategories() {
    repository.getCategories().then((response) {
      categories(JsonParser.parseCategories(response.data));
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

  void getShoppingListCount() {
    repository.getShoppingList().then((response) {
      cartCount(JsonParser.parseShoppingItems(response.data).length);
    }).catchError((error) {
      cartCount(0);
      Helper.logDebug(error.toString());
    });
  }

  @override
  void onInit() {
    super.onInit();
    getCategories();
    getProducts();
    getShoppingListCount();
  }
}
