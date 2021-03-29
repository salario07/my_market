library number_picker;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:number_picker/controller/number_picker_controller.dart';
import 'package:number_picker/helper/custom_icons.dart';

export 'number_picker.dart';

class NumberPicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut<NumberPickerController>(() => NumberPickerController());
    return Obx(() => _controller.number > 0
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                child: Icon(Custom.minus),
                onPressed: onDecrement,
              ),
              Text(_controller.number().toString()),
              ElevatedButton(child: Icon(Icons.add), onPressed: onIncrement),
            ],
          )
        : ElevatedButton(child: Text('Add to Cart'), onPressed: () {}));
  }

  void onDecrement() {
    _controller.number(_controller.number() - 1);
  }

  void onIncrement() {
    _controller.number(_controller.number() + 1);
  }

  NumberPickerController get _controller => Get.find<NumberPickerController>();
}
