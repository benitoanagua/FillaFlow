import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:filla_flow/filla_flow.dart';
import 'package:faker_dart/faker_dart.dart';

@widgetbook.UseCase(name: 'Default', type: FFCard)
Widget buildFFCardUseCase(BuildContext context) {
  final faker = Faker.instance;

  final mediaAlign = context.knobs.object.dropdown<CardMediaAlign>(
    label: 'Media Alignment',
    labelBuilder: (value) {
      switch (value) {
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
    options: [
      CardMediaAlign.left,
      CardMediaAlign.right,
      CardMediaAlign.top,
      CardMediaAlign.bottom,
    ],
  );

  final aspectRatio = context.knobs.object.dropdown<CardMediaRatio>(
    label: 'Aspect Ratio',
    labelBuilder: (value) {
      switch (value) {
        case CardMediaRatio.monitor:
          return 'Monitor (4:3)';
        case CardMediaRatio.square:
          return 'Square (1:1)';
        case CardMediaRatio.video:
          return 'Video (16:9)';
      }
    },
    options: [
      CardMediaRatio.monitor,
      CardMediaRatio.square,
      CardMediaRatio.video,
    ],
  );

  final cardColor = context.knobs.object.dropdown<Color>(
    label: 'Card Color',
    labelBuilder: (value) {
      if (value == Colors.blue) return 'Blue';
      if (value == Colors.green) return 'Green';
      if (value == Colors.red) return 'Red';
      if (value == Colors.purple) return 'Purple';
      if (value == Colors.orange) return 'Orange';
      if (value == Colors.teal) return 'Teal';
      if (value == Colors.indigo) return 'Indigo';
      return 'Unknown';
    },
    options: [
      Colors.blue,
      Colors.green,
      Colors.red,
      Colors.purple,
      Colors.orange,
      Colors.teal,
      Colors.indigo,
    ],
  );

  final mediaWidth = context.knobs.object.dropdown<CardMediaWidth>(
    label: 'Media Width',
    labelBuilder: (value) {
      switch (value) {
        case CardMediaWidth.isHalf:
          return 'Half (1/2)';
        case CardMediaWidth.isTwoFifths:
          return 'Two Fifths (2/5)';
        case CardMediaWidth.isOneThird:
          return 'One Third (1/3)';
        case CardMediaWidth.isOneQuarter:
          return 'One Quarter (1/4)';
        case CardMediaWidth.isOneFifth:
          return 'One Fifth (1/5)';
      }
    },
    options: [
      CardMediaWidth.isHalf,
      CardMediaWidth.isTwoFifths,
      CardMediaWidth.isOneThird,
      CardMediaWidth.isOneQuarter,
      CardMediaWidth.isOneFifth,
    ],
  );

  return Center(
    child: SizedBox(
      width: 400,
      child: FFCard(
        title: context.knobs.string(
          label: 'Title',
          initialValue: faker.lorem.sentence(),
        ),
        excerpt: context.knobs.string(
          label: 'Excerpt',
          initialValue: faker.lorem.paragraph(sentenceCount: 2),
        ),
        featureImage: context.knobs.string(
          label: 'Image URL',
          initialValue:
              'https://picsum.photos/400/300?random=${faker.datatype.number(min: 1, max: 1000)}',
        ),
        authorName: context.knobs.string(
          label: 'Author',
          initialValue: faker.name.fullName(),
        ),
        authorProfileImage: context.knobs.string(
          label: 'Author Image',
          initialValue:
              'https://i.pravatar.cc/150?img=${faker.datatype.number(min: 1, max: 70)}',
        ),
        publishedAt: context.knobs.string(
          label: 'Published Date',
          initialValue: _formatDate(_generatePastDate(faker)),
        ),
        readingTime: context.knobs.string(
          label: 'Reading Time',
          initialValue: '${faker.datatype.number(min: 3, max: 15)} min read',
        ),
        tagName: context.knobs.string(
          label: 'Tag',
          initialValue: faker.hacker.noun(),
        ),
        heading: context.knobs.int.slider(
          label: 'Heading Level',
          initialValue: 4,
          min: 1,
          max: 6,
        ),
        mediaAlign: mediaAlign,
        mediaWidth: mediaWidth,
        aspectRatio: aspectRatio,
        autoLayout: context.knobs.boolean(
          label: 'Auto Layout',
          initialValue: true,
        ),
        cardColor: cardColor,
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${faker.lorem.word()} card tapped!')),
          );
        },
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Media Alignment Variations', type: FFCard)
Widget buildFFCardAlignmentUseCase(BuildContext context) {
  final faker = Faker.instance;

  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: ListView(
      children: [
        _buildAlignmentExample(
          context,
          'Left Aligned',
          CardMediaAlign.left,
          CardMediaWidth.isOneThird,
          faker,
        ),
        const SizedBox(height: 20),
        _buildAlignmentExample(
          context,
          'Right Aligned',
          CardMediaAlign.right,
          CardMediaWidth.isOneThird,
          faker,
        ),
        const SizedBox(height: 20),
        _buildAlignmentExample(
          context,
          'Top Aligned',
          CardMediaAlign.top,
          CardMediaWidth.isHalf,
          faker,
        ),
        const SizedBox(height: 20),
        _buildAlignmentExample(
          context,
          'Bottom Aligned',
          CardMediaAlign.bottom,
          CardMediaWidth.isHalf,
          faker,
        ),
      ],
    ),
  );
}

Widget _buildAlignmentExample(
  BuildContext context,
  String title,
  CardMediaAlign align,
  CardMediaWidth width,
  Faker faker,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: Theme.of(context).textTheme.titleLarge),
      const SizedBox(height: 8),
      FFCard(
        title: faker.lorem.sentence(),
        excerpt: faker.lorem.paragraph(sentenceCount: 2),
        featureImage:
            'https://picsum.photos/400/300?random=${faker.datatype.number(min: 1, max: 1000)}',
        authorName: faker.name.fullName(),
        authorProfileImage:
            'https://i.pravatar.cc/150?img=${faker.datatype.number(min: 1, max: 70)}',
        publishedAt: _formatDate(_generatePastDate(faker)),
        readingTime: '${faker.datatype.number(min: 3, max: 15)} min read',
        tagName: faker.hacker.noun(),
        heading: 4,
        mediaAlign: align,
        mediaWidth: width,
        aspectRatio: CardMediaRatio.monitor,
        autoLayout: true,
        cardColor: Colors.teal,
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${faker.lorem.word()} $title card tapped!'),
            ),
          );
        },
      ),
    ],
  );
}

