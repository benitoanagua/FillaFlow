import 'package:flutter/material.dart';
import '../types/ff_types.dart';

class FFSharedUtils {
  static TextStyle getHeadingStyle(
    BuildContext context,
    int heading, {
    Color? color,
  }) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final textColor = color ?? colorScheme.onSurface;

    return switch (heading) {
      1 =>
        textTheme.headlineSmall?.copyWith(color: textColor) ??
            TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
      2 =>
        textTheme.titleLarge?.copyWith(color: textColor) ??
            TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
      3 =>
        textTheme.titleMedium?.copyWith(color: textColor) ??
            TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
      4 =>
        textTheme.titleSmall?.copyWith(color: textColor) ??
            TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
      5 =>
        textTheme.bodyLarge?.copyWith(color: textColor) ??
            TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
      6 =>
        textTheme.bodyMedium?.copyWith(color: textColor) ??
            TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
      _ =>
        textTheme.titleSmall?.copyWith(color: textColor) ??
            TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
    };
  }

  static double getAspectRatio(dynamic ratioEnum) {
    return switch (ratioEnum) {
      MediaAspectRatio.square => 1.0,
      MediaAspectRatio.video => 16 / 9,
      MediaAspectRatio.monitor => 4 / 3,
      _ => 4 / 3,
    };
  }

  static Widget buildNetworkImage(
    String? imageUrl, {
    required double aspectRatio,
    BoxFit fit = BoxFit.cover,
  }) {
    if (imageUrl == null) {
      return AspectRatio(
        aspectRatio: aspectRatio,
        child: Container(
          decoration: BoxDecoration(color: Colors.grey.shade200),
          child: Icon(Icons.photo, color: Colors.grey.shade400, size: 40),
        ),
      );
    }

    return AspectRatio(
      aspectRatio: aspectRatio,
      child: Image.network(
        imageUrl,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
            ),
            child: Icon(
              Icons.error_outline,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              size: 32,
            ),
          );
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
            ),
            child: Center(
              child: CircularProgressIndicator.adaptive(
                strokeWidth: 2,
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                    : null,
              ),
            ),
          );
        },
      ),
    );
  }

  static Widget? buildMetaSection({
    required BuildContext context,
    String? publishedAt,
    String? readingTime,
    String? tagName,
    Color? accentColor,
    bool isOverlay = false,
  }) {
    final hasPublishedAt = publishedAt != null && publishedAt.isNotEmpty;
    final hasReadingTime = readingTime != null && readingTime.isNotEmpty;
    final hasTag = tagName != null && tagName.isNotEmpty;

    if (!hasPublishedAt && !hasReadingTime && !hasTag) return null;

    final colorScheme = Theme.of(context).colorScheme;
    final children = <Widget>[];

    // Textos de fecha y tiempo de lectura
    if (hasPublishedAt || hasReadingTime) {
      final metaTexts = <Widget>[];

      if (hasPublishedAt) {
        metaTexts.add(
          Text(
            publishedAt,
            style: TextStyle(
              fontSize: isOverlay ? 14 : 10,
              color: isOverlay
                  ? const Color.fromRGBO(255, 255, 255, 0.8)
                  : colorScheme.onSurfaceVariant,
              fontWeight: isOverlay ? FontWeight.w500 : FontWeight.normal,
            ),
          ),
        );
      }

      if (hasPublishedAt && hasReadingTime) {
        metaTexts.add(
          Text(
            ' • ',
            style: TextStyle(
              fontSize: isOverlay ? 14 : 10,
              color: isOverlay
                  ? const Color.fromRGBO(255, 255, 255, 0.6)
                  : colorScheme.onSurfaceVariant,
            ),
          ),
        );
      }

      if (hasReadingTime) {
        metaTexts.add(
          Text(
            readingTime,
            style: TextStyle(
              fontSize: isOverlay ? 14 : 10,
              color: isOverlay
                  ? const Color.fromRGBO(255, 255, 255, 0.8)
                  : colorScheme.onSurfaceVariant,
              fontWeight: isOverlay ? FontWeight.w500 : FontWeight.normal,
            ),
          ),
        );
      }

      if (isOverlay) {
        children.add(Wrap(spacing: 8, runSpacing: 8, children: metaTexts));
      } else {
        children.add(Row(mainAxisSize: MainAxisSize.min, children: metaTexts));
      }
    }

    // Tag
    if (hasTag) {
      if (children.isNotEmpty && !isOverlay) {
        children.add(const SizedBox(width: 8));
      }

      final tagColor = accentColor ?? colorScheme.primary;
      final tagWidget = Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: isOverlay
              ? colorScheme.surfaceContainerHighest.withValues(alpha: 0.9)
              : tagColor.withValues(alpha: 0.1),
          border: Border.all(color: isOverlay ? colorScheme.primary : tagColor),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          isOverlay ? tagName.toUpperCase() : tagName,
          style: TextStyle(
            fontSize: isOverlay ? 12 : 10,
            fontWeight: FontWeight.w500,
            letterSpacing: isOverlay ? 1 : 0,
            color: isOverlay ? colorScheme.onSurfaceVariant : tagColor,
          ),
          maxLines: 1,
        ),
      );

      if (isOverlay) {
        children.add(tagWidget);
      } else {
        children.add(Flexible(child: tagWidget));
      }
    }

    return isOverlay
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          )
        : Row(mainAxisSize: MainAxisSize.min, children: children);
  }
}
