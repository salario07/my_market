import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_market/controller/login_controller.dart';
import 'package:my_market/generated/locales.g.dart';
import 'package:my_market/helper/app_colors.dart';
import 'package:my_market/helper/validators.dart';
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
      backgroundColor: AppColors.colorBackground,
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(24),
          child: (buildForm()),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text(LocaleKeys.shared_login.tr),
    );
  }

  Form buildForm() {
    return Form(
      key: _controller.formKey,
      child: Column(
        children: [
          buildTextField(false,
              controller: _usernameController,
              label: LocaleKeys.shared_user_name.tr,
              hint: LocaleKeys.shared_user_name_hint.tr),
          SizedBox(height: 12),
          buildTextField(true,
              controller: _passwordController,
              label: LocaleKeys.shared_password.tr,
              hint: LocaleKeys.shared_password_hint.tr),
          buildLoginButton(),
          Text(LocaleKeys.login_not_a_member.tr),
          SizedBox(height: 8),
          MyTextButton(
              LocaleKeys.shared_sign_up.tr, () => Get.off(() => SignUp())),
        ],
      ),
    );
  }

  Widget buildTextField(bool isPassword,
      {TextEditingController controller, String label = '', String hint = ''}) {
    if (isPassword) {
      return Obx(() => MyTextField(
            validator: (text) => Validators.passwordValidator(text!=null?text:''),
            controller: controller,
            labelText: label,
            hintText: hint,
            obscureText: _controller.obscurePassword(),
            textInputAction: TextInputAction.done,
            suffixIconGestureDetector: getPasswordGestureSuffixIcon(),
          ));
    } else {
      return MyTextField(
        validator: (text) => Validators.emptyValidator(text!=null?text:''),
        controller: controller,
        labelText: label,
        hintText: hint,
        obscureText: false,
        textInputAction: TextInputAction.next,
        suffixIconGestureDetector: SizedBox(),
      );
    }
  }

  Obx buildLoginButton() {
    return Obx(() {
      return MyButton(
          _controller.isLoading()
              ? MyProgressIndicator(24)
              : Text(LocaleKeys.shared_login.tr),
          _controller.isLoading() ? null : onLogin,
      paddingVertical: 16,paddingHorizontal: 0);
    });
  }

  void onLogin() {
    if (_controller.formKey.currentState?.validate()??false) {
      _controller.login(buildUserFromInput());
    }
  }

  Widget getPasswordGestureSuffixIcon() {
    return GestureDetector(
        child: _controller.obscurePassword()
            ? Icon(Icons.visibility_off)
            : Icon(Icons.visibility),
        onTap: () {
          _controller.obscurePassword(!_controller.obscurePassword());
        });
  }

  User buildUserFromInput() {
    return User(
        userName: _usernameController.text, password: _passwordController.text);
  }

  LoginController get _controller => Get.find<LoginController>();
}
