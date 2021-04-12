import 'package:get/get.dart';
import 'package:my_market/generated/locales.g.dart';
import 'package:my_market/helper/helper.dart';
import 'package:my_market/helper/json_parser.dart';
import 'package:my_market/model/product.dart';
import 'package:my_market/model/shopping_item.dart';
import 'package:my_market/repository/show_product_repo.dart';

class ShowProductController extends GetxController {
  bool isAdmin;
  Rx<Product> product = Product.getDefault().obs;
  RxBool isLoading = true.obs;
  RxInt productCount = 0.obs;
  RxInt cartCount = 0.obs;
  RxBool isProductCountLoaded = false.obs;

  ShowProductRepo repository = ShowProductRepo();

  ShowProductController(this.isAdmin);

  void getProduct(int id) {
    isLoading(true);
    repository.getProduct(id).then((response) {
      Product fetchedProduct = JsonParser.parseProducts(response.data)[0];
      product(fetchedProduct);
    }).catchError((error) {
      Helper.errorSnackBar(LocaleKeys.shared_error, error.toString());
      Helper.logDebug(error.toString());
    }).whenComplete(() => isLoading(false));
  }

  void getProductCount(int id) {
    repository.getShoppingCount(id).then((response) {
      ShoppingItem shoppingItem = ShoppingItem.fromJson(response.data);
      Helper.logDebug('count is ${shoppingItem.count}');
      productCount(shoppingItem.count);
    }).catchError((error) {
      productCount(0);
      Helper.logDebug(error.toString());
    }).whenComplete(() => isProductCountLoaded(true));
  }

  void updateShoppingCount(int id,int count) {
    repository.updateItemCount(product().id, count).then((response) {
      getProductCount(id);
    }).catchError((error) {
      Helper.logDebug(error.toString());
      Helper.errorSnackBar(LocaleKeys.shared_error, error.toString());
    });
  }

  void removeFromShoppingList(int id) {
    repository.removeFromShoppingList(id).then((response) {
      getProductCount(id);
      getShoppingListCount();
    }).catchError((error) {
      Helper.errorSnackBar(LocaleKeys.shared_error, error.toString());
      Helper.logDebug(error.toString());
    });
  }

  void addToShoppingList(int id,) {
    repository.addToShoppingList(getDefaultShoppingItem()).then((response) {
      getProductCount(id);
      getShoppingListCount();
    }).catchError((error) {
      Helper.errorSnackBar(LocaleKeys.shared_error, error.toString());
      Helper.logDebug(error.toString());
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

  void removeProduct(int id) {
    repository.removeProduct(id).then((value) {
      Get.back(result: id);
    }).catchError((error) {
      Helper.errorSnackBar(LocaleKeys.shared_error.tr, error.toString());
    });
  }

  ShoppingItem getDefaultShoppingItem() {
    return ShoppingItem(id: product().id, product: product(), count: 1);
  }

  @override
  void onInit() {
    super.onInit();
  }

  void updateData(int id) {
    getProduct(id);
    if(!isAdmin){
      getProductCount(id);
      getShoppingListCount();
    }
  }
}
