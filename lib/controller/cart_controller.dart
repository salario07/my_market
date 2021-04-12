import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:my_market/generated/locales.g.dart';
import 'package:my_market/helper/helper.dart';
import 'package:my_market/helper/json_parser.dart';
import 'package:my_market/model/product.dart';
import 'package:my_market/model/shopping_item.dart';
import 'package:my_market/repository/cart_repo.dart';

class CartController extends GetxController {
  RxBool isPurchaseLoading = false.obs;
  RxList<ShoppingItem> shoppingItems = [].cast<ShoppingItem>().obs;

  CartRepo repository = CartRepo();

  void getShoppingList() {
    repository.getShoppingList().then((response) {
      shoppingItems(JsonParser.parseShoppingItems(response.data));
    }).catchError((error) {
      Helper.errorSnackBar(LocaleKeys.shared_error.tr, error.toString());
      Helper.logDebug(error.toString());
    });
  }

  void removeItem(int id) {
    repository.removeItem(id).then((response) {
      getShoppingList();
    }).catchError((error) {
      Helper.errorSnackBar(LocaleKeys.shared_error.tr, error.toString());
      Helper.logDebug(error.toString());
    });
  }

  void updateItemCount(ShoppingItem shoppingItem) {
    repository.updateItemCount(shoppingItem).then((response) {
      getShoppingList();
    }).catchError((error) {
      Helper.errorSnackBar(LocaleKeys.shared_error.tr, error.toString());
      Helper.logDebug(error.toString());
    });
  }

  void purchase() async {
    bool isPurchaseSuccessful = true;
    bool purchasedAtLeastOneProduct = false;
    isPurchaseLoading(true);
    for (var i = 0; i < shoppingItems().length; ++i) {
      Response response =
          await repository.updateStock(reduceProductStock(shoppingItems()[i]));
      if (Helper.isSuccessful(response.statusCode)) {
        repository.removeItem(shoppingItems()[i].id);
        purchasedAtLeastOneProduct = true;
      } else {
        isPurchaseSuccessful = false;
      }
    }
    getShoppingList();
    isPurchaseLoading(false);
    handleUserNotification(isPurchaseSuccessful, purchasedAtLeastOneProduct);
  }

  void handleUserNotification(
      bool isPurchaseSuccessful, bool purchasedAtLeastOneProduct) {
    if (isPurchaseSuccessful) {
      Helper.successSnackBar(LocaleKeys.shared_success.tr,
          LocaleKeys.cart_purchase_was_successful.tr);
    } else if (purchasedAtLeastOneProduct) {
      Helper.errorSnackBar(LocaleKeys.shared_error.tr,
          LocaleKeys.cart_purchase_half_success_message.tr);
    } else {
      Helper.errorSnackBar(
          LocaleKeys.shared_error.tr, LocaleKeys.cart_purchase_fail_message.tr);
    }
  }

  Product reduceProductStock(ShoppingItem item) {
    int newStock = item.product.stock - item.count;
    if (newStock < 0) {
      newStock = 0;
    }
    item.product.stock = newStock;
    return item.product;
  }

  @override
  void onInit() {
    super.onInit();
    getShoppingList();
  }
}
