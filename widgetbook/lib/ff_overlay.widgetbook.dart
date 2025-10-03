import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:filla_flow/filla_flow.dart';
import 'package:faker_dart/faker_dart.dart';

@widgetbook.UseCase(name: 'Default', type: FFOverlay)
Widget buildFFOverlayUseCase(BuildContext context) {
  final faker = Faker.instance;

  final align = context.knobs.object.dropdown<OverlayAlign>(
    label: 'Horizontal Alignment',
    labelBuilder: (value) {
      switch (value) {
        case OverlayAlign.start:
          return 'Start';
        case OverlayAlign.center:
          return 'Center';
        case OverlayAlign.end:
          return 'End';
      }
    },
    options: [OverlayAlign.start, OverlayAlign.center, OverlayAlign.end],
  );

  final position = context.knobs.object.dropdown<OverlayPosition>(
    label: 'Vertical Position',
    labelBuilder: (value) {
      switch (value) {
        case OverlayPosition.top:
          return 'Top';
        case OverlayPosition.center:
          return 'Center';
        case OverlayPosition.bottom:
          return 'Bottom';
      }
    },
    options: [
      OverlayPosition.top,
      OverlayPosition.center,
      OverlayPosition.bottom,
    ],
  );

  final aspectRatio = context.knobs.object.dropdown<OverlayAspectRatio>(
    label: 'Aspect Ratio',
    labelBuilder: (value) {
      switch (value) {
        case OverlayAspectRatio.monitor:
          return 'Monitor (4:3)';
        case OverlayAspectRatio.square:
          return 'Square (1:1)';
        case OverlayAspectRatio.video:
          return 'Video (16:9)';
      }
    },
    options: [
      OverlayAspectRatio.monitor,
      OverlayAspectRatio.square,
      OverlayAspectRatio.video,
    ],
  );

  final box = context.knobs.object.dropdown<OverlayBox>(
    label: 'Content Box Style',
    labelBuilder: (value) {
      switch (value) {
        case OverlayBox.border:
          return 'Border';
        case OverlayBox.background:
          return 'Background';
        case OverlayBox.transparent:
          return 'Transparent';
      }
    },
    options: [OverlayBox.border, OverlayBox.background, OverlayBox.transparent],
  );

  final fill = context.knobs.object.dropdown<OverlayFill>(
    label: 'Overlay Fill',
    labelBuilder: (value) {
      switch (value) {
        case OverlayFill.full:
          return 'Full';
        case OverlayFill.gradient:
          return 'Gradient';
        case OverlayFill.none:
          return 'None';
      }
    },
    options: [OverlayFill.full, OverlayFill.gradient, OverlayFill.none],
  );

  return SizedBox(
    height: 400,
    child: FFOverlay(
      title: context.knobs.string(
        label: 'Title',
        initialValue: faker.lorem.sentence(),
      ),
      featureImage: context.knobs.string(
        label: 'Image URL',
        initialValue:
            'https://picsum.photos/800/600?random=${faker.datatype.number(min: 1, max: 1000)}',
      ),
      tagName: context.knobs.string(
        label: 'Tag Name',
        initialValue: faker.hacker.noun(),
      ),
      authorName: context.knobs.string(
        label: 'Author Name',
        initialValue: faker.name.fullName(),
      ),
      publishedAt: context.knobs.string(
        label: 'Published Date',
        initialValue: _formatDate(_generatePastDate(faker)),
      ),
      readingTime: context.knobs.string(
        label: 'Reading Time',
        initialValue: '${faker.datatype.number(min: 5, max: 25)} min read',
      ),
      heading: context.knobs.int.slider(
        label: 'Heading Level',
        initialValue: 3,
        min: 1,
        max: 6,
      ),
      align: align,
      position: position,
      aspectRatio: aspectRatio,
      box: box,
      fill: fill,
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${faker.lorem.word()} overlay tapped!')),
        );
      },
    ),
  );
}

