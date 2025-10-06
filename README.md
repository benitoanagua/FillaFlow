# FillaFlow - Demo Repository

🚧 **Work in Progress** - Experimental Flutter component library for demonstration purposes only.

## Live Demo

Explore the components in the live WidgetBook showcase:

**[View Live WidgetBook Demo](https://cdn.widgetbook.io/f62307c0-4d3b-4cb4-a856-94c6378e5bc9/93e8e0eb-58b6-47c7-b73e-8b5f1a310873/builds/0a04f099-2179-47b1-bfd4-c00b7f45dad7/index.html)**

## Quick Start

```bash
cd widgetbook
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run -d chrome
```

## Project Overview

This repository contains experimental Flutter components showcased through WidgetBook. The components are currently in development and not production-ready.

**Version:** 0.0.4

## Available Components

- **FFCard**: Flexible card component with multiple layout options
- **FFGrid**: Responsive grid system with three layout types
- **FFOverlay**: Hero overlay component for featured content
- **FFCarousel**: Responsive carousel with sliding behavior
- **FFSlideshow**: Full-screen slideshow component

## WidgetBook Showcases

### FFCard

- Default configuration
- Media alignment variations
- Aspect ratio variations
- Heading levels
- Minimal content examples
- Text-only versions

### FFGrid

- Grid layout with column controls
- Mixed content examples

### FFOverlay

- Default configuration
- Content variations
- Style variations
- Positioning variations
- Aspect ratio variations
- Heading levels

### FFCarousel

- Default configuration
- Image-based carousel
- Single item view
- Multiple items view

### FFSlideshow

- Default configuration
- Image slides
- Minimal configuration
- Custom content
- Single slide demo

## Development Commands

| Command                                                    | Purpose              | Location             |
| ---------------------------------------------------------- | -------------------- | -------------------- |
| `flutter pub get`                                          | Install dependencies | widgetbook/          |
| `dart run build_runner build --delete-conflicting-outputs` | Generate WidgetBook  | widgetbook/          |
| `flutter run -d chrome`                                    | Launch showcase      | widgetbook/          |
| `flutter test`                                             | Run tests            | packages/filla_flow/ |

## Project Structure

```
FillaFlow/
├── packages/filla_flow/     # Component implementations
│   ├── lib/
│   │   ├── filla_flow.dart  # Main export file
│   │   ├── src/
│   │   │   ├── widgets/     # Component widgets
│   │   │   ├── types/       # Type definitions
│   │   │   └── utils/       # Shared utilities
│   │   └── test/           # Component tests
└── widgetbook/              # Demo application
    ├── lib/
    │   ├── main.dart        # Entry point
    │   ├── *.widgetbook.dart # Component showcases
    │   └── main.directories.g.dart # Auto-generated
```

## Component Features

### FFCard

- Flexible media alignment (left, right, top, bottom)
- Multiple aspect ratios (monitor, square, video)
- Responsive layout with auto-layout option
- Rich metadata support (author, tags, reading time)
- Customizable heading levels

### FFGrid

- Three layout types (wrap, fixed, auto)
- Responsive column configuration
- Custom spacing and aspect ratios
- Automatic layout detection

### FFOverlay

- Hero-style overlays with gradient effects
- Multiple positioning options
- Various content box styles
- Flexible overlay fills

### FFCarousel

- Responsive item display
- Auto-play functionality
- Customizable navigation
- Multiple gap sizes

### FFSlideshow

- Full-screen slide presentations
- Auto-play with configurable intervals
- Multiple navigation styles
- Custom content support

## Important Notes

- Components are experimental and may change
- Always run build_runner after modifying WidgetBook files
- Focus development in the widgetbook directory
- Not suitable for production use

## Troubleshooting

- **Build errors**: Run `dart run build_runner build --delete-conflicting-outputs`
- **Missing components**: Regenerate with build_runner
- **Hot reload issues**: Restart the application

Start exploring components by running the commands in the widgetbook directory or check the [live demo](https://cdn.widgetbook.io/f62307c0-4d3b-4cb4-a856-94c6378e5bc9/93e8e0eb-58b6-47c7-b73e-8b5f1a310873/builds/0a04f099-2179-47b1-bfd4-c00b7f45dad7/index.html).
