import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:my_market/generated/locales.g.dart';
import 'package:my_market/helper/helper.dart';
import 'package:my_market/helper/json_parser.dart';
import 'package:my_market/model/user.dart';
import 'package:my_market/repository/login_repo.dart';
import 'package:my_market/widget/ui/home_page.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool obscurePassword = true.obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  LoginRepo repository = LoginRepo();

  void login(User user) {
    isLoading(true);
    getUsers().then((response) {
      List<User> users = JsonParser.parseUsers(response.data);
      bool allowLogin = _checkCredentials(users, user);
      _handleLoginResponse(allowLogin);
    }).catchError((error) {
      Helper.errorSnackBar(LocaleKeys.shared_error, error.toString());
    }).whenComplete(() => isLoading(false));
  }

  void _handleLoginResponse(bool allowLogin) {
    if (allowLogin) {
      Helper.successSnackBar(LocaleKeys.shared_success.tr,
          LocaleKeys.login_logged_in_successfully.tr);
      _navigateToHomePage();
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
      if (user.userName == loggedInUser.userName &&
          user.password == loggedInUser.password) {
        return true;
      }
    }
    return false;
  }

  void _navigateToHomePage() {
    Future.delayed(Duration(seconds: 3)).then((value) {
      Get.off(() => HomePage());
    });
  }
}
