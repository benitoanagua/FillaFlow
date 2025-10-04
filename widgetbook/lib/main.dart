import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'main.directories.g.dart';

void main() {
  runApp(const WidgetbookApp());
}

@widgetbook.App()
class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      directories: directories,
      addons: [
        MaterialThemeAddon(
          themes: [
            WidgetbookTheme(
              name: 'Light (M3)',
              data: ThemeData(
                colorSchemeSeed: Colors.deepPurple,
                useMaterial3: true,
                brightness: Brightness.light,
              ),
            ),
            WidgetbookTheme(
              name: 'Dark (M3)',
              data: ThemeData(
                colorSchemeSeed: Colors.deepPurple,
                useMaterial3: true,
                brightness: Brightness.dark,
              ),
            ),
          ],
        ),

        ViewportAddon([
          IosViewports.iPhone13,
          IosViewports.iPad,
          AndroidViewports.samsungGalaxyS20,
          WindowsViewports.desktop,
        ]),

        GridAddon(50),

        AlignmentAddon(),

        ZoomAddon(),
      ],
    );
  }
}
