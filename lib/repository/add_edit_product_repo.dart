import 'package:dio/dio.dart';
import 'package:my_market/helper/constants.dart';
import 'package:my_market/model/product.dart';
import 'api_client.dart';

class AddEditProductRepo {

  Dio _dio = ApiClient.getDio();

  Future<Response> editProduct(Product product){
    return _dio.patch('${Constants.url_products}/${product.id}',data: product.toJson());
  }

  Future<Response> addProduct(Product product){
    return _dio.post(Constants.url_products,data: product.toJson());
  }

}