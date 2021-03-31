import 'package:get/get.dart';
import 'package:my_market/generated/locales.g.dart';
import 'package:my_market/helper/constants.dart';
import 'package:my_market/helper/helper.dart';
import 'package:my_market/helper/json_parser.dart';
import 'package:my_market/model/product.dart';
import 'package:my_market/model/shopping_item.dart';
import 'package:my_market/repository/show_product_repo.dart';

class ShowProductController extends GetxController {
  Rx<Product> product = Product.getDefault().obs;
  RxBool isLoading = true.obs;
  RxInt productCount = 0.obs;
  RxInt cartCount = 0.obs;
  RxBool isProductCountLoaded = false.obs;

  ShowProductRepo repository = ShowProductRepo();

  final int id;

  ShowProductController(this.id);

  void getProduct(int id) {
    isLoading(true);
    repository.getProduct(id).then((response) {
      Product fetchedProduct = JsonParser.parseProducts(response.data)[0];
      product(fetchedProduct);
    }).catchError((error) {
      Helper.errorSnackBar(LocaleKeys.shared_error, error.toString());
    }).whenComplete(() => isLoading(false));
  }

  void getProductCount() {
    repository.getShoppingCount(id).then((response) {
      ShoppingItem shoppingItem = ShoppingItem.fromJson(response.data);
      productCount(shoppingItem.count);
    }).catchError((error) {
      productCount(0);
    }).whenComplete(() => isProductCountLoaded(true));
  }

  void updateShoppingCount(int count) {
    repository.updateItemCount(product().id, count).then((response) {
      getProductCount();
    }).catchError((error) {
      Helper.errorSnackBar(LocaleKeys.shared_error, error.toString());
    });
  }

  void removeFromShoppingList() {
    repository.removeFromShoppingList(id).then((response) {
      getProductCount();
      getShoppingListCount();
    }).catchError((error) {
      Helper.errorSnackBar(LocaleKeys.shared_error, error.toString());
    });
  }

  void addToShoppingList() {
    repository.addToShoppingList(getDefaultShoppingItem()).then((response) {
      getProductCount();
      getShoppingListCount();
    }).catchError((error) {
      Helper.errorSnackBar(LocaleKeys.shared_error, error.toString());
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

  ShoppingItem getDefaultShoppingItem() {
    return ShoppingItem(id: product().id, product: product(), count: 1);
  }

  @override
  void onInit() {
    super.onInit();
    getProduct(id);
    getProductCount();
    getShoppingListCount();
  }
}
