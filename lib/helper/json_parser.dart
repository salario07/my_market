import 'package:my_market/model/user.dart';

class JsonParser {
  static List<User> parseUsers(List<dynamic> responseBody) {
    List<User> users = [];

    for (var i = 0; i < responseBody.length; ++i) {
      users.add(User.fromJson(responseBody[i]));
    }

    return users;
  }
}
