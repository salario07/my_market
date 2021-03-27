import 'helper.dart';

class Validators {
  static String emptyValidator(String text) {
    return Helper.isNullOrEmpty(text) ? 'Required' : null;
  }

  static String passwordValidator(String text) {
    return text.length >= 6 ? null : 'Password must be at least 6 characters';
  }

  static String getValidator(bool isPassword, String text) {
    return isPassword
        ? passwordValidator(text)
        : emptyValidator(text);
  }
}