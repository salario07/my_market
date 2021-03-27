import 'package:dio/dio.dart';
import 'package:my_market/helper/constants.dart';

class ApiClient {
  static Dio getDio() {
    Dio _dio = Dio(BaseOptions(
      baseUrl: Constants.base_url,
      contentType: Constants.content_type,
    ));
    _dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true,
        requestHeader: false,
        responseHeader: false));
    return _dio;
  }
}