@widgetbook.UseCase(name: 'Content Variations', type: FFOverlay)
Widget buildFFOverlayContentVariationsUseCase(BuildContext context) {
  final faker = Faker.instance;

  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: ListView(
      children: [
        _buildContentExample(
          context,
          'Full Content',
          faker,
          tagName: faker.hacker.noun(),
          authorName: faker.name.fullName(),
          publishedAt: _formatDate(_generatePastDate(faker)),
          readingTime: '${faker.datatype.number(min: 5, max: 25)} min read',
        ),
        const SizedBox(height: 20),
        _buildContentExample(
          context,
          'Title Only',
          faker,
          tagName: null,
          authorName: null,
          publishedAt: null,
          readingTime: null,
        ),
        const SizedBox(height: 20),
        _buildContentExample(
          context,
          'With Tag Only',
          faker,
          tagName: faker.hacker.noun(),
          authorName: null,
          publishedAt: null,
          readingTime: null,
        ),
        const SizedBox(height: 20),
        _buildContentExample(
          context,
          'Minimal Style',
          faker,
          tagName: null,
          authorName: null,
          publishedAt: null,
          readingTime: null,
          fill: OverlayFill.none,
          box: OverlayBox.transparent,
        ),
      ],
    ),
  );
}

Widget _buildContentExample(
  BuildContext context,
  String title,
  Faker faker, {
  String? tagName,
  String? authorName,
  String? publishedAt,
  String? readingTime,
  OverlayFill fill = OverlayFill.gradient,
  OverlayBox box = OverlayBox.background,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: Theme.of(context).textTheme.titleLarge),
      const SizedBox(height: 8),
      SizedBox(
        height: 300,
        child: FFOverlay(
          title: '${faker.lorem.sentence()} ($title)',
          featureImage:
              'https://picsum.photos/600/400?random=${faker.datatype.number(min: 1, max: 1000)}',
          tagName: tagName,
          authorName: authorName,
          publishedAt: publishedAt,
          readingTime: readingTime,
          heading: 3,
          align: OverlayAlign.center,
          position: OverlayPosition.center,
          aspectRatio: OverlayAspectRatio.monitor,
          box: box,
          fill: fill,
          onTap: () {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('$title overlay tapped!')));
          },
        ),
      ),
    ],
  );
}

@widgetbook.UseCase(name: 'Style Variations', type: FFOverlay)
Widget buildFFOverlayStyleVariationsUseCase(BuildContext context) {
  final faker = Faker.instance;

  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: ListView(
      children: [
        _buildStyleExample(
          context,
          'Full Overlay + Background Box',
          faker,
          fill: OverlayFill.full,
          box: OverlayBox.background,
        ),
        const SizedBox(height: 20),
        _buildStyleExample(
          context,
          'Gradient Overlay + Border Box',
          faker,
          fill: OverlayFill.gradient,
          box: OverlayBox.border,
        ),
        const SizedBox(height: 20),
        _buildStyleExample(
          context,
          'No Overlay + Transparent Box',
          faker,
          fill: OverlayFill.none,
          box: OverlayBox.transparent,
        ),
        const SizedBox(height: 20),
        _buildStyleExample(
          context,
          'Gradient Overlay + Background Box',
          faker,
          fill: OverlayFill.gradient,
          box: OverlayBox.background,
        ),
      ],
    ),
  );
}

Widget _buildStyleExample(
  BuildContext context,
  String title,
  Faker faker, {
  required OverlayFill fill,
  required OverlayBox box,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: Theme.of(context).textTheme.titleLarge),
      const SizedBox(height: 8),
      SizedBox(
        height: 300,
        child: FFOverlay(
          title: '${faker.lorem.sentence()} ($title)',
          featureImage:
              'https://picsum.photos/600/400?random=${faker.datatype.number(min: 1, max: 1000)}',
          tagName: faker.hacker.noun(),
          authorName: faker.name.fullName(),
          publishedAt: _formatDate(_generatePastDate(faker)),
          readingTime: '${faker.datatype.number(min: 5, max: 25)} min read',
          heading: 3,
          align: OverlayAlign.center,
          position: OverlayPosition.center,
          aspectRatio: OverlayAspectRatio.monitor,
          box: box,
          fill: fill,
          onTap: () {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('$title style tapped!')));
          },
        ),
      ),
    ],
  );
}

@widgetbook.UseCase(name: 'Positioning Variations', type: FFOverlay)
Widget buildFFOverlayPositioningVariationsUseCase(BuildContext context) {
  final faker = Faker.instance;

  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: ListView(
      children: [
        _buildPositioningExample(
          context,
          'Top Start',
          faker,
          align: OverlayAlign.start,
          position: OverlayPosition.top,
        ),
        const SizedBox(height: 20),
        _buildPositioningExample(
          context,
          'Center',
          faker,
          align: OverlayAlign.center,
          position: OverlayPosition.center,
        ),
        const SizedBox(height: 20),
        _buildPositioningExample(
          context,
          'Bottom End',
          faker,
          align: OverlayAlign.end,
          position: OverlayPosition.bottom,
        ),
        const SizedBox(height: 20),
        _buildPositioningExample(
          context,
          'Bottom Start',
          faker,
          align: OverlayAlign.start,
          position: OverlayPosition.bottom,
        ),
      ],
    ),
  );
}

