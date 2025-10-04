import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:filla_flow/filla_flow.dart';

void main() {
  group('FFSlideshow Basic Tests', () {
    testWidgets('FFSlideshow renders children', (WidgetTester tester) async {
      final widget = FFSlideshow(
        children: [
          Container(height: 200, color: Colors.red),
          Container(height: 200, color: Colors.green),
          Container(height: 200, color: Colors.blue),
        ],
      );

      await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));

      expect(find.byType(Container), findsNWidgets(3));
    });

    testWidgets('FFSlideshow shows navigation when multiple slides', (
      WidgetTester tester,
    ) async {
      final widget = FFSlideshow(
        showNavigation: true,
        showIndicators: true,
        children: [
          Container(height: 200, color: Colors.red),
          Container(height: 200, color: Colors.green),
        ],
      );

      await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));

      expect(find.byType(IconButton), findsNWidgets(2));
    });

    testWidgets('FFSlideshow shows counter when enabled', (
      WidgetTester tester,
    ) async {
      final widget = FFSlideshow(
        showCounter: true,
        children: [
          Container(height: 200, color: Colors.red),
          Container(height: 200, color: Colors.green),
        ],
      );

      await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));

      expect(find.text('1/2'), findsOneWidget);
    });
  });
}
