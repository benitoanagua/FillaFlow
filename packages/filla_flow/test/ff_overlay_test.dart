import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:filla_flow/filla_flow.dart';
import 'package:filla_flow/src/types/ff_types.dart';

void main() {
  group('FFOverlay Tests', () {
    testWidgets('FFOverlay renders correctly with basic content', (
      WidgetTester tester,
    ) async {
      const widget = FFOverlay(
        title: 'Test Title',
        featureImage: 'https://picsum.photos/400/300?random=1',
      );

      await tester.pumpWidget(const MaterialApp(home: Scaffold(body: widget)));

      expect(find.byType(AspectRatio), findsOneWidget);
      expect(find.byType(Stack), findsOneWidget);
      expect(find.text('Test Title'), findsOneWidget);
    });

    testWidgets('FFOverlay renders with tag and meta information', (
      WidgetTester tester,
    ) async {
      const widget = FFOverlay(
        title: 'Test Title',
        featureImage: 'https://picsum.photos/400/300?random=1',
        tagName: 'Technology',
        authorName: 'John Doe',
        publishedAt: 'Jan 1, 2024',
        readingTime: '5 min read',
      );

      await tester.pumpWidget(const MaterialApp(home: Scaffold(body: widget)));

      expect(find.text('TECHNOLOGY'), findsOneWidget);
      expect(find.text('John Doe'), findsOneWidget);
      expect(find.text('Jan 1, 2024'), findsOneWidget);
      expect(find.text('5 min read'), findsOneWidget);
    });

    testWidgets('FFOverlay responds to tap when onTap is provided', (
      WidgetTester tester,
    ) async {
      bool wasTapped = false;

      final widget = FFOverlay(
        title: 'Test Title',
        featureImage: 'https://picsum.photos/400/300?random=1',
        onTap: () => wasTapped = true,
      );

      await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));

      await tester.tap(find.text('Test Title'));
      expect(wasTapped, isTrue);
    });

    testWidgets('FFOverlay uses different aspect ratios', (
      WidgetTester tester,
    ) async {
      const squareWidget = FFOverlay(
        title: 'Square',
        featureImage: 'https://picsum.photos/400/400?random=1',
        aspectRatio: OverlayAspectRatio.square,
      );

      const videoWidget = FFOverlay(
        title: 'Video',
        featureImage: 'https://picsum.photos/400/225?random=1',
        aspectRatio: OverlayAspectRatio.video,
      );

      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: squareWidget)),
      );
      expect(find.byType(AspectRatio), findsOneWidget);

      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: videoWidget)),
      );
      expect(find.byType(AspectRatio), findsOneWidget);
    });

    testWidgets('FFOverlay renders without image', (WidgetTester tester) async {
      const widget = FFOverlay(title: 'Test Title');

      await tester.pumpWidget(const MaterialApp(home: Scaffold(body: widget)));

      expect(find.text('Test Title'), findsOneWidget);
      expect(find.byType(Stack), findsOneWidget);
    });
  });
}