Widget _buildPositioningExample(
  BuildContext context,
  String title,
  Faker faker, {
  required OverlayAlign align,
  required OverlayPosition position,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: Theme.of(context).textTheme.titleLarge),
      const SizedBox(height: 8),
      SizedBox(
        height: 300,
        child: FFOverlay(
          title: '${faker.lorem.sentence()} ($title)',
          featureImage:
              'https://picsum.photos/700/500?random=${faker.datatype.number(min: 1, max: 1000)}',
          tagName: faker.hacker.noun(),
          authorName: faker.name.fullName(),
          publishedAt: _formatDate(_generatePastDate(faker)),
          readingTime: '${faker.datatype.number(min: 5, max: 25)} min read',
          heading: 3,
          align: align,
          position: position,
          aspectRatio: OverlayAspectRatio.monitor,
          box: OverlayBox.background,
          fill: OverlayFill.gradient,
          onTap: () {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('$title position tapped!')));
          },
        ),
      ),
    ],
  );
}

@widgetbook.UseCase(name: 'Aspect Ratio Variations', type: FFOverlay)
Widget buildFFOverlayAspectRatioVariationsUseCase(BuildContext context) {
  final faker = Faker.instance;

  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: ListView(
      children: [
        _buildAspectRatioExample(
          context,
          'Monitor (4:3)',
          faker,
          OverlayAspectRatio.monitor,
          450,
        ),
        const SizedBox(height: 20),
        _buildAspectRatioExample(
          context,
          'Square (1:1)',
          faker,
          OverlayAspectRatio.square,
          400,
        ),
        const SizedBox(height: 20),
        _buildAspectRatioExample(
          context,
          'Video (16:9)',
          faker,
          OverlayAspectRatio.video,
          400,
        ),
      ],
    ),
  );
}

Widget _buildAspectRatioExample(
  BuildContext context,
  String title,
  Faker faker,
  OverlayAspectRatio ratio,
  double height,
) {
  final imageHeights = {
    OverlayAspectRatio.square: 400,
    OverlayAspectRatio.video: 225,
    OverlayAspectRatio.monitor: 300,
  };

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: Theme.of(context).textTheme.titleLarge),
      const SizedBox(height: 8),
      SizedBox(
        height: height,
        child: FFOverlay(
          title: '${faker.lorem.sentence()} ($title)',
          featureImage:
              'https://picsum.photos/600/${imageHeights[ratio]}?random=${faker.datatype.number(min: 1, max: 1000)}',
          tagName: faker.hacker.noun(),
          authorName: faker.name.fullName(),
          publishedAt: _formatDate(_generatePastDate(faker)),
          readingTime: '${faker.datatype.number(min: 5, max: 25)} min read',
          heading: 3,
          align: OverlayAlign.center,
          position: OverlayPosition.center,
          aspectRatio: ratio,
          box: OverlayBox.background,
          fill: OverlayFill.gradient,
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('$title aspect ratio tapped!')),
            );
          },
        ),
      ),
    ],
  );
}

@widgetbook.UseCase(name: 'Heading Levels', type: FFOverlay)
Widget buildFFOverlayHeadingLevelsUseCase(BuildContext context) {
  final faker = Faker.instance;

  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: ListView(
      children: List.generate(6, (index) {
        final headingLevel = index + 1;
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Heading Level $headingLevel',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 200,
                child: FFOverlay(
                  title:
                      '${_generateTitleWords(faker, 3)} (Heading $headingLevel)',
                  featureImage:
                      'https://picsum.photos/400/300?random=${faker.datatype.number(min: 1, max: 1000)}',
                  tagName: faker.hacker.noun(),
                  authorName: faker.name.fullName(),
                  publishedAt: _formatDate(_generatePastDate(faker)),
                  readingTime:
                      '${faker.datatype.number(min: 3, max: 15)} min read',
                  heading: headingLevel,
                  align: OverlayAlign.center,
                  position: OverlayPosition.center,
                  aspectRatio: OverlayAspectRatio.monitor,
                  box: OverlayBox.background,
                  fill: OverlayFill.gradient,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Heading $headingLevel overlay tapped!'),
                      ),
                    );
                  },
                ),
              ),
            ],
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
