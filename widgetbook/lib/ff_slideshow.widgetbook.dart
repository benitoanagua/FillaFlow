import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:filla_flow/filla_flow.dart';
import 'package:faker_dart/faker_dart.dart';

@widgetbook.UseCase(name: 'Default', type: FFSlideshow)
Widget buildFFSlideshowUseCase(BuildContext context) {
  final faker = Faker.instance;

  final slides = List<Widget>.generate(
    context.knobs.int.slider(
      label: 'Number of Slides',
      initialValue: 4,
      min: 2,
      max: 8,
    ),
    (index) => _buildSlideContent(faker, index),
  );

  return FFSlideshow(
    interval: Duration(
      seconds: context.knobs.int.slider(
        label: 'Auto-play Interval (seconds)',
        initialValue: 5,
        min: 2,
        max: 10,
      ),
    ),
    autoPlay: context.knobs.boolean(label: 'Auto Play', initialValue: true),
    showNavigation: context.knobs.boolean(
      label: 'Show Navigation',
      initialValue: true,
    ),
    showIndicators: context.knobs.boolean(
      label: 'Show Indicators',
      initialValue: true,
    ),
    showCounter: context.knobs.boolean(
      label: 'Show Counter',
      initialValue: true,
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
      options: [
        NavigationPosition.top,
        NavigationPosition.bottom,
        NavigationPosition.centered,
      ],
    ),
    onPageChanged: (page) {
      // Handle page change if needed
    },
    onNavigation: (navigation) {
      // Handle navigation if needed
    },
    children: slides,
  );
}

Widget _buildSlideContent(Faker faker, int index) {
  final colors = [
    Colors.blue.shade100,
    Colors.green.shade100,
    Colors.orange.shade100,
    Colors.purple.shade100,
    Colors.red.shade100,
    Colors.teal.shade100,
    Colors.indigo.shade100,
    Colors.pink.shade100,
  ];

  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          colors[index % colors.length],
          colors[(index + 1) % colors.length],
        ],
      ),
    ),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.photo_library, size: 64, color: Colors.white),
          const SizedBox(height: 16),
          Text(
            'Slide ${index + 1}',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            faker.lorem.sentence(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withValues(alpha: 0.9),
            ),
          ),
        ],
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'With Images', type: FFSlideshow)
Widget buildFFSlideshowWithImagesUseCase(BuildContext context) {
  final faker = Faker.instance;

  final slides = List<Widget>.generate(
    context.knobs.int.slider(
      label: 'Number of Slides',
      initialValue: 5,
      min: 3,
      max: 8,
    ),
    (index) => Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            'https://picsum.photos/800/400?random=${faker.datatype.number(min: 1, max: 1000) + index}',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Colors.black.withValues(alpha: 0.7), Colors.transparent],
          ),
        ),
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Featured Content ${index + 1}',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              faker.lorem.sentence(),
              style: TextStyle(
                fontSize: 16,
                color: Colors.white.withValues(alpha: 0.9),
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    ),
  );

  return FFSlideshow(
    interval: const Duration(seconds: 4),
    autoPlay: context.knobs.boolean(label: 'Auto Play', initialValue: true),
    showNavigation: true,
    showIndicators: true,
    showCounter: true,
    navigationPosition: NavigationPosition.bottom,
    children: slides,
  );
}

@widgetbook.UseCase(name: 'Minimal Configuration', type: FFSlideshow)
Widget buildFFSlideshowMinimalUseCase(BuildContext context) {
  final slides = List<Widget>.generate(3, (index) {
    final color = [
      Colors.blueAccent,
      Colors.greenAccent,
      Colors.orangeAccent,
    ][index];

    return Container(
      color: color,
      child: Center(
        child: Text(
          'Slide ${index + 1}',
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  });

  return FFSlideshow(
    interval: const Duration(seconds: 3),
    autoPlay: false,
    showNavigation: true,
    showIndicators: false,
    showCounter: false,
    navigationPosition: NavigationPosition.centered,
    children: slides,
  );
}

@widgetbook.UseCase(name: 'Custom Content', type: FFSlideshow)
Widget buildFFSlideshowCustomContentUseCase(BuildContext context) {
  final slides = [
    _buildCustomSlide(
      Icons.business,
      'Business Insights',
      'Explore the latest trends in business and technology.',
      Colors.blue.shade700,
    ),
    _buildCustomSlide(
      Icons.architecture,
      'Technology Trends',
      'Discover emerging technologies shaping our future.',
      Colors.green.shade700,
    ),
    _buildCustomSlide(
      Icons.brush,
      'Creative Design',
      'Innovative design approaches for modern applications.',
      Colors.purple.shade700,
    ),
    _buildCustomSlide(
      Icons.health_and_safety,
      'Health & Wellness',
      'Strategies for maintaining work-life balance and wellness.',
      Colors.teal.shade700,
    ),
  ];

  return FFSlideshow(
    interval: Duration(
      seconds: context.knobs.int.slider(
        label: 'Slide Duration',
        initialValue: 6,
        min: 3,
        max: 10,
      ),
    ),
    autoPlay: context.knobs.boolean(label: 'Auto Play', initialValue: true),
    showNavigation: true,
    showIndicators: true,
    showCounter: true,
    navigationPosition: context.knobs.object.dropdown<NavigationPosition>(
      label: 'Navigation Style',
      options: [NavigationPosition.bottom, NavigationPosition.centered],
    ),
    children: slides,
  );
}

Widget _buildCustomSlide(
  IconData icon,
  String title,
  String description,
  Color color,
) {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [color, color.withValues(alpha: 0.8)],
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 80, color: Colors.white),
          const SizedBox(height: 24),
          Text(
            title,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withValues(alpha: 0.9),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Single Slide', type: FFSlideshow)
Widget buildFFSlideshowSingleUseCase(BuildContext context) {
  return FFSlideshow(
    interval: const Duration(seconds: 5),
    autoPlay: false,
    showNavigation: false,
    showIndicators: false,
    showCounter: false,
    children: [
      Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.deepPurple, Colors.purpleAccent],
          ),
        ),
        child: const Center(
          child: Text(
            'Single Slide Content',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ],
  );
}
