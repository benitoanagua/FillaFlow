import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:filla_flow/filla_flow.dart';
import 'package:faker_dart/faker_dart.dart';

@widgetbook.UseCase(name: 'Grid Layout', type: FFGrid)
Widget buildFFCardGridUseCase(BuildContext context) {
  final faker = Faker.instance;

  final cards = List<FFCard>.generate(12, (index) {
    final themes = [
      _buildTechCard(faker, index),
      _buildDesignCard(faker, index),
      _buildBusinessCard(faker, index),
      _buildHealthCard(faker, index),
    ];

    return themes[index % themes.length];
  });

  return Scaffold(
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: FFGrid(
        desktopColumns: context.knobs.int.slider(
          label: 'Desktop Columns',
          initialValue: 3,
          min: 2,
          max: 6,
        ),
        tabletColumns: context.knobs.int.slider(
          label: 'Tablet Columns',
          initialValue: 2,
          min: 1,
          max: 4,
        ),
        mobileColumns: context.knobs.int.slider(
          label: 'Mobile Columns',
          initialValue: 1,
          min: 1,
          max: 2,
        ),
        spacing: context.knobs.double.slider(
          label: 'Spacing',
          initialValue: 16.0,
          min: 8.0,
          max: 32.0,
        ),
        runSpacing: context.knobs.double.slider(
          label: 'Run Spacing',
          initialValue: 16.0,
          min: 8.0,
          max: 32.0,
        ),
        type: _getGridTypeFromKnobs(context),
        children: cards,
      ),
    ),
  );
}

FFGridType _getGridTypeFromKnobs(BuildContext context) {
  final gridTypeIndex = context.knobs.int.slider(
    label: 'Grid Type',
    initialValue: 2,
    min: 0,
    max: 2,
  );

  return FFGridType.values[gridTypeIndex];
}

