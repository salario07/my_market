import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(Dimens.dialog_border_radius))),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: buildContent(),
      ),
    );
  }

  Column buildContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        buildTitle(),
        SizedBox(
          height: 16,
        ),
        Text(message),
        SizedBox(
          height: 32,
        ),
        buildButtons(),
      ],
    );
  }

  Row buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildNegativeButton(),
        SizedBox(
          width: 24,
        ),
        buildPositiveButton(),
      ],
    );
  }

  TextButton buildNegativeButton() {
    return TextButton(
        onPressed: () {
          Get.back();
        },
        child: Text(negative));
  }

  ElevatedButton buildPositiveButton() {
    return ElevatedButton(
        onPressed: () {
          onPositiveTap();
          Get.back();
        },
        child: Text(positive));
  }

  Text buildTitle() {
    return Text(
      title,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}
