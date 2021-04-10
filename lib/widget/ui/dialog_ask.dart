import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_market/helper/app_colors.dart';
import 'package:my_market/helper/dimens.dart';

class DialogAsk extends StatelessWidget {
  final String title, message, positive, negative;
  final Function onPositiveTap;

  DialogAsk(
      {this.title,
      this.message,
      this.positive,
      this.negative,
      this.onPositiveTap});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.colorSurface,
      shape: _buildShape(),
      content: Padding(
        padding: EdgeInsets.only(top: 16),
        child: _buildContent(),
      ),
    );
  }

  RoundedRectangleBorder _buildShape() {
    return RoundedRectangleBorder(
        borderRadius:
            BorderRadius.all(Radius.circular(Dimens.dialog_border_radius)));
  }

  Column _buildContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildTitle(),
        SizedBox(
          height: 16,
        ),
        Text(message),
        SizedBox(
          height: 32,
        ),
        _buildButtons(),
      ],
    );
  }

  Row _buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildNegativeButton(),
        SizedBox(
          width: 24,
        ),
        _buildPositiveButton(),
      ],
    );
  }

  TextButton _buildNegativeButton() {
    return TextButton(
        onPressed: () {
          Get.back();
        },
        child: Text(negative));
  }

  ElevatedButton _buildPositiveButton() {
    return ElevatedButton(
        onPressed: () {
          onPositiveTap();
          Get.back();
        },
        child: Text(positive));
  }

  Text _buildTitle() {
    return Text(
      title,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}
