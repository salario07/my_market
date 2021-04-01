library number_picker;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:number_picker/controller/number_picker_controller.dart';

export 'number_picker.dart';

class NumberPicker extends StatelessWidget {
  final Color colorPrimary = Color(0xFF673AB7);
  final Color colorBackground = Color(0xFFFBFBFB);
  final Function onIncrement, onDecrement;
  final int initCount;
  final int maxCount;
  final double horizontalPadding;

  NumberPicker(
      {this.onIncrement,
      this.onDecrement,
      this.initCount = 1,
      this.maxCount = 100,
      this.horizontalPadding = 16});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<NumberPickerController>(
        () => NumberPickerController(initCount));
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: horizontalPadding),
      child: Obx(() => Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              buildMinusButton(),
              buildCounterNumber(),
              buildPlusButton(),
            ],
          )),
    );
  }

  Container buildCounterNumber() => Container(
      width: 40,
      child: Text(
        _controller.number().toString(),
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        textAlign: TextAlign.center,
      ));

  Widget buildPlusButton() {
    return Obx(
      () => ElevatedButton(
          child: Icon(Icons.keyboard_arrow_up),
          onPressed: maxCount <= _controller.number() ? null : _onIncrement),
    );
  }

  OutlinedButton buildMinusButton() {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(side: BorderSide(color: colorPrimary)),
      child: Icon(Icons.keyboard_arrow_down),
      onPressed: _onDecrement,
    );
  }

  void _onDecrement() {
    if(_controller.number()!=1){
      _controller.number(_controller.number() - 1);
    }
    onDecrement();
  }

  void _onIncrement() {
    _controller.number(_controller.number() + 1);
    onIncrement();
  }

  bool isMaxCountReached() {
    return maxCount < _controller.number();
  }

  void setNumber(int number){
    _controller.number(number);
  }

  NumberPickerController get _controller => Get.find<NumberPickerController>();
}
