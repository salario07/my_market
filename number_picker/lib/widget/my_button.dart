import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {

  final Widget child;
  final Function() onTap;

  MyButton(this.child,this.onTap);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      child: ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(8)))),
        child: child,
        onPressed: onTap,
      ),
    );
  }
}
