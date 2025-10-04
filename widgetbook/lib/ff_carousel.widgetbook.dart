import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:filla_flow/filla_flow.dart';
import 'package:faker_dart/faker_dart.dart';

@widgetbook.UseCase(name: 'Default', type: FFCarousel)
Widget buildFFCarouselUseCase(BuildContext context) {
  final faker = Faker.instance;

  final items = List<FFCard>.generate(
    context.knobs.int.slider(
      label: 'Number of Items',
      initialValue: 8,
      min: 3,
      max: 12,
    ),
    (index) => _buildFFCard(faker, index),
  );

  return FFCarousel(
    desktopColumns: context.knobs.int.slider(
      label: 'Desktop Columns',
      initialValue: 3,
      min: 1,
      max: 5,
    ),
    mobileColumns: context.knobs.int.slider(
      label: 'Mobile Columns',
      initialValue: 1,
      min: 1,
      max: 2,
    ),
    gap: context.knobs.object.dropdown<CarouselGap>(
      label: 'Gap Size',
      labelBuilder: (value) {
        switch (value) {
          case CarouselGap.none:
            return 'None';
          case CarouselGap.small:
            return 'Small';
          case CarouselGap.medium:
            return 'Medium';
          case CarouselGap.large:
            return 'Large';
          case CarouselGap.xlarge:
            return 'X-Large';
        }
      },
      options: [CarouselGap.small, CarouselGap.medium, CarouselGap.large],
    ),
    interval: Duration(
      seconds: context.knobs.int.slider(
        label: 'Auto-play Interval',
        initialValue: 4,
        min: 2,
        max: 8,
      ),
    ),
    autoPlay: context.knobs.boolean(label: 'Auto Play', initialValue: true),
    showArrows: context.knobs.boolean(label: 'Show Arrows', initialValue: true),
    showDots: context.knobs.boolean(label: 'Show Dots', initialValue: true),
    showCounter: context.knobs.boolean(
      label: 'Show Counter',
      initialValue: false,
    ),
    navigationPosition: context.knobs.object.dropdown<NavigationPosition>(
      label: 'Navigation Position',
      labelBuilder: (value) {
        switch (value) {
          case NavigationPosition.top:
            return 'Top';
          case NavigationPosition.bottom:
            return 'Bottom';
          case NavigationPosition.centered:
            return 'Centered';
          case NavigationPosition.hidden:
            return 'Hidden';
        }
      },
      options: [NavigationPosition.bottom, NavigationPosition.top],
    ),
    onPageChanged: (page) {
      // Handle page change
    },
    onNavigation: (navigation) {
      // Handle navigation
    },
    children: items,
  );
}

FFCard _buildFFCard(Faker faker, int index) {
  final colors = [
    Colors.blue,
    Colors.green,
    Colors.purple,
    Colors.orange,
    Colors.teal,
  ];
  final tags = ['Technology', 'Design', 'Business', 'Health', 'Education'];

  return FFCard(
    title: '${faker.commerce.productName()} Development',
    excerpt: faker.lorem.sentence(),
    featureImage: 'https://picsum.photos/seed/card$index/400/300',
    authorName: faker.name.fullName(),
    authorProfileImage: 'https://i.pravatar.cc/150?img=${index % 70}',
    publishedAt: _formatDate(_generatePastDate(faker)),
    readingTime: '${3 + (index % 8)} min read',
    tagName: tags[index % tags.length],
    heading: 4,
    mediaAlign: CardMediaAlign.top,
    aspectRatio: MediaAspectRatio.monitor,
    autoLayout: true,
    cardColor: colors[index % colors.length],
    onTap: () {},
  );
}

@widgetbook.UseCase(name: 'Image Cards', type: FFCarousel)
Widget buildFFCarouselImageCardsUseCase(BuildContext context) {
  final faker = Faker.instance;

  final items = List<Widget>.generate(
    10, // More items to see the carousel effect
    (index) => _buildImageCard(faker, index),
  );

  return FFCarousel(
    desktopColumns: 3,
    mobileColumns: 1,
    gap: CarouselGap.medium,
    interval: const Duration(seconds: 3), // Faster interval for better demo
    autoPlay: true,
    showArrows: true,
    showDots: true,
    showCounter: true,
    navigationPosition: NavigationPosition.bottom,
    children: items,
  );
}

Widget _buildImageCard(Faker faker, int index) {
  return Card(
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          child: Image.network(
            'https://picsum.photos/seed/image$index/400/200',
            height: 120,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Image Card ${index + 1}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                faker.lorem.sentence(),
                style: const TextStyle(fontSize: 12),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(name: 'Single Item View', type: FFCarousel)
Widget buildFFCarouselSingleItemUseCase(BuildContext context) {
  final faker = Faker.instance;

  final items = List<FFCard>.generate(
    6,
    (index) => _buildFeaturedCard(faker, index),
  );

  return FFCarousel(
    desktopColumns: 1, // Show one item at a time
    mobileColumns: 1,
    gap: CarouselGap.large,
    interval: const Duration(seconds: 4),
    autoPlay: true,
    showArrows: true,
    showDots: true,
    showCounter: true,
    navigationPosition: NavigationPosition.bottom,
    children: items,
  );
}

FFCard _buildFeaturedCard(Faker faker, int index) {
  return FFCard(
    title: 'Featured Content ${index + 1}',
    excerpt: faker.lorem.paragraph(sentenceCount: 1),
    featureImage: 'https://picsum.photos/seed/featured$index/600/400',
    authorName: faker.name.fullName(),
    publishedAt: _formatDate(_generatePastDate(faker)),
    readingTime: '${5 + (index % 10)} min read',
    tagName: 'Featured',
    heading: 3,
    mediaAlign: CardMediaAlign.left,
    mediaWidth: CardMediaWidth.isOneThird,
    aspectRatio: MediaAspectRatio.monitor,
    autoLayout: true,
    cardColor: Colors.blue,
    onTap: () {},
  );
}

@widgetbook.UseCase(name: 'Multiple Items View', type: FFCarousel)
Widget buildFFCarouselMultipleItemsUseCase(BuildContext context) {
  final faker = Faker.instance;

  final items = List<Widget>.generate(
    12, // More items to see the sliding effect
    (index) => _buildSimpleCard(faker, index),
  );

  return FFCarousel(
    desktopColumns: context.knobs.int.slider(
      label: 'Items Visible',
      initialValue: 4,
      min: 2,
      max: 6,
    ),
    mobileColumns: 1,
    gap: CarouselGap.small,
    interval: const Duration(seconds: 3),
    autoPlay: true,
    showArrows: true,
    showDots: true,
    showCounter: false,
    navigationPosition: NavigationPosition.bottom,
    children: items,
  );
}

Widget _buildSimpleCard(Faker faker, int index) {
  final colors = [
    Colors.blue.shade100,
    Colors.green.shade100,
    Colors.orange.shade100,
    Colors.purple.shade100,
    Colors.red.shade100,
    Colors.teal.shade100,
  ];

  return Card(
    elevation: 1,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    color: colors[index % colors.length],
    child: Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.star, size: 32, color: Colors.amber),
          const SizedBox(height: 8),
          Text(
            'Item ${index + 1}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            faker.lorem.sentence(),
            style: const TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    ),
  );
}

// Helper functions
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

DateTime _generatePastDate(Faker faker) {
  final now = DateTime.now();
  final daysAgo = faker.datatype.number(min: 1, max: 365);
  return now.subtract(Duration(days: daysAgo));
}