@widgetbook.UseCase(name: 'Aspect Ratio Variations', type: FFCard)
Widget buildFFCardAspectRatioUseCase(BuildContext context) {
  final faker = Faker.instance;

  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: ListView(
      children: [
        _buildAspectRatioExample(
          context,
          'Monitor (4:3)',
          CardMediaRatio.monitor,
          faker,
        ),
        const SizedBox(height: 20),
        _buildAspectRatioExample(
          context,
          'Square (1:1)',
          CardMediaRatio.square,
          faker,
        ),
        const SizedBox(height: 20),
        _buildAspectRatioExample(
          context,
          'Video (16:9)',
          CardMediaRatio.video,
          faker,
        ),
      ],
    ),
  );
}

Widget _buildAspectRatioExample(
  BuildContext context,
  String title,
  CardMediaRatio ratio,
  Faker faker,
) {
  final imageHeights = {
    CardMediaRatio.square: 400,
    CardMediaRatio.video: 225,
    CardMediaRatio.monitor: 300,
  };

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: Theme.of(context).textTheme.titleLarge),
      const SizedBox(height: 8),
      FFCard(
        title: faker.lorem.sentence(),
        excerpt: faker.lorem.paragraph(sentenceCount: 2),
        featureImage:
            'https://picsum.photos/400/${imageHeights[ratio]}?random=${faker.datatype.number(min: 1, max: 1000)}',
        authorName: faker.name.fullName(),
        authorProfileImage:
            'https://i.pravatar.cc/150?img=${faker.datatype.number(min: 1, max: 70)}',
        publishedAt: _formatDate(_generatePastDate(faker)),
        readingTime: '${faker.datatype.number(min: 3, max: 15)} min read',
        tagName: faker.hacker.noun(),
        heading: 4,
        mediaAlign: CardMediaAlign.top,
        aspectRatio: ratio,
        autoLayout: true,
        cardColor: Colors.purple,
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${faker.lorem.word()} $ratio card tapped!'),
            ),
          );
        },
      ),
    ],
  );
}

