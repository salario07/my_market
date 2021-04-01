import 'package:dio/dio.dart';
import 'package:my_market/helper/constants.dart';
import 'package:my_market/model/product.dart';
import 'package:my_market/model/shopping_item.dart';
import 'package:my_market/repository/api_client.dart';

class CartRepo {
  Dio _dio = ApiClient.getDio();

  Future<Response> getShoppingList() {
    return _dio.get(Constants.url_shopping_list);
  }

  Future<Response> removeItem(int id) {
    return _dio.delete('${Constants.url_shopping_list}/$id');
  }

  Future<Response> updateItemCount(ShoppingItem shoppingItem) {
    return _dio.patch('${Constants.url_shopping_list}/${shoppingItem.id}',
        data: {Constants.count: shoppingItem.count});
  }

  Future<Response> updateStock(Product product) {
    return _dio.patch('${Constants.url_products}/${product.id}',
        data: product.toJson());
  }
}
