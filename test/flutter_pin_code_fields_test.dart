import 'package:flutter/material.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> pumpMaterialWidget(WidgetTester tester, Widget child) {
  return tester.pumpWidget(MaterialApp(
    home: Material(
      child: child,
    ),
  ));
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("Create pin code fields", (WidgetTester tester) async {
    await pumpMaterialWidget(
      tester,
      PinCodeFields(
        onComplete: (text) => print(text),
      ),
    );
  });

  testWidgets("Get pin on complete", (WidgetTester tester) async {
    TextEditingController controller = TextEditingController();
    await pumpMaterialWidget(
      tester,
      PinCodeFields(
        controller: controller,
        onComplete: (text) => print(text),
      ),
    );
    await tester.enterText(find.byType(TextFormField), '1234');
    expect("1234", controller.text);
  });

  testWidgets("Autofocus is true", (WidgetTester tester) async {
    TextEditingController controller = TextEditingController(text: "123");
    FocusNode focusNode = FocusNode();

    await pumpMaterialWidget(
      tester,
      PinCodeFields(
        controller: controller,
        focusNode: focusNode,
        autofocus: true,
        onComplete: (text) => print(text),
      ),
    );

    expect(focusNode.hasFocus, true);
  });

  testWidgets("Autofocus is true and pin code field is disabled",
      (WidgetTester tester) async {
    TextEditingController controller = TextEditingController(text: "123");
    FocusNode focusNode = FocusNode();

    await pumpMaterialWidget(
      tester,
      PinCodeFields(
        controller: controller,
        focusNode: focusNode,
        enabled: false,
        autofocus: true,
        onComplete: (text) => print(text),
      ),
    );

    expect(focusNode.hasFocus, false);
  });
}
