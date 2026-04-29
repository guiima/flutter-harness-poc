import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:claude_learning/main.dart';

void main() {
  testWidgets('App renders without crashing', (WidgetTester tester) async {
    // MyApp boots and immediately starts fetching — verify it mounts correctly.
    await tester.pumpWidget(const MyApp());
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
