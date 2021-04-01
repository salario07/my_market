import 'package:get/get.dart';
import 'package:my_market/helper/helper.dart';
import 'package:my_market/helper/json_parser.dart';
import 'package:my_market/model/product.dart';
import 'package:my_market/repository/home_page_repo.dart';

class ShowProductListController extends GetxController {
  RxInt cartCount = 0.obs;

  HomePageRepo repository = HomePageRepo();

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
    getShoppingListCount();
  }

}