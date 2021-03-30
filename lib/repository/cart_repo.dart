import 'package:dio/dio.dart';
import 'package:my_market/helper/constants.dart';
import 'package:my_market/repository/api_client.dart';

class CartRepo {
  Dio _dio = ApiClient.getDio();

  Future<Response> getShoppingList() {
    return _dio.get(Constants.url_shopping_list);
  }
}
