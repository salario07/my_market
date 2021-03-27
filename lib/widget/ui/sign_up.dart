import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_market/controller/sign_up_controller.dart';
import 'package:my_market/generated/locales.g.dart';
import 'package:my_market/helper/constants.dart';
import 'package:my_market/helper/validators.dart';
import 'package:my_market/model/user.dart';
import 'package:my_market/widget/component/my_button.dart';
import 'package:my_market/widget/component/my_progress_indicator.dart';
import 'file:///D:/Salar/flutter/MyMarket/my_market/lib/widget/ui/login.dart';
import 'package:my_market/widget/component/my_text_button.dart';
import 'package:my_market/widget/component/my_text_field.dart';

class SignUp extends StatelessWidget {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<SignUpController>(() => SignUpController());
    return Scaffold(
        appBar: buildAppBar(),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(24),
            child: buildForm(),
          ),
        ));
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text(LocaleKeys.shared_sign_up.tr),
    );
  }

  Form buildForm() {
    return Form(
      key: _controller.formKey,
      child: Column(
        children: [
          buildTextField(
            true,
            controller: _firstNameController,
            hint: LocaleKeys.sign_up_first_name_hint.tr,
            label: LocaleKeys.sign_up_first_name.tr,
          ),
          SizedBox(height: 12),
          buildTextField(
            true,
            controller: _lastNameController,
            hint: LocaleKeys.sign_up_last_name_hint.tr,
            label: LocaleKeys.sign_up_last_name.tr,
          ),
          SizedBox(height: 12),
          buildTextField(
            true,
            controller: _userNameController,
            hint: LocaleKeys.shared_user_name_hint.tr,
            label: LocaleKeys.shared_user_name.tr,
          ),
          SizedBox(height: 12),
          buildTextField(
            true,
            controller: _passwordController,
            hint: LocaleKeys.shared_password_hint.tr,
            label: LocaleKeys.shared_password.tr,
          ),
          buildSignUpButton(),
          Text(LocaleKeys.sign_up_already_registered.tr),
          SizedBox(height: 8),
          MyTextButton(
              LocaleKeys.shared_login.tr, () => Get.off(() => Login())),
        ],
      ),
    );
  }

  Obx buildSignUpButton() {
    return Obx(() {
      return MyButton(
          _controller.isLoading()
              ? SizedBox(height: 24, width: 24, child: MyProgressIndicator())
              : Text(LocaleKeys.shared_sign_up.tr),
          _controller.isLoading() ? null : onSignUp);
    });
  }

  Widget buildTextField(bool isPassword,
      {TextEditingController controller, String label, String hint}) {
    MyTextField myTextField = MyTextField(
      validator: (text) => Validators.getValidator(isPassword, text),
      controller: controller,
      labelText: label,
      hintText: hint,
      obscureText: isPassword,
      textInputAction: isPassword ? TextInputAction.done : TextInputAction.next,
      suffixIconGestureDetector: getGestureDetectorSuffixIcon(isPassword),
    );
    if (isPassword) {
      return Obx(() => myTextField);
    } else {
      return myTextField;
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

  void onSignUp() {
    if (_controller.formKey.currentState.validate()) {
      _controller.signUp(buildUserFromInput());
    }
  }

  User buildUserFromInput() {
    return User(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        userName: _userNameController.text,
        password: _passwordController.text,
        role: Constants.role_user);
  }

  SignUpController get _controller => Get.find<SignUpController>();
}
