import 'package:dio/dio.dart';
import 'package:my_market/helper/constants.dart';
import 'package:my_market/model/category.dart';
import 'api_client.dart';

class CategoriesRepo {
  Dio _dio = ApiClient.getDio();

  Future<Response> getCategories() {
    return _dio.get(Constants.url_categories);
  }

  Future<Response> addCategory(Category category) {
    return _dio.post(Constants.url_categories, data: category.toJson());
  }

  Future<Response> editCategory(Category category) {
    return _dio.patch('${Constants.url_categories}/${category.id}',
        data: category.toJson());
  }

  Future<Response> deleteCategory(Category category) {
    return _dio.delete('${Constants.url_categories}/${category.id}');
  }

  Future<Response> getProducts() {
    return _dio.get(Constants.url_products);
  }
}
