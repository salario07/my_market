import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_market/controller/login_controller.dart';
import 'package:my_market/generated/locales.g.dart';
import 'package:my_market/helper/helper.dart';
import 'package:my_market/model/user.dart';
import 'package:my_market/widget/component/my_button.dart';
import 'package:my_market/widget/component/my_progress_indicator.dart';
import 'package:my_market/widget/component/my_text_button.dart';
import 'package:my_market/widget/component/my_text_field.dart';
import 'package:my_market/widget/ui/sign_up.dart';

class Login extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<LoginController>(() => LoginController());
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.shared_login.tr),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(24),
          child: (Form(
            key: _controller.formKey,
            child: Column(
              children: [
                buildUsernameTextField(),
                SizedBox(height: 12),
                buildPasswordTextField(),
                buildLoginButton(),
                Text(LocaleKeys.login_not_a_member.tr),
                SizedBox(height: 8),
                MyTextButton(LocaleKeys.shared_sign_up.tr,
                    () => Get.off(() => SignUp())),
              ],
            ),
          )),
        ),
      ),
    );
  }

  Obx buildPasswordTextField() {
    return Obx(
      () => MyTextField(
        controller: _passwordController,
        labelText: LocaleKeys.shared_password.tr,
        hintText: LocaleKeys.shared_password_hint.tr,
        validator: (text) => Helper.passwordValidator(text),
        suffixIconGestureDetector: getGestureDetectorSuffixIcon(true),
        obscureText: _controller.obscurePassword(),
        textInputAction: TextInputAction.done,
      ),
    );
  }

  MyTextField buildUsernameTextField() {
    return MyTextField(
      controller: _usernameController,
      labelText: LocaleKeys.shared_user_name.tr,
      hintText: LocaleKeys.shared_user_name_hint.tr,
      validator: (text) => Helper.emptyValidator(text),
      suffixIconGestureDetector: getGestureDetectorSuffixIcon(false),
    );
  }

  Obx buildLoginButton() {
    return Obx(() {
      return MyButton(
          _controller.isLoading()
              ? MyProgressIndicator()
              : Text(LocaleKeys.shared_login.tr),
          _controller.isLoading() ? null : onLogin);
    });
  }

  void onLogin() {
    if (_controller.formKey.currentState.validate()) {
      _controller.login(buildUserFromInput());
    }
  }

  Widget getGestureDetectorSuffixIcon(bool isPassword) {
    return GestureDetector(
        child: getTextFieldSuffixIcon(isPassword),
        onTap: () {
          if (isPassword) {
            _controller.obscurePassword(!_controller.obscurePassword());
          }
        });
  }

  Widget getTextFieldSuffixIcon(bool isPassword) {
    if (isPassword) {
      return _controller.obscurePassword()
          ? Icon(Icons.visibility_off)
          : Icon(Icons.visibility);
    } else {
      return SizedBox();
    }
  }

  User buildUserFromInput() {
    return User(
        userName: _usernameController.text, password: _passwordController.text);
  }

  LoginController get _controller => Get.find<LoginController>();
}
