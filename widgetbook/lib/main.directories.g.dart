// dart format width=80
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AppGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:widgetbook/widgetbook.dart' as _widgetbook;
import 'package:widgetbook_workspace/ff_card.widgetbook.dart'
    as _widgetbook_workspace_ff_card_widgetbook;
import 'package:widgetbook_workspace/ff_carousel.widgetbook.dart'
    as _widgetbook_workspace_ff_carousel_widgetbook;
import 'package:widgetbook_workspace/ff_grid.widgetbook.dart'
    as _widgetbook_workspace_ff_grid_widgetbook;
import 'package:widgetbook_workspace/ff_overlay.widgetbook.dart'
    as _widgetbook_workspace_ff_overlay_widgetbook;
import 'package:widgetbook_workspace/ff_slideshow.widgetbook.dart'
    as _widgetbook_workspace_ff_slideshow_widgetbook;

final directories = <_widgetbook.WidgetbookNode>[
  _widgetbook.WidgetbookFolder(
    name: 'widgets',
    children: [
      _widgetbook.WidgetbookComponent(
        name: 'FFCard',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Aspect Ratio Variations',
            builder: _widgetbook_workspace_ff_card_widgetbook
                .buildFFCardAspectRatioUseCase,
          ),
          _widgetbook.WidgetbookUseCase(
            name: 'Default',
            builder:
                _widgetbook_workspace_ff_card_widgetbook.buildFFCardUseCase,
          ),
          _widgetbook.WidgetbookUseCase(
            name: 'Heading Levels',
            builder: _widgetbook_workspace_ff_card_widgetbook
                .buildFFCardHeadingLevelsUseCase,
          ),
          _widgetbook.WidgetbookUseCase(
            name: 'Media Alignment Variations',
            builder: _widgetbook_workspace_ff_card_widgetbook
                .buildFFCardAlignmentUseCase,
          ),
          _widgetbook.WidgetbookUseCase(
            name: 'Minimal Content',
            builder: _widgetbook_workspace_ff_card_widgetbook
                .buildFFCardMinimalUseCase,
          ),
          _widgetbook.WidgetbookUseCase(
            name: 'Without Image',
            builder: _widgetbook_workspace_ff_card_widgetbook
                .buildFFCardNoImageUseCase,
          ),
        ],
      ),
      _widgetbook.WidgetbookComponent(
        name: 'FFCarousel',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Default',
            builder: _widgetbook_workspace_ff_carousel_widgetbook
                .buildFFCarouselUseCase,
          ),
          _widgetbook.WidgetbookUseCase(
            name: 'Image Cards',
            builder: _widgetbook_workspace_ff_carousel_widgetbook
                .buildFFCarouselImageCardsUseCase,
          ),
          _widgetbook.WidgetbookUseCase(
            name: 'Multiple Items View',
            builder: _widgetbook_workspace_ff_carousel_widgetbook
                .buildFFCarouselMultipleItemsUseCase,
          ),
          _widgetbook.WidgetbookUseCase(
            name: 'Single Item View',
            builder: _widgetbook_workspace_ff_carousel_widgetbook
                .buildFFCarouselSingleItemUseCase,
          ),
        ],
      ),
      _widgetbook.WidgetbookComponent(
        name: 'FFGrid',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Grid Layout',
            builder:
                _widgetbook_workspace_ff_grid_widgetbook.buildFFCardGridUseCase,
          ),
          _widgetbook.WidgetbookUseCase(
            name: 'Grid with Varied Content',
            builder: _widgetbook_workspace_ff_grid_widgetbook
                .buildFFCardVariedGridUseCase,
          ),
        ],
      ),
      _widgetbook.WidgetbookComponent(
        name: 'FFOverlay',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Aspect Ratio Variations',
            builder: _widgetbook_workspace_ff_overlay_widgetbook
                .buildFFMediaAspectRatioVariationsUseCase,
          ),
          _widgetbook.WidgetbookUseCase(
            name: 'Content Variations',
            builder: _widgetbook_workspace_ff_overlay_widgetbook
                .buildFFOverlayContentVariationsUseCase,
          ),
          _widgetbook.WidgetbookUseCase(
            name: 'Default',
            builder: _widgetbook_workspace_ff_overlay_widgetbook
                .buildFFOverlayUseCase,
          ),
          _widgetbook.WidgetbookUseCase(
            name: 'Heading Levels',
            builder: _widgetbook_workspace_ff_overlay_widgetbook
                .buildFFOverlayHeadingLevelsUseCase,
          ),
          _widgetbook.WidgetbookUseCase(
            name: 'Positioning Variations',
            builder: _widgetbook_workspace_ff_overlay_widgetbook
                .buildFFOverlayPositioningVariationsUseCase,
          ),
          _widgetbook.WidgetbookUseCase(
            name: 'Style Variations',
            builder: _widgetbook_workspace_ff_overlay_widgetbook
                .buildFFOverlayStyleVariationsUseCase,
          ),
        ],
      ),
      _widgetbook.WidgetbookComponent(
        name: 'FFSlideshow',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Custom Content',
            builder: _widgetbook_workspace_ff_slideshow_widgetbook
                .buildFFSlideshowCustomContentUseCase,
          ),
          _widgetbook.WidgetbookUseCase(
            name: 'Default',
            builder: _widgetbook_workspace_ff_slideshow_widgetbook
                .buildFFSlideshowUseCase,
          ),
          _widgetbook.WidgetbookUseCase(
            name: 'Minimal Configuration',
            builder: _widgetbook_workspace_ff_slideshow_widgetbook
                .buildFFSlideshowMinimalUseCase,
          ),
          _widgetbook.WidgetbookUseCase(
            name: 'Single Slide',
            builder: _widgetbook_workspace_ff_slideshow_widgetbook
                .buildFFSlideshowSingleUseCase,
          ),
          _widgetbook.WidgetbookUseCase(
            name: 'With Images',
            builder: _widgetbook_workspace_ff_slideshow_widgetbook
                .buildFFSlideshowWithImagesUseCase,
          ),
        ],
      ),
    ],
  ),
];
