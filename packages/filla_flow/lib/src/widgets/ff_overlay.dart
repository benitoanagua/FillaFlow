import 'package:flutter/material.dart';

class FFOverlay extends StatelessWidget {
  final String title;
  final String? url;
  final String? featureImage;
  final String? tagName;
  final String? authorName;
  final String? publishedAt;
  final String? readingTime;
  final OverlayAspectRatio aspectRatio;
  final int heading;
  final OverlayAlign align;
  final OverlayPosition position;
  final OverlayBox box;
  final OverlayFill fill;
  final VoidCallback? onTap;

  const FFOverlay({
    super.key,
    required this.title,
    this.url,
    this.featureImage,
    this.tagName,
    this.authorName,
    this.publishedAt,
    this.readingTime,
    this.aspectRatio = OverlayAspectRatio.monitor,
    this.heading = 3,
    this.align = OverlayAlign.center,
    this.position = OverlayPosition.center,
    this.box = OverlayBox.background,
    this.fill = OverlayFill.gradient,
    this.onTap,
  });

  TextStyle _getHeadingStyle(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    switch (heading) {
      case 1:
        return textTheme.headlineSmall?.copyWith(color: Colors.white) ??
            const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            );
      case 2:
        return textTheme.titleLarge?.copyWith(color: Colors.white) ??
            const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            );
      case 3:
        return textTheme.titleMedium?.copyWith(color: Colors.white) ??
            const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            );
      case 4:
        return textTheme.titleSmall?.copyWith(color: Colors.white) ??
            const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            );
      case 5:
        return textTheme.bodyLarge?.copyWith(color: Colors.white) ??
            const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            );
      case 6:
        return textTheme.bodyMedium?.copyWith(color: Colors.white) ??
            const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            );
      default:
        return textTheme.titleMedium?.copyWith(color: Colors.white) ??
            const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            );
    }
  }

  double _getAspectRatio() {
    switch (aspectRatio) {
      case OverlayAspectRatio.square:
        return 1.0;
      case OverlayAspectRatio.video:
        return 16 / 9;
      case OverlayAspectRatio.monitor:
        return 4 / 3;
    }
  }

  Alignment _getAlignment() {
    switch (position) {
      case OverlayPosition.top:
        switch (align) {
          case OverlayAlign.start:
            return Alignment.topLeft;
          case OverlayAlign.center:
            return Alignment.topCenter;
          case OverlayAlign.end:
            return Alignment.topRight;
        }
      case OverlayPosition.center:
        switch (align) {
          case OverlayAlign.start:
            return Alignment.centerLeft;
          case OverlayAlign.center:
            return Alignment.center;
          case OverlayAlign.end:
            return Alignment.centerRight;
        }
      case OverlayPosition.bottom:
        switch (align) {
          case OverlayAlign.start:
            return Alignment.bottomLeft;
          case OverlayAlign.center:
            return Alignment.bottomCenter;
          case OverlayAlign.end:
            return Alignment.bottomRight;
        }
    }
  }

  Widget? _buildOverlayEffect() {
    if (fill == OverlayFill.none) return null;

    return Container(
      decoration: BoxDecoration(gradient: _getOverlayGradient()),
    );
  }

  Gradient? _getOverlayGradient() {
    switch (fill) {
      case OverlayFill.full:
        return LinearGradient(
          colors: [const Color(0x99000000), const Color(0x99000000)],
        );
      case OverlayFill.gradient:
        switch (position) {
          case OverlayPosition.top:
            return LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [const Color(0x80000000), Colors.transparent],
              stops: const [0.0, 0.7],
            );
          case OverlayPosition.center:
            return LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                const Color(0x99000000),
                Colors.transparent,
              ],
              stops: const [0.0, 0.5, 1.0],
            );
          case OverlayPosition.bottom:
            return LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, const Color(0x80000000)],
              stops: const [0.3, 1.0],
            );
        }
      case OverlayFill.none:
        return null;
    }
  }

  Widget _buildContentContainer(BuildContext context, Widget child) {
    final boxDecoration = _getBoxDecoration(context);

    return Container(
      constraints: const BoxConstraints(maxWidth: 672),
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.all(16),
      decoration: boxDecoration,
      child: child,
    );
  }

  BoxDecoration? _getBoxDecoration(BuildContext context) {
    switch (box) {
      case OverlayBox.background:
        return BoxDecoration(
          color: const Color.fromRGBO(255, 255, 255, 0.6),
          border: Border(
            left: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 4,
            ),
          ),
        );
      case OverlayBox.border:
        return BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.outline,
            width: 2,
          ),
        );
      case OverlayBox.transparent:
        return null;
    }
  }

  Widget? _buildTag(BuildContext context) {
    if (tagName == null || tagName!.isEmpty) return null;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        border: Border.all(color: Theme.of(context).colorScheme.primary),
      ),
      child: Text(
        tagName!.toUpperCase(),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          letterSpacing: 1,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }

  Widget? _buildMetaSection(BuildContext context) {
    final hasAuthor = authorName != null && authorName!.isNotEmpty;
    final hasPublishedAt = publishedAt != null && publishedAt!.isNotEmpty;
    final hasReadingTime = readingTime != null && readingTime!.isNotEmpty;

    if (!hasAuthor && !hasPublishedAt && !hasReadingTime) {
      return null;
    }

    final children = <Widget>[];

    if (hasAuthor) {
      children.add(
        Text(
          authorName!,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: const Color.fromRGBO(255, 255, 255, 0.8),
          ),
        ),
      );
    }

    if (hasPublishedAt) {
      if (hasAuthor) {
        children.add(
          Text(
            ' | ',
            style: TextStyle(
              fontSize: 14,
              color: const Color.fromRGBO(255, 255, 255, 0.6),
            ),
          ),
        );
      }
      children.add(
        Text(
          publishedAt!,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: const Color.fromRGBO(255, 255, 255, 0.8),
          ),
        ),
      );
    }

    if (hasReadingTime) {
      if (hasAuthor || hasPublishedAt) {
        children.add(
          Text(
            ' | ',
            style: TextStyle(
              fontSize: 14,
              color: const Color.fromRGBO(255, 255, 255, 0.6),
            ),
          ),
        );
      }
      children.add(
        Text(
          readingTime!,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: const Color.fromRGBO(255, 255, 255, 0.8),
          ),
        ),
      );
    }

    return Wrap(spacing: 8, runSpacing: 8, children: children);
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: _getAspectRatio(),
      child: Stack(
        children: [
          if (featureImage != null && featureImage!.isNotEmpty)
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(featureImage!),
                  fit: BoxFit.cover,
                ),
              ),
            ),

          if (_buildOverlayEffect() != null)
            Positioned.fill(child: _buildOverlayEffect()!),

          Positioned.fill(
            child: Align(
              alignment: _getAlignment(),
              child: _buildContentContainer(
                context,
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: _getCrossAxisAlignment(),
                  children: [
                    if (_buildTag(context) != null) ...[
                      _buildTag(context)!,
                      const SizedBox(height: 12),
                    ],
                    GestureDetector(
                      onTap: url != null ? onTap : null,
                      child: Text(
                        title,
                        style: _getHeadingStyle(context),
                        textAlign: _getTextAlign(),
                      ),
                    ),
                    if (_buildMetaSection(context) != null) ...[
                      const SizedBox(height: 12),
                      _buildMetaSection(context)!,
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  CrossAxisAlignment _getCrossAxisAlignment() {
    switch (align) {
      case OverlayAlign.start:
        return CrossAxisAlignment.start;
      case OverlayAlign.center:
        return CrossAxisAlignment.center;
      case OverlayAlign.end:
        return CrossAxisAlignment.end;
    }
  }

  TextAlign _getTextAlign() {
    switch (align) {
      case OverlayAlign.start:
        return TextAlign.left;
      case OverlayAlign.center:
        return TextAlign.center;
      case OverlayAlign.end:
        return TextAlign.right;
    }
  }
}

enum OverlayAspectRatio { monitor, square, video }

enum OverlayAlign { start, center, end }

enum OverlayPosition { top, center, bottom }

enum OverlayBox { border, background, transparent }

enum OverlayFill { full, gradient, none }
