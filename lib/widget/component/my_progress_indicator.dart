import 'package:flutter/material.dart';
import 'package:my_market/helper/app_colors.dart';

class MyProgressIndicator extends StatelessWidget {
  final double size;

  MyProgressIndicator(this.size);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: CircularProgressIndicator(
        backgroundColor: AppColors.colorAccent,
      ),
    );
  }
}
