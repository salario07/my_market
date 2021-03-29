import 'package:dio/dio.dart';
import 'package:my_market/helper/constants.dart';

import 'api_client.dart';

class ShowProductRepo {
  Dio _dio = ApiClient.getDio();

  Future<Response> getProduct(int id) {
    return _dio
        .get(Constants.url_products, queryParameters: {Constants.id: id});
  }
}
