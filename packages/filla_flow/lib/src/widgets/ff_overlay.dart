import 'package:flutter/material.dart';
import '../utils/ff_shared_utils.dart';
import '../types/ff_types.dart';

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
          colors: [const Color(0xCC000000), const Color(0xCC000000)],
        );
      case OverlayFill.gradient:
        switch (position) {
          case OverlayPosition.top:
            return LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [const Color(0xCC000000), Colors.transparent],
              stops: const [0.0, 0.6],
            );
          case OverlayPosition.center:
            return LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                const Color(0xCC000000),
                Colors.transparent,
              ],
              stops: const [0.0, 0.5, 1.0],
            );
          case OverlayPosition.bottom:
            return LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, const Color(0xCC000000)],
              stops: const [0.4, 1.0],
            );
        }
      case OverlayFill.none:
        return null;
    }
  }

  Widget _buildContentContainer(BuildContext context, Widget child) {
    final boxDecoration = _getBoxDecoration(context);

    return Container(
      constraints: const BoxConstraints(maxWidth: 600),
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.all(20),
      decoration: boxDecoration,
      child: child,
    );
  }

  BoxDecoration? _getBoxDecoration(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    switch (box) {
      case OverlayBox.background:
        return BoxDecoration(
          color: colorScheme.surface.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: colorScheme.outline.withValues(alpha: 0.2)),
        );
      case OverlayBox.border:
        return BoxDecoration(
          border: Border.all(
            color: colorScheme.onSurface.withValues(alpha: 0.8),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(12),
        );
      case OverlayBox.transparent:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: FFSharedUtils.getAspectRatio(aspectRatio),
      child: Stack(
        children: [
          // Imagen de fondo
          if (featureImage != null && featureImage!.isNotEmpty)
            FFSharedUtils.buildNetworkImage(
              featureImage,
              aspectRatio: FFSharedUtils.getAspectRatio(aspectRatio),
            )
          else
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).colorScheme.primaryContainer,
                    Theme.of(context).colorScheme.secondaryContainer,
                  ],
                ),
              ),
            ),

          // Efecto de overlay
          if (_buildOverlayEffect() != null)
            Positioned.fill(child: _buildOverlayEffect()!),

          // Contenido
          Positioned.fill(
            child: Align(
              alignment: _getAlignment(),
              child: _buildContentContainer(
                context,
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: _getCrossAxisAlignment(),
                  children: [
                    if (FFSharedUtils.buildMetaSection(
                          context: context,
                          publishedAt: publishedAt,
                          readingTime: readingTime,
                          tagName: tagName,
                          isOverlay: true,
                        ) !=
                        null) ...[
                      FFSharedUtils.buildMetaSection(
                        context: context,
                        publishedAt: publishedAt,
                        readingTime: readingTime,
                        tagName: tagName,
                        isOverlay: true,
                      )!,
                      const SizedBox(height: 16),
                    ],
                    MouseRegion(
                      cursor: onTap != null
                          ? SystemMouseCursors.click
                          : SystemMouseCursors.basic,
                      child: GestureDetector(
                        onTap: onTap,
                        child: Text(
                          title,
                          style: FFSharedUtils.getHeadingStyle(
                            context,
                            heading,
                            color: Colors.white,
                          ),
                          textAlign: _getTextAlign(),
                        ),
                      ),
                    ),
                    if (authorName != null && authorName!.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Text(
                        authorName!,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromRGBO(255, 255, 255, 0.9),
                        ),
                        textAlign: _getTextAlign(),
                      ),
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
