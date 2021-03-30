import 'package:get/get.dart';
import 'package:my_market/generated/locales.g.dart';
import 'package:my_market/helper/helper.dart';
import 'package:my_market/helper/json_parser.dart';
import 'package:my_market/model/shopping_item.dart';
import 'package:my_market/repository/cart_repo.dart';

class CartController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<ShoppingItem> shoppingItems = [].cast<ShoppingItem>().obs;

  CartRepo repository = CartRepo();

  void getShoppingList() {
    isLoading(true);
    repository.getShoppingList().then((response) {
      shoppingItems(JsonParser.parseShoppingItems(response.data));
    }).catchError((error) {
      Helper.errorSnackBar(LocaleKeys.shared_error.tr, error.toString());
      Helper.logDebug(error.toString());
    }).whenComplete(() => isLoading(false));
  }

  @override
  void onInit() {
    super.onInit();
    getShoppingList();
  }
}