@widgetbook.UseCase(name: 'Minimal Content', type: FFCard)
Widget buildFFCardMinimalUseCase(BuildContext context) {
  final faker = Faker.instance;

  return Center(
    child: SizedBox(
      width: 350,
      child: FFCard(
        title: faker.lorem.sentence(),
        heading: 3,
        mediaAlign: CardMediaAlign.top,
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${faker.lorem.word()} minimal card tapped!'),
            ),
          );
        },
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Without Image', type: FFCard)
Widget buildFFCardNoImageUseCase(BuildContext context) {
  final faker = Faker.instance;

  return Center(
    child: SizedBox(
      width: 400,
      child: FFCard(
        title: faker.lorem.sentence(),
        excerpt: faker.lorem.paragraph(sentenceCount: 3),
        authorName: faker.name.fullName(),
        authorProfileImage:
            'https://i.pravatar.cc/150?img=${faker.datatype.number(min: 1, max: 70)}',
        publishedAt: _formatDate(_generatePastDate(faker)),
        readingTime: '${faker.datatype.number(min: 5, max: 20)} min read',
        tagName: faker.hacker.noun(),
        heading: 4,
        mediaAlign: CardMediaAlign.top,
        autoLayout: true,
        cardColor: Colors.blue,
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${faker.lorem.word()} text-only card tapped!'),
            ),
          );
        },
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Heading Levels', type: FFCard)
Widget buildFFCardHeadingLevelsUseCase(BuildContext context) {
  final faker = Faker.instance;

  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: ListView(
      children: List.generate(6, (index) {
        final headingLevel = index + 1;
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: FFCard(
            title: '${_generateTitleWords(faker, 3)} (Heading $headingLevel)',
            excerpt: faker.lorem.paragraph(sentenceCount: 2),
            featureImage:
                'https://picsum.photos/400/300?random=${faker.datatype.number(min: 1, max: 1000)}',
            authorName: faker.name.fullName(),
            publishedAt: _formatDate(_generatePastDate(faker)),
            readingTime: '${faker.datatype.number(min: 3, max: 15)} min read',
            tagName: faker.hacker.noun(),
            heading: headingLevel,
            mediaAlign: CardMediaAlign.top,
            autoLayout: true,
            cardColor: Colors.blue,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    '${faker.lorem.word()} heading $headingLevel card tapped!',
                  ),
                ),
              );
            },
          ),
        );
      }),
    ),
  );
}

String _formatDate(DateTime date) {
  final months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  return '${months[date.month - 1]} ${date.day}, ${date.year}';
}

String _generateTitleWords(Faker faker, int wordCount) {
  final words = <String>[];
  for (var i = 0; i < wordCount; i++) {
    words.add(faker.lorem.word());
  }
  return words.join(' ');
}

DateTime _generatePastDate(Faker faker) {
  final now = DateTime.now();
  final daysAgo = faker.datatype.number(min: 1, max: 365);
  return now.subtract(Duration(days: daysAgo));
}
