import 'package:get_storage/get_storage.dart';
import 'package:my_market/helper/constants.dart';

class SharedPref {
  static void setUserLoggedIn(bool loggedIn) {
    GetStorage().write(Constants.shared_pref_key_is_user_logged_in, loggedIn);
  }

  static bool isUserLoggedIn() {
    return GetStorage().read(Constants.shared_pref_key_is_user_logged_in);
  }

  static void setLocale(String locale) {
    GetStorage().write(Constants.shared_pref_key_locale, locale);
  }

  static String getLocale() {
    return GetStorage().read(Constants.shared_pref_key_locale);
  }
}
