import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_market/controller/home_page_controller.dart';
import 'package:my_market/generated/locales.g.dart';
import 'package:my_market/helper/app_colors.dart';
import 'package:my_market/helper/constants.dart';
import 'package:my_market/helper/helper.dart';
import 'package:my_market/model/filter.dart';
import 'package:my_market/widget/component/my_button.dart';
import 'package:my_market/widget/component/my_text_field.dart';
import 'package:my_market/widget/component/text_content.dart';

class BottomSheetFilter extends StatelessWidget {
  final TextEditingController _minController = TextEditingController();
  final TextEditingController _maxController = TextEditingController();

  BottomSheetFilter() {
    _minController.text =
        Helper.buildPriceText(_controller.rangeMin().toInt().toString());
    _maxController.text =
        Helper.buildPriceText(_controller.rangeMax().toInt().toString());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Stack(
        children: [buildContent(), buildFilterButton()],
      ),
    );
  }

  Column buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextContent(LocaleKeys.filter_price.tr),
        SizedBox(height: 16),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            buildMinTextField(),
            SizedBox(width: 16),
            buildMaxTextField()
          ],
        ),
        buildRangeSlider(),
        buildCheckBox()
      ],
    );
  }

  Flexible buildMinTextField() {
    return Flexible(
      flex: 1,
      child: MyTextField(
        enabled: false,
        controller: _minController,
        labelText: LocaleKeys.filter_min.tr,
      ),
    );
  }

  Flexible buildMaxTextField() {
    return Flexible(
      flex: 1,
      child: MyTextField(
        enabled: false,
        controller: _maxController,
        textInputAction: TextInputAction.done,
        labelText: LocaleKeys.filter_max.tr,
      ),
    );
  }

  SizedBox buildRangeSlider() {
    return SizedBox(
      width: double.infinity,
      height: 64,
      child: Obx(
        () => RangeSlider(
          values: RangeValues(_controller.rangeMin(), _controller.rangeMax()),
          onChanged: (value) => onChangeSliderValues(value),
          min: Constants.minRangeSlider,
          max: Constants.maxRangeSlider,
          activeColor: AppColors.colorAccent,
          inactiveColor: AppColors.colorAccentLight,
          divisions: Constants.rangeDivision,
        ),
      ),
    );
  }

  void onChangeSliderValues(RangeValues value) {
    _controller.rangeMin(value.start);
    _minController.text = Helper.buildPriceText(value.start.toInt().toString());
    _controller.rangeMax(value.end);
    _maxController.text = Helper.buildPriceText(value.end.toInt().toString());
  }

  Align buildFilterButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: MyButton(
        Text(LocaleKeys.filter_filter.tr),
        filter,
        paddingHorizontal: 0,
        paddingVertical: 0,
      ),
    );
  }

  Row buildCheckBox() {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Obx(
        () => Checkbox(
          value: _controller.onlyAvailableProducts(),
          onChanged: (value) => changeCheckBoxValue(value),
        ),
      ),
      GestureDetector(
          child: TextContent(LocaleKeys.filter_only_available_products.tr),
          onTap: () =>
              changeCheckBoxValue(!_controller.onlyAvailableProducts()))
    ]);
  }

  void changeCheckBoxValue(bool value) {
    _controller.onlyAvailableProducts(value);
  }

  void filter() {
    Get.back(
        result: Filter(
            _controller.rangeMin().toInt(),
            _controller.rangeMax().toInt(),
            _controller.onlyAvailableProducts()));
  }

  HomePageController get _controller => Get.find<HomePageController>();
}
