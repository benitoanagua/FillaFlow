import 'package:flutter/material.dart';
import '../utils/ff_shared_utils.dart';
import '../types/ff_types.dart';

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
  final MediaAspectRatio aspectRatio;
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
    this.aspectRatio = MediaAspectRatio.monitor,
    this.autoLayout = false,
    this.onTap,
    this.cardColor,
  });

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

  Widget? _buildAuthorSection(BuildContext context) {
    if (authorName == null && authorProfileImage == null) return null;

    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        if (authorProfileImage != null)
          CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage(authorProfileImage!),
          )
        else
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.person,
              size: 16,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        if (authorName != null) ...[
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              authorName!,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: colorScheme.onSurfaceVariant,
                height: 1.2,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_buildAuthorSection(context) != null) ...[
            _buildAuthorSection(context)!,
            const SizedBox(height: 12),
          ],
          Text(
            title,
            style: FFSharedUtils.getHeadingStyle(context, heading),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          if (excerpt != null && excerpt!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              excerpt!,
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                height: 1.4,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
          if (FFSharedUtils.buildMetaSection(
                context: context,
                publishedAt: publishedAt,
                readingTime: readingTime,
                tagName: tagName,
                accentColor: cardColor,
              ) !=
              null) ...[
            const SizedBox(height: 16),
            FFSharedUtils.buildMetaSection(
              context: context,
              publishedAt: publishedAt,
              readingTime: readingTime,
              tagName: tagName,
              accentColor: cardColor,
            )!,
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final media = FFSharedUtils.buildNetworkImage(
      featureImage,
      aspectRatio: FFSharedUtils.getAspectRatio(aspectRatio),
    );

    final content = _buildContent(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      clipBehavior: Clip.hardEdge,
      color: cardColor != null
          ? Color.alphaBlend(
              cardColor!.withValues(alpha: 0.05),
              colorScheme.surface,
            )
          : colorScheme.surface,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = constraints.maxWidth < 600;

            if (mediaAlign == CardMediaAlign.top || featureImage == null) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (featureImage != null && mediaAlign == CardMediaAlign.top)
                    media,
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
