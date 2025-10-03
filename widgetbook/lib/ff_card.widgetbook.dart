import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:filla_flow/filla_flow.dart';

@widgetbook.UseCase(name: 'Default', type: FFCard)
Widget buildFFCardUseCase(BuildContext context) {
  return Scaffold(
    body: Center(
      child: SizedBox(
        width: 400,
        child: FFCard(
          title: context.knobs.string(
            label: 'Title',
            initialValue: 'Getting Started with Flutter',
          ),
          excerpt: context.knobs.string(
            label: 'Excerpt',
            initialValue:
                'Learn how to build beautiful apps with Flutter and Dart programming language.',
          ),
          featureImage: context.knobs.string(
            label: 'Image URL',
            initialValue: 'https://picsum.photos/400/300?random=1',
          ),
          authorName: context.knobs.string(
            label: 'Author',
            initialValue: 'Jane Smith',
          ),
          publishedAt: context.knobs.string(
            label: 'Published',
            initialValue: 'Jan 15, 2024',
          ),
          readingTime: context.knobs.string(
            label: 'Reading Time',
            initialValue: '5 min read',
          ),
          tagName: context.knobs.string(label: 'Tag', initialValue: 'Flutter'),
          heading: context.knobs.int.slider(
            label: 'Heading Level',
            initialValue: 4,
            min: 1,
            max: 6,
          ),
          mediaAlign: context.knobs.list(
            label: 'Media Alignment',
            options: [
              CardMediaAlign.left,
              CardMediaAlign.right,
              CardMediaAlign.top,
              CardMediaAlign.bottom,
            ],
            labelBuilder: (align) {
              switch (align) {
                case CardMediaAlign.left:
                  return 'Left';
                case CardMediaAlign.right:
                  return 'Right';
                case CardMediaAlign.top:
                  return 'Top';
                case CardMediaAlign.bottom:
                  return 'Bottom';
              }
            },
          ),
          mediaWidth: context.knobs.list(
            label: 'Media Width',
            options: [
              CardMediaWidth.isHalf,
              CardMediaWidth.isTwoFifths,
              CardMediaWidth.isOneThird,
              CardMediaWidth.isOneQuarter,
              CardMediaWidth.isOneFifth,
            ],
            labelBuilder: (width) {
              switch (width) {
                case CardMediaWidth.isHalf:
                  return 'Half';
                case CardMediaWidth.isTwoFifths:
                  return 'Two Fifths';
                case CardMediaWidth.isOneThird:
                  return 'One Third';
                case CardMediaWidth.isOneQuarter:
                  return 'One Quarter';
                case CardMediaWidth.isOneFifth:
                  return 'One Fifth';
              }
            },
          ),
          aspectRatio: context.knobs.list(
            label: 'Aspect Ratio',
            options: [
              CardMediaRatio.monitor,
              CardMediaRatio.square,
              CardMediaRatio.video,
            ],
            labelBuilder: (ratio) {
              switch (ratio) {
                case CardMediaRatio.monitor:
                  return 'Monitor (4:3)';
                case CardMediaRatio.square:
                  return 'Square (1:1)';
                case CardMediaRatio.video:
                  return 'Video (16:9)';
              }
            },
          ),
          autoLayout: context.knobs.boolean(
            label: 'Auto Layout',
            initialValue: true,
          ),
          cardColor: context.knobs.list(
            label: 'Card Color',
            options: [
              Colors.blue,
              Colors.green,
              Colors.red,
              Colors.purple,
              Colors.orange,
              Colors.teal,
            ],
            labelBuilder: (color) {
              if (color == Colors.blue) return 'Blue';
              if (color == Colors.green) return 'Green';
              if (color == Colors.red) return 'Red';
              if (color == Colors.purple) return 'Purple';
              if (color == Colors.orange) return 'Orange';
              if (color == Colors.teal) return 'Teal';
              return 'Unknown';
            },
          ),
          onTap: () {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Card tapped!')));
          },
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Grid Layout', type: FFCard)
Widget buildFFCardGridUseCase(BuildContext context) {
  final cards = [
    FFCard(
      title: 'Flutter Basics',
      excerpt:
          'Learn Flutter fundamentals and Dart programming language from scratch.',
      featureImage: 'https://picsum.photos/seed/1/400/300',
      authorName: 'Jane Smith',
      publishedAt: 'Jan 15, 2024',
      readingTime: '5 min read',
      tagName: 'Flutter',
      heading: 4,
      mediaAlign: CardMediaAlign.top,
      aspectRatio: CardMediaRatio.monitor,
      autoLayout: true,
      cardColor: Colors.blue,
      onTap: () {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Flutter Basics tapped')));
      },
    ),
    FFCard(
      title: 'State Management Solutions',
      excerpt:
          'Explore different state management approaches in Flutter including Provider, Riverpod, and Bloc.',
      featureImage: 'https://picsum.photos/seed/2/400/300',
      authorName: 'John Doe',
      publishedAt: 'Feb 3, 2024',
      readingTime: '8 min read',
      tagName: 'Dart',
      heading: 4,
      mediaAlign: CardMediaAlign.top,
      aspectRatio: CardMediaRatio.video,
      autoLayout: true,
      cardColor: Colors.green,
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('State Management tapped')),
        );
      },
    ),
    FFCard(
      title: 'Responsive Design Patterns',
      excerpt:
          'Create adaptive layouts that work seamlessly across all device sizes and orientations.',
      featureImage: 'https://picsum.photos/seed/3/400/300',
      authorName: 'Sarah Wilson',
      publishedAt: 'Mar 10, 2024',
      readingTime: '6 min read',
      tagName: 'UI/UX',
      heading: 4,
      mediaAlign: CardMediaAlign.top,
      aspectRatio: CardMediaRatio.square,
      autoLayout: true,
      cardColor: Colors.purple,
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Responsive Design tapped')),
        );
      },
    ),
    FFCard(
      title: 'Performance Optimization',
      excerpt:
          'Advanced techniques to make your Flutter applications faster and more efficient.',
      featureImage: 'https://picsum.photos/seed/4/400/300',
      authorName: 'Mike Chen',
      publishedAt: 'Apr 22, 2024',
      readingTime: '7 min read',
      tagName: 'Performance',
      heading: 4,
      mediaAlign: CardMediaAlign.top,
      aspectRatio: CardMediaRatio.monitor,
      autoLayout: true,
      cardColor: Colors.orange,
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Performance Tips tapped')),
        );
      },
    ),
    FFCard(
      title: 'Custom Widget Development',
      excerpt:
          'Learn how to create reusable and maintainable custom widgets for your Flutter projects.',
      featureImage: 'https://picsum.photos/seed/5/400/300',
      authorName: 'Alex Johnson',
      publishedAt: 'May 15, 2024',
      readingTime: '4 min read',
      tagName: 'Widgets',
      heading: 4,
      mediaAlign: CardMediaAlign.top,
      aspectRatio: CardMediaRatio.video,
      autoLayout: true,
      cardColor: Colors.teal,
      onTap: () {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Custom Widgets tapped')));
      },
    ),
    FFCard(
      title: 'Animation Mastery',
      excerpt:
          'Create smooth and engaging animations using Flutter\'s powerful animation framework.',
      featureImage: 'https://picsum.photos/seed/6/400/300',
      authorName: 'Emma Davis',
      publishedAt: 'Jun 8, 2024',
      readingTime: '9 min read',
      tagName: 'Animations',
      heading: 4,
      mediaAlign: CardMediaAlign.top,
      aspectRatio: CardMediaRatio.square,
      autoLayout: true,
      cardColor: Colors.red,
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Animation Mastery tapped')),
        );
      },
    ),
  ];

  return Scaffold(
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: FFGrid(
        children: cards,
        desktopColumns: 3,
        tabletColumns: 2,
        mobileColumns: 1,
        spacing: 16.0,
        runSpacing: 16.0,
        type: FFGridType.auto,
      ),
    ),
  );
}
