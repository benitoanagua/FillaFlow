import 'package:flutter/material.dart';

class FFCard extends StatelessWidget {
  final String title;
  final String? url;
  final String? excerpt;
  final String? featureImage;
  final String? tagName;
  final String? tagUrl;
  final String? authorName;
  final String? authorUrl;
  final String? authorProfileImage;
  final String? readingTime;
  final String? publishedAt;
  final int heading;
  final CardMediaAlign mediaAlign;
  final CardMediaWidth mediaWidth;
  final CardMediaRatio aspectRatio;
  final bool autoLayout;
  final VoidCallback? onTap;
  final Color? cardColor;

  const FFCard({
    super.key,
    required this.title,
    this.url,
    this.excerpt,
    this.featureImage,
    this.tagName,
    this.tagUrl,
    this.authorName,
    this.authorUrl,
    this.authorProfileImage,
    this.readingTime,
    this.publishedAt,
    this.heading = 4,
    this.mediaAlign = CardMediaAlign.left,
    this.mediaWidth = CardMediaWidth.isHalf,
    this.aspectRatio = CardMediaRatio.monitor,
    this.autoLayout = false,
    this.onTap,
    this.cardColor,
  });

  TextStyle _getHeadingStyle(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return switch (heading) {
      1 =>
        textTheme.headlineSmall?.copyWith(color: colorScheme.onSurface) ??
            TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
      2 =>
        textTheme.titleLarge?.copyWith(color: colorScheme.onSurface) ??
            TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
      3 =>
        textTheme.titleMedium?.copyWith(color: colorScheme.onSurface) ??
            TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
      4 =>
        textTheme.titleSmall?.copyWith(color: colorScheme.onSurface) ??
            TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
      5 =>
        textTheme.bodyLarge?.copyWith(color: colorScheme.onSurface) ??
            TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: colorScheme.onSurface,
            ),
      6 =>
        textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface) ??
            TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: colorScheme.onSurface,
            ),
      _ =>
        textTheme.titleSmall?.copyWith(color: colorScheme.onSurface) ??
            TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
    };
  }

  int _getMediaFlex() => switch (mediaWidth) {
    CardMediaWidth.isOneFifth => 1,
    CardMediaWidth.isOneQuarter => 1,
    CardMediaWidth.isOneThird => 1,
    CardMediaWidth.isTwoFifths => 2,
    CardMediaWidth.isHalf => 1,
  };

  int _getContentFlex() => switch (mediaWidth) {
    CardMediaWidth.isOneFifth => 4,
    CardMediaWidth.isOneQuarter => 3,
    CardMediaWidth.isOneThird => 2,
    CardMediaWidth.isTwoFifths => 3,
    CardMediaWidth.isHalf => 1,
  };

  double _getAspectRatio() => switch (aspectRatio) {
    CardMediaRatio.square => 1.0,
    CardMediaRatio.video => 16 / 9,
    CardMediaRatio.monitor => 4 / 3,
  };

  Widget? _buildAuthorSection(BuildContext context) {
    if (authorName == null && authorProfileImage == null) return null;

    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        if (authorProfileImage != null)
          CircleAvatar(
            radius: 12,
            backgroundImage: NetworkImage(authorProfileImage!),
          )
        else
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: cardColor ?? colorScheme.primary,
              shape: BoxShape.circle,
            ),
          ),
        if (authorName != null) ...[
          const SizedBox(width: 6),
          Flexible(
            child: GestureDetector(
              onTap: authorUrl != null ? () {} : null,
              child: Text(
                authorName!,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: colorScheme.onSurfaceVariant,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget? _buildMetaSection(BuildContext context) {
    final hasPublishedAt = publishedAt != null && publishedAt!.isNotEmpty;
    final hasReadingTime = readingTime != null && readingTime!.isNotEmpty;
    final hasTag = tagName != null && tagName!.isNotEmpty;
    if (!hasPublishedAt && !hasReadingTime && !hasTag) return null;

    final colorScheme = Theme.of(context).colorScheme;
    final children = <Widget>[];

    if (hasPublishedAt) {
      children.add(
        Flexible(
          child: Text(
            publishedAt!,
            style: TextStyle(fontSize: 10, color: colorScheme.onSurfaceVariant),
            maxLines: 1,
          ),
        ),
      );
    }
    if (hasReadingTime) {
      if (hasPublishedAt) {
        children.add(
          Text(
            ' • ',
            style: TextStyle(fontSize: 10, color: colorScheme.onSurfaceVariant),
          ),
        );
      }
      children.add(
        Flexible(
          child: Text(
            readingTime!,
            style: TextStyle(fontSize: 10, color: colorScheme.onSurfaceVariant),
            maxLines: 1,
          ),
        ),
      );
    }
    if (hasTag) {
      if (children.isNotEmpty) {
        children.add(const SizedBox(width: 6));
      }
      children.add(
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: cardColor != null
                  ? cardColor!.withValues(alpha: 0.1)
                  : colorScheme.primaryContainer,
              border: Border.all(color: cardColor ?? colorScheme.outline),
            ),
            child: GestureDetector(
              onTap: tagUrl != null ? () {} : null,
              child: Text(
                tagName!,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: cardColor ?? colorScheme.onPrimaryContainer,
                ),
                maxLines: 1,
              ),
            ),
          ),
        ),
      );
    }

    return Row(mainAxisSize: MainAxisSize.min, children: children);
  }

  Color _blendWithSurface(
    Color color,
    double opacity,
    ColorScheme colorScheme,
  ) {
    final blendedColor = color.withValues(alpha: opacity);
    return Color.alphaBlend(blendedColor, colorScheme.surface);
  }

  Widget? _buildMedia() {
    if (featureImage == null) return null;
    return AspectRatio(
      aspectRatio: _getAspectRatio(),
      child: Image.network(
        featureImage!,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: Icon(
              Icons.error_outline,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          );
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_buildAuthorSection(context) != null) ...[
            _buildAuthorSection(context)!,
            const SizedBox(height: 8),
          ],
          Text(
            title,
            style: _getHeadingStyle(context),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          if (excerpt != null && excerpt!.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(
              excerpt!,
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                height: 1.3,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
          if (_buildMetaSection(context) != null) ...[
            const SizedBox(height: 8),
            _buildMetaSection(context)!,
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final media = _buildMedia();
    final content = _buildContent(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      clipBehavior: Clip.hardEdge,
      color: cardColor != null
          ? _blendWithSurface(cardColor!, 0.05, colorScheme)
          : null,
      elevation: 1,
      child: InkWell(
        onTap: onTap,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = constraints.maxWidth < 600;

            if (mediaAlign == CardMediaAlign.top || media == null) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (media != null && mediaAlign == CardMediaAlign.top) media,
                  content,
                ],
              );
            }

            if (mediaAlign == CardMediaAlign.bottom) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [content, media],
              );
            }

            if (autoLayout && isMobile) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [media, content],
              );
            }

            return IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (mediaAlign == CardMediaAlign.left) ...[
                    Expanded(flex: _getMediaFlex(), child: media),
                    Expanded(flex: _getContentFlex(), child: content),
                  ],
                  if (mediaAlign == CardMediaAlign.right) ...[
                    Expanded(flex: _getContentFlex(), child: content),
                    Expanded(flex: _getMediaFlex(), child: media),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

enum CardMediaAlign { left, right, top, bottom }

enum CardMediaWidth {
  isHalf,
  isTwoFifths,
  isOneThird,
  isOneQuarter,
  isOneFifth,
}

enum CardMediaRatio { monitor, square, video }
