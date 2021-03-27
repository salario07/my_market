import 'package:flutter/material.dart';
import 'package:my_market/helper/app_colors.dart';

class MyProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      backgroundColor: AppColors.colorAccent,
    );
  }
}
