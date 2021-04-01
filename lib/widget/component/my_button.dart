import 'package:flutter/material.dart';
import 'package:my_market/helper/dimens.dart';

class MyButton extends StatelessWidget {

  final Widget child;
  final Function() onTap;
  final double paddingVertical;
  final double paddingHorizontal;

  MyButton(this.child,this.onTap,{this.paddingVertical = 8,this.paddingHorizontal = 16});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: paddingVertical, horizontal: paddingHorizontal),
      child: ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(Dimens.button_border_radius)))),
        child: child,
        onPressed: onTap,
      ),
    );
  }
}
