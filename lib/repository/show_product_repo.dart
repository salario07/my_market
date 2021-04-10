import 'package:dio/dio.dart';
import 'package:my_market/helper/constants.dart';
import 'package:my_market/model/shopping_item.dart';

import 'api_client.dart';

class ShowProductRepo {
  Dio _dio = ApiClient.getDio();

  Future<Response> getProduct(int id) {
    return _dio
        .get(Constants.url_products, queryParameters: {Constants.id: id});
  }

  Future<Response> addToShoppingList(ShoppingItem shoppingItem) {
    return _dio.post(Constants.url_shopping_list, data: shoppingItem.toJson());
  }

  Future<Response> removeFromShoppingList(int id) {
    return _dio.delete('${Constants.url_shopping_list}/$id');
  }

  Future<Response> updateItemCount(int id,int count) {
    return _dio.patch('${Constants.url_shopping_list}/$id',
        data: {Constants.count: count});
  }

  Future<Response> getShoppingCount(int id) {
    return _dio.get('${Constants.url_shopping_list}/$id');
  }

  Future<Response> getShoppingList() {
    return _dio.get(Constants.url_shopping_list);
  }

  Future<Response> removeProduct(int id) {
    return _dio.delete('${Constants.url_products}/$id');
  }

}
