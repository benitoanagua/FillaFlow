import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:filla_flow/filla_flow.dart';
import 'package:filla_flow/src/types/ff_types.dart';

void main() {
  group('FFGrid Tests', () {
    testWidgets('FFGrid renders with wrap layout', (WidgetTester tester) async {
      final widgets = [
        FFCard(title: 'Card 1', mediaAlign: CardMediaAlign.top),
        FFCard(title: 'Card 2', mediaAlign: CardMediaAlign.top),
        FFCard(title: 'Card 3', mediaAlign: CardMediaAlign.top),
      ];

      final grid = FFGrid(
        type: FFGridType.wrap,
        desktopColumns: 3,
        tabletColumns: 2,
        mobileColumns: 1,
        children: widgets,
      );

      await tester.pumpWidget(MaterialApp(home: Scaffold(body: grid)));

      expect(find.byType(FFCard), findsNWidgets(3));
      expect(find.byType(Wrap), findsOneWidget);
    });

    testWidgets('FFGrid renders with fixed layout', (
      WidgetTester tester,
    ) async {
      final widgets = [
        FFCard(title: 'Card 1', mediaAlign: CardMediaAlign.top),
        FFCard(title: 'Card 2', mediaAlign: CardMediaAlign.top),
        FFCard(title: 'Card 3', mediaAlign: CardMediaAlign.top),
      ];

      final grid = FFGrid(
        type: FFGridType.fixed,
        desktopColumns: 2,
        tabletColumns: 2,
        mobileColumns: 1,
        children: widgets,
      );

      await tester.pumpWidget(MaterialApp(home: Scaffold(body: grid)));

      expect(find.byType(FFCard), findsNWidgets(3));
      expect(find.byType(GridView), findsOneWidget);
    });

    testWidgets('FFGrid renders with auto layout', (WidgetTester tester) async {
      final widgets = [
        FFCard(title: 'Card 1', mediaAlign: CardMediaAlign.top),
        FFCard(title: 'Card 2', mediaAlign: CardMediaAlign.top),
      ];

      final grid = FFGrid(
        type: FFGridType.auto,
        desktopColumns: 2,
        tabletColumns: 2,
        mobileColumns: 1,
        children: widgets,
      );

      await tester.pumpWidget(MaterialApp(home: Scaffold(body: grid)));

      expect(find.byType(FFCard), findsNWidgets(2));
    });

    testWidgets('FFGrid handles empty children', (WidgetTester tester) async {
      final grid = FFGrid(type: FFGridType.wrap, children: []);

      await tester.pumpWidget(MaterialApp(home: Scaffold(body: grid)));

      expect(find.byType(FFCard), findsNothing);
    });

    testWidgets('FFGrid respects spacing', (WidgetTester tester) async {
      final widgets = [
        FFCard(title: 'Card 1', mediaAlign: CardMediaAlign.top),
        FFCard(title: 'Card 2', mediaAlign: CardMediaAlign.top),
      ];

      final grid = FFGrid(
        type: FFGridType.wrap,
        spacing: 20.0,
        runSpacing: 15.0,
        children: widgets,
      );

      await tester.pumpWidget(MaterialApp(home: Scaffold(body: grid)));

      expect(find.byType(FFCard), findsNWidgets(2));
      expect(find.byType(Wrap), findsOneWidget);
    });
  });
}
