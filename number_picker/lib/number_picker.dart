library number_picker;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:number_picker/controller/number_picker_controller.dart';

export 'number_picker.dart';

class NumberPicker extends StatelessWidget {
  final Color colorPrimary = Color(0xFF673AB7);
  final Function onIncrement, onDecrement;

  NumberPicker({this.onIncrement, this.onDecrement});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<NumberPickerController>(() => NumberPickerController());
    return Obx(() => _controller.number > 0
        ? Row(
            children: [
              buildMinusButton(),
              Text(_controller.number().toString()),
              buildPlusButton(),
            ],
          )
        : Expanded(
            child: ElevatedButton(
                child: Text('Add to Cart'), onPressed: _onIncrement),
          ));
  }

  ElevatedButton buildPlusButton() {
    return ElevatedButton(
        child: Icon(Icons.keyboard_arrow_up), onPressed: _onIncrement);
  }

  OutlinedButton buildMinusButton() {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(side: BorderSide(color: colorPrimary)),
      child: Icon(Icons.keyboard_arrow_down),
      onPressed: _onDecrement,
    );
  }

  void _onDecrement() {
    _controller.number(_controller.number() - 1);
    onDecrement();
  }

  void _onIncrement() {
    _controller.number(_controller.number() + 1);
    onIncrement();
  }

  NumberPickerController get _controller => Get.find<NumberPickerController>();
}
