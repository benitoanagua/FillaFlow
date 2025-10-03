import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:filla_flow/filla_flow.dart';

@widgetbook.UseCase(name: 'Default', type: FFCard)
Widget buildFFCardUseCase(BuildContext context) {
  return Center(
    child: SizedBox(
      width: 300,
      child: FFCard(
        icon: const Icon(Icons.shopping_cart, size: 32),
        quantity: context.knobs.string(label: 'Quantity', initialValue: '24'),
        title: context.knobs.string(label: 'Title', initialValue: 'Orders'),
        subtitle: context.knobs.string(
          label: 'Subtitle',
          initialValue: 'New this week',
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
        isPastel: context.knobs.boolean(
          label: 'Pastel Colors',
          initialValue: true,
        ),
        onTap: () {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Card tapped!')));
        },
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Grid Layout', type: FFCard)
Widget buildFFCardGridUseCase(BuildContext context) {
  final cards = [
    const FFCard(
      icon: Icon(Icons.shopping_cart, size: 32),
      quantity: '24',
      title: 'Orders',
      subtitle: 'New this week',
      cardColor: Colors.blue,
      isPastel: true,
    ),
    const FFCard(
      icon: Icon(Icons.people, size: 32),
      quantity: '1,234',
      title: 'Customers',
      subtitle: 'Active users',
      cardColor: Colors.green,
      isPastel: true,
    ),
    const FFCard(
      icon: Icon(Icons.attach_money, size: 32),
      quantity: '\$12.5k',
      title: 'Revenue',
      subtitle: 'This month',
      cardColor: Colors.purple,
      isPastel: true,
    ),
    const FFCard(
      icon: Icon(Icons.trending_up, size: 32),
      quantity: '+15%',
      title: 'Growth',
      subtitle: 'vs last month',
      cardColor: Colors.orange,
      isPastel: true,
    ),
  ];

  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 300,
        childAspectRatio: 1.2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: cards.length,
      itemBuilder: (context, index) => cards[index],
    ),
  );
}

@widgetbook.UseCase(name: 'Vibrant Colors', type: FFCard)
Widget buildFFCardVibrantUseCase(BuildContext context) {
  return Center(
    child: SizedBox(
      width: 300,
      child: FFCard(
        icon: const Icon(Icons.notifications, size: 32),
        quantity: '8',
        title: 'Notifications',
        subtitle: 'Unread messages',
        cardColor: Colors.red,
        isPastel: false,
        onTap: () {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Vibrant card tapped!')));
        },
      ),
    ),
  );
}
