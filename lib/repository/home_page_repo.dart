import 'package:dio/dio.dart';
import 'package:my_market/helper/constants.dart';
import 'package:my_market/repository/api_client.dart';

class HomePageRepo {
  Dio _dio = ApiClient.getDio();

  Future<Response> getCategories() {
    return _dio.get(Constants.url_categories);
  }

  Future<Response> getProducts() {
    return _dio.get(Constants.url_products);
  }

  Future<Response> getShoppingList() {
    return _dio.get(Constants.url_shopping_list);
  }
}
