import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:my_market/generated/locales.g.dart';
import 'package:my_market/helper/helper.dart';
import 'package:my_market/helper/json_parser.dart';
import 'package:my_market/helper/shared_pref.dart';
import 'package:my_market/model/user.dart';
import 'package:my_market/repository/sign_up_repo.dart';
import 'package:my_market/widget/ui/home_page.dart';

class SignUpController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool obscurePassword = true.obs;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  SignUpRepo repository = SignUpRepo();

  void signUp(User user) {
    isLoading(true);
    _checkUsername(user);
  }

  void _checkUsername(User user) {
    repository.getUsers().then((response) {
      List<User> users = JsonParser.parseUsers(response.data);
      bool doesUserNameAlreadyExists =
          _doesUsernameExists(users, user.userName);
      if (!doesUserNameAlreadyExists) {
        _addUser(user);
      } else {
        isLoading(false);
        Helper.errorSnackBar(LocaleKeys.sign_up_username_already_exists.tr,
            LocaleKeys.sign_up_please_enter_another_username.tr);
      }
    }).catchError((error) {
      isLoading(false);
      Helper.errorSnackBar(LocaleKeys.shared_error.tr, error.toString());
    });
  }

  void _addUser(User user) {
    repository.addUser(user).then((response) {
      SharedPref.setUserLoggedIn(true);
      Helper.successSnackBar(LocaleKeys.shared_success.tr,
          LocaleKeys.sign_up_signed_up_successfully.tr);
      _navigateToHomePage();
    }).catchError((error) {
      Helper.errorSnackBar(LocaleKeys.shared_error.tr, error.toString());
    }).whenComplete(() => isLoading(false));
  }

  bool _doesUsernameExists(List<User> users, String userName) {
    for (User user in users) {
      if (user.userName == userName) {
        return true;
      }
    }
    return false;
  }

  void _navigateToHomePage() {
    Future.delayed(Duration(seconds: 1)).then((value) {
      Get.offAll(() => HomePage());
    });
  }
}
