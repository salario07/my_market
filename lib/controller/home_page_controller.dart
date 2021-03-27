import 'package:get/get.dart';
import 'package:my_market/generated/locales.g.dart';
import 'package:my_market/helper/helper.dart';
import 'package:my_market/helper/json_parser.dart';
import 'package:my_market/model/category.dart';
import 'package:my_market/repository/home_page_repo.dart';

class HomePageController extends GetxController {
  RxList<Category> categories = [].cast<Category>().obs;
  RxBool isLoadingCategories = false.obs;

  HomePageRepo repository = HomePageRepo();

  void getCategories() {
    isLoadingCategories(true);
    repository.getCategories().then((response) {
      categories(JsonParser.parseCategories(response.data));
    }).catchError((error) {
      Helper.errorSnackBar(LocaleKeys.shared_error.tr, error.toString());
    }).whenComplete(() => isLoadingCategories(false));
  }

  @override
  void onInit() {
    super.onInit();
    getCategories();
  }
}
