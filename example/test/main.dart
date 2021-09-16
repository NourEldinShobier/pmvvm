import 'package:flutter/material.dart';
import 'package:example/pages/index.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Counter app smoke test', (WidgetTester tester) async {
    // ASSEMBLE
    await tester.pumpWidget(MaterialApp(home: CounterPage()));

    // ACTION
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // ASSERT
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
