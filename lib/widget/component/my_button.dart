import 'package:flutter/material.dart';
import 'package:my_market/helper/dimens.dart';

class MyButton extends StatelessWidget {

  final Widget child;
  final Function onTap;

  MyButton(this.child,this.onTap);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88,
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 0),
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
