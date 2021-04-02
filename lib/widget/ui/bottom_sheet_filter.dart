import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_market/controller/home_page_controller.dart';
import 'package:my_market/generated/locales.g.dart';
import 'package:my_market/helper/app_colors.dart';
import 'package:my_market/helper/constants.dart';
import 'package:my_market/widget/component/my_button.dart';
import 'package:my_market/widget/component/my_text_field.dart';
import 'package:my_market/widget/component/text_content.dart';

class BottomSheetFilter extends StatelessWidget {
  final TextEditingController _minController = TextEditingController();
  final TextEditingController _maxController = TextEditingController();

  BottomSheetFilter() {
    _minController.text = Constants.minRangeSlider.toInt().toString();
    _maxController.text = Constants.maxRangeSlider.toInt().toString();

    _minController.text = _controller.rangeMin().toInt().toString();
    _maxController.text = _controller.rangeMax().toInt().toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextContent(LocaleKeys.filter_price.tr),
              SizedBox(height: 16),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Flexible(
                    flex: 1,
                    child: MyTextField(
                      enabled: false,
                      controller: _minController,
                      labelText: LocaleKeys.filter_min.tr,
                    ),
                  ),
                  SizedBox(width: 16),
                  Flexible(
                    flex: 1,
                    child: MyTextField(
                      enabled: false,
                      controller: _maxController,
                      textInputAction: TextInputAction.done,
                      labelText: LocaleKeys.filter_max.tr,
                    ),
                  )
                ],
              ),
              SizedBox(
                width: double.infinity,
                height: 64,
                child: Obx(
                  () => RangeSlider(
                    values: RangeValues(
                        _controller.rangeMin(), _controller.rangeMax()),
                    onChanged: (value) {
                      _controller.rangeMin(value.start);
                      _minController.text = value.start.toInt().toString();
                      _controller.rangeMax(value.end);
                      _maxController.text = value.end.toInt().toString();
                    },
                    min: Constants.minRangeSlider,
                    max: Constants.maxRangeSlider,
                    activeColor: AppColors.colorAccent,
                    inactiveColor: AppColors.colorAccentLight,
                    divisions: Constants.rangeDivision,
                  ),
                ),
              ),
              Row(mainAxisSize: MainAxisSize.min, children: [
                Obx(
                  () => Checkbox(
                    value: _controller.onlyAvailableProducts(),
                    onChanged: (value) => changeCheckBoxValue,
                  ),
                ),
                GestureDetector(
                    child: TextContent(
                        LocaleKeys.filter_only_available_products.tr),
                    onTap: changeCheckBoxValue)
              ])
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: MyButton(
              Text(LocaleKeys.filter_filter.tr),
              filter,
              paddingHorizontal: 0,
              paddingVertical: 0,
            ),
          )
        ],
      ),
    );
  }

  void changeCheckBoxValue() {
    _controller.onlyAvailableProducts(!_controller.onlyAvailableProducts());
  }

  void filter() {}

  HomePageController get _controller => Get.find<HomePageController>();
}
