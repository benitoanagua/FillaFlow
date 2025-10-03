import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:filla_flow/filla_flow.dart';
import 'package:filla_flow/src/types/ff_types.dart';

void main() {
  group('FFCard Tests', () {
    testWidgets('FFCard renders correctly with basic content', (
      WidgetTester tester,
    ) async {
      const widget = FFCard(
        title: 'Test Title',
        excerpt: 'Test excerpt content',
        mediaAlign: CardMediaAlign.top,
      );

      await tester.pumpWidget(const MaterialApp(home: Scaffold(body: widget)));

      expect(find.byType(Card), findsOneWidget);
      expect(find.text('Test Title'), findsOneWidget);
      expect(find.text('Test excerpt content'), findsOneWidget);
    });

    testWidgets('FFCard renders with author section', (
      WidgetTester tester,
    ) async {
      const widget = FFCard(
        title: 'Test Title',
        authorName: 'John Doe',
        authorProfileImage: 'https://example.com/avatar.jpg',
        mediaAlign: CardMediaAlign.top,
      );

      await tester.pumpWidget(const MaterialApp(home: Scaffold(body: widget)));

      expect(find.text('John Doe'), findsOneWidget);
      expect(find.byType(CircleAvatar), findsOneWidget);
    });

    testWidgets('FFCard renders with meta section', (
      WidgetTester tester,
    ) async {
      const widget = FFCard(
        title: 'Test Title',
        publishedAt: 'Jan 1, 2024',
        readingTime: '5 min read',
        tagName: 'Technology',
        mediaAlign: CardMediaAlign.top,
      );

      await tester.pumpWidget(const MaterialApp(home: Scaffold(body: widget)));

      expect(find.text('Jan 1, 2024'), findsOneWidget);
      expect(find.text('5 min read'), findsOneWidget);
      expect(find.text('Technology'), findsOneWidget);
    });

    testWidgets('FFCard responds to tap', (WidgetTester tester) async {
      bool wasTapped = false;

      final widget = FFCard(
        title: 'Test Title',
        onTap: () => wasTapped = true,
        mediaAlign: CardMediaAlign.top,
      );

      await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));

      await tester.tap(find.byType(InkWell));
      expect(wasTapped, isTrue);
    });

    testWidgets('FFCard renders without image', (WidgetTester tester) async {
      const widget = FFCard(
        title: 'Test Title',
        excerpt: 'Test excerpt',
        mediaAlign: CardMediaAlign.top,
      );

      await tester.pumpWidget(const MaterialApp(home: Scaffold(body: widget)));

      expect(find.text('Test Title'), findsOneWidget);
      expect(find.text('Test excerpt'), findsOneWidget);
    });
  });
}
