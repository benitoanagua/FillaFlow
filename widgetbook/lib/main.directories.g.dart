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
import 'package:widgetbook_workspace/ff_grid.widgetbook.dart'
    as _widgetbook_workspace_ff_grid_widgetbook;

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
    ],
  ),
];
