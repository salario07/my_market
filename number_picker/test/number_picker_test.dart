
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:number_picker/number_picker.dart';

void main() {

  testWidgets('Check increment and decrement number on button click', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: NumberPicker()));
    await tester.pump(Duration(milliseconds: 50));

    Finder incrementButton = find.byIcon(Icons.keyboard_arrow_up);
    Finder decrementButton = find.byIcon(Icons.keyboard_arrow_down);

    expect(find.text('1'), findsOneWidget);

    await tester.tap(incrementButton);
    await tester.pump();

    expect(find.text('2'), findsOneWidget);

    await tester.tap(incrementButton);
    await tester.pump();

    expect(find.text('3'), findsOneWidget);

    await tester.tap(decrementButton);
    await tester.pump();

    expect(find.text('2'), findsOneWidget);

    await tester.tap(decrementButton);
    await tester.pump();

    expect(find.text('1'), findsOneWidget);
  });

}
