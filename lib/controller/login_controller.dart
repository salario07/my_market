import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:my_market/generated/locales.g.dart';
import 'package:my_market/helper/helper.dart';
import 'package:my_market/helper/json_parser.dart';
import 'package:my_market/helper/shared_pref.dart';
import 'package:my_market/model/user.dart';
import 'package:my_market/repository/login_repo.dart';
import 'package:my_market/widget/ui/home_page.dart';
import 'package:my_market/widget/ui/home_page_admin.dart';
import '../helper/constants.dart';
import '../helper/constants.dart';
import '../helper/constants.dart';
import '../helper/helper.dart';
import '../helper/helper.dart';
import '../helper/helper.dart';
import '../helper/shared_pref.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool obscurePassword = true.obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  LoginRepo repository = LoginRepo();

  void login(User user) {
    isLoading(true);
    getUsers().then((response) {
      List<User> users = JsonParser.parseUsers(response.data);
      _handleLoginResponse(users, user);
    }).catchError((error) {
      Helper.errorSnackBar(LocaleKeys.shared_error.tr, error.toString());
    }).whenComplete(() => isLoading(false));
  }

  void _handleLoginResponse(List<User> users, User loggedInUser) {
    bool allowLogin = _checkCredentials(users, loggedInUser);
    if (allowLogin) {
      bool isAdmin = _isUserAdmin(users, loggedInUser);
      SharedPref.setUserLoggedIn(true);
      SharedPref.setUserAdmin(isAdmin);
      Helper.successSnackBar(LocaleKeys.shared_success.tr,
          LocaleKeys.login_logged_in_successfully.tr);
          isAdmin? _navigateToHomePageAdmin()
          : _navigateToHomePage();
    } else {
      Helper.errorSnackBar(LocaleKeys.login_invalid_credentials.tr,
          LocaleKeys.login_username_or_password_is_incorrect.tr);
    }
  }

  Future<Response> getUsers() {
    return repository.getUsers();
  }

  bool _checkCredentials(List<User> users, User loggedInUser) {
    for (User user in users) {
      if (areTwoUsersTheSame(user, loggedInUser)) {
        return true;
      }
    }
    return false;
  }

  bool _isUserAdmin(List<User> users, User loggedInUser) {
    for (User user in users) {
      if (areTwoUsersTheSame(user, loggedInUser)) {
        return user.role == Constants.role_admin;
      }
    }
    return false;
  }

  bool areTwoUsersTheSame(User user, User loggedInUser) {
    return user.userName?.toLowerCase() == loggedInUser.userName?.toLowerCase() &&
        user.password == loggedInUser.password;
  }

  void _navigateToHomePage() {
    Future.delayed(Duration(milliseconds: Constants.snackbar_delay_milliseconds))
        .then((value) {
      Get.offAll(() => HomePage());
    });
  }

  void _navigateToHomePageAdmin() {
    Future.delayed(Duration(milliseconds: Constants.snackbar_delay_milliseconds))
        .then((value) {
      Get.offAll(() => HomePageAdmin());
    });
  }
}
