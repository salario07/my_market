import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_market/helper/app_colors.dart';
import 'package:my_market/helper/dimens.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String Function(String) validator;
  final bool obscureText;
  final TextInputAction textInputAction;
  final String labelText;
  final String hintText;
  final Widget suffixIconGestureDetector;
  final bool enabled;
  final TextInputType textInputType;
  final int maxLines;

  MyTextField(
      {this.controller,
      this.validator,
      this.obscureText = false,
      this.textInputAction = TextInputAction.next,
      this.labelText = '',
      this.hintText = '',
      this.suffixIconGestureDetector,
      this.enabled = true,
      this.textInputType = TextInputType.text,
      this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      validator: validator,
      controller: controller,
      obscureText: obscureText,
      textInputAction: textInputAction,
      keyboardType: textInputType,
      maxLines: maxLines,
      inputFormatters: textInputType == TextInputType.number
          ? [FilteringTextInputFormatter.digitsOnly]
          : [],
      decoration: InputDecoration(
          suffixIcon: suffixIconGestureDetector,
          labelText: labelText,
          hintText: hintText,
          border: buildInputBorder(false),
          errorBorder: buildInputBorder(true)),
    );
  }

  OutlineInputBorder buildInputBorder(bool isError) {
    return OutlineInputBorder(
        borderRadius:
            BorderRadius.all(Radius.circular(Dimens.edit_text_border_radius)),
        borderSide: BorderSide(
            width: 1,
            color:
                isError ? AppColors.colorError : AppColors.colorPrimaryLight));
  }
}
