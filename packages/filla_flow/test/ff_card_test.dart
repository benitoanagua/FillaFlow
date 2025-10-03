import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:filla_flow/src/widgets/ff_card.dart';

void main() {
  group('FFCard Tests', () {
    testWidgets('FFCard renders correctly with default values', (
      WidgetTester tester,
    ) async {
      const widget = FFCard(
        icon: Icon(Icons.star),
        quantity: '42',
        title: 'Test Title',
        subtitle: 'Test Subtitle',
        cardColor: Colors.blue,
      );

      await tester.pumpWidget(const MaterialApp(home: Scaffold(body: widget)));

      expect(find.byType(Card), findsOneWidget);
      expect(find.byType(InkWell), findsOneWidget);
      expect(find.byType(Icon), findsOneWidget);
      expect(find.text('42'), findsOneWidget);
      expect(find.text('Test Title'), findsOneWidget);
      expect(find.text('Test Subtitle'), findsOneWidget);
    });

    testWidgets('FFCard uses pastel colors when isPastel is true', (
      WidgetTester tester,
    ) async {
      const widget = FFCard(
        icon: Icon(Icons.star),
        quantity: '42',
        title: 'Title',
        subtitle: 'Subtitle',
        cardColor: Colors.blue,
        isPastel: true,
      );

      await tester.pumpWidget(const MaterialApp(home: Scaffold(body: widget)));

      expect(
        (tester.firstWidget(find.byType(Card)) as Card).color,
        equals(Colors.blue.shade50),
      );
    });

    testWidgets('FFCard uses vibrant colors when isPastel is false', (
      WidgetTester tester,
    ) async {
      const widget = FFCard(
        icon: Icon(Icons.star),
        quantity: '42',
        title: 'Title',
        subtitle: 'Subtitle',
        cardColor: Colors.blue,
        isPastel: false,
      );

      await tester.pumpWidget(const MaterialApp(home: Scaffold(body: widget)));

      expect(
        (tester.firstWidget(find.byType(Card)) as Card).color,
        equals(Colors.blue.shade500),
      );
    });

    testWidgets('FFCard responds to tap when onTap is provided', (
      WidgetTester tester,
    ) async {
      bool wasTapped = false;

      final widget = FFCard(
        icon: const Icon(Icons.star),
        quantity: '42',
        title: 'Title',
        subtitle: 'Subtitle',
        cardColor: Colors.blue,
        onTap: () => wasTapped = true,
      );

      await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));

      await tester.tap(find.byType(InkWell));
      expect(wasTapped, isTrue);
    });
  });
}
