import 'package:flutter/material.dart';
import 'package:my_market/helper/app_colors.dart';

class TextLabel extends StatelessWidget {
  final String text;
  final TextAlign textAlign;

  TextLabel(this.text, {this.textAlign = TextAlign.start});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
          color: AppColors.colorTextLight,
          fontSize: 14,
          fontWeight: FontWeight.normal),
    );
  }
}
