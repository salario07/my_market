import 'package:get_storage/get_storage.dart';
import 'package:my_market/helper/constants.dart';

class SharedPref {
  static void setUserLoggedIn(bool loggedIn) {
    GetStorage().write(Constants.is_user_logged_in, loggedIn);
  }

  static bool isUserLoggedIn() {
    return GetStorage().read(Constants.is_user_logged_in);
  }
}
