import 'package:my_market/model/category.dart';
import 'package:my_market/model/product.dart';
import 'package:my_market/model/user.dart';

class JsonParser {
  static List<User> parseUsers(List<dynamic> responseBody) {
    List<User> users = [];

    for (var i = 0; i < responseBody.length; ++i) {
      users.add(User.fromJson(responseBody[i]));
    }

    return users;
  }

  static List<Category> parseCategories(List<dynamic> responseBody) {
    List<Category> categories = [];

    for (var i = 0; i < responseBody.length; ++i) {
      categories.add(Category.fromJson(responseBody[i]));
    }

    return categories;
  }

  static List<Product> parseProducts(List<dynamic> responseBody) {
    List<Product> products = [];

    for (var i = 0; i < responseBody.length; ++i) {
      products.add(Product.fromJson(responseBody[i]));
    }

    return products;
  }
}
