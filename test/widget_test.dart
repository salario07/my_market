// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_market/generated/locales.g.dart';

import 'package:my_market/widget/ui/show_product.dart';

void main() {
  testWidgets('Number picker and add to cart button',
      (WidgetTester tester) async {
    await tester.pumpWidget(MediaQuery(
        data: MediaQueryData(), child: MaterialApp(home: ShowProduct(2))));
    await tester.pump(Duration(milliseconds: 2500));

    Finder addToCartButton =
        find.text(LocaleKeys.show_product_add_to_cart).first;
    Finder numberPickerIncrementButton = find.byIcon(Icons.keyboard_arrow_up);

    expect(addToCartButton, findsOneWidget);
    expect(numberPickerIncrementButton, findsNothing);

    await tester.tap(addToCartButton);
    await tester.pump();

    expect(addToCartButton, findsOneWidget);
    expect(numberPickerIncrementButton, findsNothing);
  });
}
