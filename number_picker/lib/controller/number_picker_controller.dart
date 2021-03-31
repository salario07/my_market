import 'package:get/get.dart';

class NumberPickerController extends GetxController {
  int initCount = 0;
  RxInt number;

  NumberPickerController(this.initCount) {
    print('inside number picker controller, init count is $initCount');
    number = initCount.obs;
  }
}
