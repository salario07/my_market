import 'package:flutter/material.dart';
import 'package:my_market/helper/app_colors.dart';

class MyDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      color: AppColors.colorDivider,
    );
  }
}
