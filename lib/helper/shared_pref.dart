import 'package:get_storage/get_storage.dart';
import 'package:my_market/helper/constants.dart';
import 'package:my_market/helper/helper.dart';
import 'package:my_market/model/user.dart';

class SharedPref {
  static void setUserLoggedIn(bool loggedIn) {
    GetStorage().write(Constants.shared_pref_key_is_user_logged_in, loggedIn);
  }

  static bool isUserLoggedIn() {
    return GetStorage()?.read(Constants.shared_pref_key_is_user_logged_in) ??
        false;
  }

  static void setUserAdmin(bool isAdmin) {
    GetStorage().write(Constants.shared_pref_key_is_user_admin, isAdmin);
  }

  static bool isUserAdmin() {
    return GetStorage()?.read(Constants.shared_pref_key_is_user_admin) ?? false;
  }

  static void setLocale(String locale) {
    GetStorage().write(Constants.shared_pref_key_locale, locale);
  }

  static String getLocale() {
    return GetStorage()?.read(Constants.shared_pref_key_locale) ??
        Constants.locale_english;
  }

  static void setUser(User user) {
    GetStorage().write(Constants.shared_pref_key_user, user.toJson());
  }

  static User getUser() {
    Map<String, dynamic> json =
        GetStorage()?.read(Constants.shared_pref_key_user) ?? {};
    if (json.isEmpty) {
      return User();
    }
    return User.fromJson(json);
  }

  static String getUserFullName() {
    User user = getUser();
    if (Helper.isNullOrEmpty(user.firstName)) {
      return '';
    }
    return '${user.firstName} ${user.lastName}';
  }
}
