import 'package:flutter/material.dart';
import 'package:my_market/helper/app_colors.dart';

class TextTitle extends StatelessWidget {
  final String text;
  final TextAlign textAlign;

  TextTitle(this.text,{this.textAlign = TextAlign.start});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
          color: AppColors.colorText,
          fontSize: 18,
          fontWeight: FontWeight.bold),
    );
  }
}
