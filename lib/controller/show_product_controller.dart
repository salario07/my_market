import 'package:get/get.dart';
import 'package:my_market/generated/locales.g.dart';
import 'package:my_market/helper/helper.dart';
import 'package:my_market/helper/json_parser.dart';
import 'package:my_market/model/product.dart';
import 'package:my_market/repository/show_product_repo.dart';

class ShowProductController extends GetxController {
  Rx<Product> product = Product.getDefault().obs;
  RxBool isLoading = true.obs;
  RxInt number = 0.obs;

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

  @override
  void onInit() {
    super.onInit();
    getProduct(id);
  }
}
