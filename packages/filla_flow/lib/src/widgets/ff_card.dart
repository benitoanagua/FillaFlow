import 'package:flutter/material.dart';

/// A customizable card widget with icon, quantity, title, and subtitle.
///
/// This card supports both pastel and vibrant color schemes through the
/// [MaterialColor] and [isPastel] parameters.
///
/// Example:
/// ```dart
/// FFCard(
///   icon: Icon(Icons.shopping_cart),
///   quantity: '24',
///   title: 'Orders',
///   subtitle: 'New this week',
///   cardColor: Colors.blue,
///   isPastel: true,
///   onTap: () => print('Card tapped'),
/// )
/// ```
class FFCard extends StatelessWidget {
  /// The icon widget to display in the card
  final Widget icon;

  /// The quantity or number to display prominently
  final String quantity;

  /// The main title text
  final String title;

  /// The subtitle or descriptive text
  final String subtitle;

  /// The base color for the card theme
  final MaterialColor cardColor;

  /// Whether to use pastel colors (lighter shades) or vibrant colors
  final bool isPastel;

  /// Optional callback when the card is tapped
  final VoidCallback? onTap;

  const FFCard({
    super.key,
    required this.icon,
    required this.quantity,
    required this.title,
    required this.subtitle,
    required this.cardColor,
    this.isPastel = false,
    this.onTap,
  });

  /// Background color based on [isPastel] setting
  Color get background => isPastel ? cardColor.shade50 : cardColor.shade500;

  /// Foreground accent color based on [isPastel] setting
  Color get foreground => isPastel ? cardColor.shade200 : cardColor.shade700;

  /// Primary text/icon color based on [isPastel] setting
  Color get primary => isPastel ? cardColor.shade800 : cardColor.shade200;

  /// Secondary text color based on [isPastel] setting
  Color get secondary => isPastel ? cardColor.shade900 : cardColor.shade50;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: background,
      elevation: 8,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipOval(
                    child: Container(
                      padding: const EdgeInsets.all(12.0),
                      color: foreground,
                      child: IconTheme(
                        data: IconThemeData(color: primary),
                        child: icon,
                      ),
                    ),
                  ),
                  Text(
                    quantity,
                    style: Theme.of(
                      context,
                    ).textTheme.headlineSmall?.copyWith(color: primary),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.headlineSmall?.copyWith(color: primary),
              ),
              Text(
                subtitle,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: secondary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
