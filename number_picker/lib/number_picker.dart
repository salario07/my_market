library number_picker;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:number_picker/controller/number_picker_controller.dart';
import 'package:number_picker/generated/locales.g.dart';

import 'widget/my_button.dart';

export 'number_picker.dart';
export 'generated/locales.g.dart';

class NumberPicker extends StatelessWidget {
  final Color colorPrimary = Color(0xFF673AB7);
  final Color colorBackground = Color(0xFFFBFBFB);
  final Function onIncrement, onDecrement;

  NumberPicker({this.onIncrement, this.onDecrement});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<NumberPickerController>(() => NumberPickerController());
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Obx(() => _controller.number > 0
            ? Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  buildMinusButton(),
                  buildCounterNumber(),
                  buildPlusButton(),
                ],
              )
            : Expanded(
                child: MyButton(Text(LocaleKeys.add_to_cart.tr), _onIncrement),
              )),
      ),
    );
  }

  Container buildCounterNumber() => Container(
      width: 40,
      child: Text(
        _controller.number().toString(),
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        textAlign: TextAlign.center,
      ));

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