String _getFormattedDate(DateTime date) {
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

DateTime _getPastDate(Faker faker, {int rangeInYears = 2}) {
  return faker.date.past(DateTime.now(), rangeInYears: rangeInYears);
}

FFCard _buildTechCard(Faker faker, int index) {
  final techThemes = [
    (color: Colors.blue, tag: 'Flutter'),
    (color: Colors.green, tag: 'Dart'),
    (color: Colors.purple, tag: 'AI'),
    (color: Colors.orange, tag: 'Cloud'),
  ];

  final theme = techThemes[index % techThemes.length];

  return FFCard(
    title: '${faker.commerce.productName()} Development Guide',
    excerpt: faker.lorem.sentence(),
    featureImage: 'https://picsum.photos/seed/tech$index/400/300',
    authorName: faker.name.fullName(),
    authorProfileImage: 'https://i.pravatar.cc/150?img=${index % 70}',
    publishedAt: _getFormattedDate(_getPastDate(faker, rangeInYears: 1)),
    readingTime: '${5 + (index % 10)} min read',
    tagName: theme.tag,
    heading: 3 + (index % 3),
    mediaAlign: _randomMediaAlign(index),
    aspectRatio: _randomAspectRatio(index),
    autoLayout: true,
    cardColor: theme.color,
    onTap: () {},
  );
}

FFCard _buildDesignCard(Faker faker, int index) {
  final designThemes = [
    (color: Colors.pink, tag: 'UI/UX'),
    (color: Colors.teal, tag: 'Design'),
    (color: Colors.indigo, tag: 'Figma'),
    (color: Colors.amber, tag: 'Prototype'),
  ];

  final theme = designThemes[index % designThemes.length];

  return FFCard(
    title: '${faker.commerce.productName()} Design Patterns',
    excerpt: faker.lorem.sentence(),
    featureImage: 'https://picsum.photos/seed/design$index/400/300',
    authorName: faker.name.fullName(),
    publishedAt: _getFormattedDate(_getPastDate(faker, rangeInYears: 2)),
    readingTime: '${7 + (index % 8)} min read',
    tagName: theme.tag,
    heading: 3 + (index % 3),
    mediaAlign: _randomMediaAlign(index),
    aspectRatio: _randomAspectRatio(index),
    autoLayout: true,
    cardColor: theme.color,
    onTap: () {},
  );
}

FFCard _buildBusinessCard(Faker faker, int index) {
  final businessThemes = [
    (color: Colors.green, tag: 'Startup'),
    (color: Colors.blueGrey, tag: 'Strategy'),
    (color: Colors.brown, tag: 'Finance'),
    (color: Colors.cyan, tag: 'Marketing'),
  ];

  final theme = businessThemes[index % businessThemes.length];

  return FFCard(
    title: faker.company.catchPhrase(),
    excerpt: faker.lorem.sentence(),
    featureImage: 'https://picsum.photos/seed/business$index/400/300',
    authorName: faker.name.fullName(),
    authorProfileImage: 'https://i.pravatar.cc/150?img=${(index + 10) % 70}',
    publishedAt: _getFormattedDate(_getPastDate(faker, rangeInYears: 1)),
    readingTime: '${8 + (index % 12)} min read',
    tagName: theme.tag,
    heading: 3 + (index % 3),
    mediaAlign: _randomMediaAlign(index),
    aspectRatio: _randomAspectRatio(index),
    autoLayout: true,
    cardColor: theme.color,
    onTap: () {},
  );
}

FFCard _buildHealthCard(Faker faker, int index) {
  final healthThemes = [
    (color: Colors.red, tag: 'Wellness'),
    (color: Colors.green, tag: 'Fitness'),
    (color: Colors.purple, tag: 'Nutrition'),
    (color: Colors.orange, tag: 'Mental Health'),
  ];

  final theme = healthThemes[index % healthThemes.length];

  final prefixes = ['Complete', 'Advanced', 'Essential', 'Professional'];
  final topics = ['Wellness', 'Fitness', 'Nutrition', 'Health'];
  final suffixes = ['Guide', 'Program', 'Handbook', 'Manual'];

  final title =
      '${prefixes[index % prefixes.length]} ${topics[index % topics.length]} ${suffixes[index % suffixes.length]}';

  return FFCard(
    title: title,
    excerpt: faker.lorem.sentence(),
    featureImage: 'https://picsum.photos/seed/health$index/400/300',
    authorName: faker.name.fullName(),
    publishedAt: _getFormattedDate(_getPastDate(faker, rangeInYears: 1)),
    readingTime: '${4 + (index % 8)} min read',
    tagName: theme.tag,
    heading: 3 + (index % 3),
    mediaAlign: _randomMediaAlign(index),
    aspectRatio: _randomAspectRatio(index),
    autoLayout: true,
    cardColor: theme.color,
    onTap: () {},
  );
}

CardMediaAlign _randomMediaAlign(int index) {
  final aligns = CardMediaAlign.values;
  return aligns[index % aligns.length];
}

MediaAspectRatio _randomAspectRatio(int index) {
  final ratios = MediaAspectRatio.values;
  return ratios[index % ratios.length];
}

@widgetbook.UseCase(name: 'Grid with Varied Content', type: FFGrid)
Widget buildFFCardVariedGridUseCase(BuildContext context) {
  final faker = Faker.instance;

  final cards = List<FFCard>.generate(8, (index) {
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.purple,
      Colors.orange,
      Colors.teal,
      Colors.pink,
      Colors.indigo,
    ];
    final tags = [
      'Tech',
      'Design',
      'Business',
      'Health',
      'Education',
      'Science',
      'Art',
    ];

    final randomColor = colors[index % colors.length];
    final randomTag = tags[index % tags.length];

    return FFCard(
      title: faker.lorem.sentence(),
      excerpt: faker.lorem.sentence(),
      featureImage: 'https://picsum.photos/seed/varied$index/400/300',
      authorName: faker.name.fullName(),
      authorProfileImage: 'https://i.pravatar.cc/150?img=${(index + 20) % 70}',
      publishedAt: _getFormattedDate(_getPastDate(faker, rangeInYears: 2)),
      readingTime: '${3 + (index % 12)} min read',
      tagName: randomTag,
      heading: 3 + (index % 3),
      mediaAlign: CardMediaAlign.top,
      aspectRatio: MediaAspectRatio.monitor,
      autoLayout: true,
      cardColor: randomColor,
      onTap: () {},
    );
  });

  return Scaffold(
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: FFGrid(
        desktopColumns: 4,
        tabletColumns: 2,
        mobileColumns: 1,
        spacing: 16.0,
        runSpacing: 16.0,
        type: FFGridType.auto,
        children: cards,
      ),
    ),
  );
}
