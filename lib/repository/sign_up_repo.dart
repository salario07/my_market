import 'package:dio/dio.dart';
import 'package:my_market/helper/constants.dart';
import 'package:my_market/model/user.dart';
import 'package:my_market/repository/api_client.dart';

class SignUpRepo {
  Dio _dio = ApiClient.getDio();

  Future<Response> getUsers() {
    return _dio.get(Constants.url_users);
  }

  Future<Response> addUser(User? user) {
    return _dio.post(Constants.url_users, data: user?.toJson());
  }
}
