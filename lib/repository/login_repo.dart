import 'package:dio/dio.dart';
import 'package:my_market/helper/constants.dart';

import 'api_client.dart';

class LoginRepo {
  Dio _dio = ApiClient.getDio();

  Future<Response> getUsers() {
    return _dio.get(Constants.url_users);
  }
}
