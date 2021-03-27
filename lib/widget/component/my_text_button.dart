import 'package:flutter/material.dart';
import 'package:my_market/helper/app_colors.dart';

class MyTextButton extends StatelessWidget {
  final String text;
  final Function onTap;

  MyTextButton(this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(
            color: AppColors.colorPrimary,
            fontSize: 16,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
