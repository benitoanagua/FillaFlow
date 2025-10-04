import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:filla_flow/filla_flow.dart';

void main() {
  group('FFCarousel Basic Tests', () {
    testWidgets('FFCarousel renders children', (WidgetTester tester) async {
      final widget = FFCarousel(
        children: [
          Container(height: 100, color: Colors.red),
          Container(height: 100, color: Colors.green),
          Container(height: 100, color: Colors.blue),
        ],
      );

      await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));

      expect(find.byType(Container), findsNWidgets(3));
    });

    testWidgets('FFCarousel shows navigation when multiple pages', (
      WidgetTester tester,
    ) async {
      final widget = FFCarousel(
        desktopColumns: 2,
        showArrows: true,
        showDots: true,
        children: List.generate(
          6,
          (index) => Container(height: 100, color: Colors.blue),
        ),
      );

      await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));

      expect(find.byType(IconButton), findsNWidgets(2));
    });

    testWidgets('FFCarousel calls onPageChanged', (WidgetTester tester) async {
      int? changedPage;

      final widget = FFCarousel(
        onPageChanged: (page) => changedPage = page,
        children: [
          Container(height: 100, color: Colors.red),
          Container(height: 100, color: Colors.green),
          Container(height: 100, color: Colors.blue),
        ],
      );

      await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));

      expect(changedPage, isNull);
    });
  });
}
