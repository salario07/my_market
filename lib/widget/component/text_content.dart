import 'package:flutter/material.dart';
import 'package:my_market/helper/app_colors.dart';

class TextContent extends StatelessWidget {
  final String text;
  final TextAlign textAlign;

  TextContent(this.text,{this.textAlign = TextAlign.start});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
          color: AppColors.colorText,
          fontSize: 16,
          fontWeight: FontWeight.normal),
    );
  }
}
