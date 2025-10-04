import 'dart:async';
import 'package:flutter/material.dart';
import '../types/ff_types.dart';

class FFSlideshow extends StatefulWidget {
  final List<Widget> children;
  final Duration interval;
  final bool autoPlay;
  final bool showNavigation;
  final bool showIndicators;
  final bool showCounter;
  final NavigationPosition navigationPosition;
  final ValueChanged<int>? onPageChanged;
  final ValueChanged<SlideshowNavigation>? onNavigation;

  const FFSlideshow({
    super.key,
    required this.children,
    this.interval = const Duration(seconds: 5),
    this.autoPlay = true,
    this.showNavigation = true,
    this.showIndicators = true,
    this.showCounter = true,
    this.navigationPosition = NavigationPosition.bottom,
    this.onPageChanged,
    this.onNavigation,
  });

  @override
  State<FFSlideshow> createState() => _FFSlideshowState();
}

class _FFSlideshowState extends State<FFSlideshow> {
  final PageController _pageController = PageController();
  late int _currentPage;
  Timer? _autoPlayTimer;
  bool _isHovering = false;
  bool _forward = true;

  @override
  void initState() {
    super.initState();
    _currentPage = 0;
    _startAutoPlay();
  }

  @override
  void dispose() {
    _autoPlayTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  int get _pageCount => widget.children.length;

  bool get _canGoNext => _currentPage < _pageCount - 1;
  bool get _canGoPrevious => _currentPage > 0;

  void _startAutoPlay() {
    if (!widget.autoPlay || _pageCount <= 1) return;

    _autoPlayTimer?.cancel();
    _autoPlayTimer = Timer.periodic(widget.interval, (_) {
      if (!_isHovering && mounted) {
        if (!_canGoNext) {
          _forward = false;
        }
        if (!_canGoPrevious) {
          _forward = true;
        }

        if (_forward) {
          _goToNextPage();
        } else {
          _goToPreviousPage();
        }
      }
    });
  }

  void _stopAutoPlay() {
    _autoPlayTimer?.cancel();
  }

  void _goToNextPage() {
    if (_canGoNext) {
      _goToPage(_currentPage + 1);
      widget.onNavigation?.call(
        SlideshowNavigation(direction: 'next', index: _currentPage + 1),
      );
    }
  }

  void _goToPreviousPage() {
    if (_canGoPrevious) {
      _goToPage(_currentPage - 1);
      widget.onNavigation?.call(
        SlideshowNavigation(direction: 'prev', index: _currentPage - 1),
      );
    }
  }

  void _goToPage(int page) {
    if (page >= 0 && page < _pageCount) {
      _pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
    widget.onPageChanged?.call(page);
    widget.onNavigation?.call(
      SlideshowNavigation(direction: 'goto', index: page),
    );
  }

  Widget _buildNavigation() {
    if (!widget.showNavigation || _pageCount <= 1)
      return const SizedBox.shrink();

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final children = <Widget>[
      IconButton(
        icon: const Icon(Icons.arrow_back_ios_rounded),
        onPressed: _canGoPrevious ? _goToPreviousPage : null,
        style: IconButton.styleFrom(
          backgroundColor: colorScheme.surface,
          foregroundColor: colorScheme.onSurface,
        ),
        tooltip: 'Previous slide',
      ),
      const SizedBox(width: 16),
    ];

    if (widget.showCounter) {
      children.add(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            '${_currentPage + 1}/$_pageCount',
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: colorScheme.onSurface,
            ),
          ),
        ),
      );
      children.add(const SizedBox(width: 16));
    }

    children.add(
      IconButton(
        icon: const Icon(Icons.arrow_forward_ios_rounded),
        onPressed: _canGoNext ? _goToNextPage : null,
        style: IconButton.styleFrom(
          backgroundColor: colorScheme.surface,
          foregroundColor: colorScheme.onSurface,
        ),
        tooltip: 'Next slide',
      ),
    );

    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: children,
      ),
    );
  }

  Widget _buildIndicators() {
    if (!widget.showIndicators || _pageCount <= 1)
      return const SizedBox.shrink();

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(_pageCount, (index) {
          return GestureDetector(
            onTap: () {
              _goToPage(index);
              widget.onNavigation?.call(
                SlideshowNavigation(direction: 'goto', index: index),
              );
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 8,
              width: _currentPage == index ? 24 : 8,
              decoration: BoxDecoration(
                color: _currentPage == index
                    ? colorScheme.primary
                    : colorScheme.onSurface.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          );
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.navigationPosition == NavigationPosition.top)
          _buildNavigation(),

        // Slideshow content
        Expanded(
          child: MouseRegion(
            onEnter: (_) {
              setState(() => _isHovering = true);
              _stopAutoPlay();
            },
            onExit: (_) {
              setState(() => _isHovering = false);
              _startAutoPlay();
            },
            child: Stack(children: _buildStackChildren()),
          ),
        ),

        if (widget.navigationPosition == NavigationPosition.bottom) ...[
          _buildIndicators(),
          _buildNavigation(),
        ],

        if (widget.navigationPosition == NavigationPosition.centered)
          _buildIndicators(),
      ],
    );
  }

  List<Widget> _buildStackChildren() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final children = <Widget>[
      // Page View
      PageView.builder(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        itemCount: _pageCount,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: widget.children[index],
              ),
            ),
          );
        },
      ),
    ];

    // Add centered navigation if needed
    if (widget.navigationPosition == NavigationPosition.centered) {
      children.addAll([
        Positioned(
          left: 16,
          top: 0,
          bottom: 0,
          child: Center(
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_rounded),
              onPressed: _canGoPrevious ? _goToPreviousPage : null,
              style: IconButton.styleFrom(
                backgroundColor: colorScheme.surface.withValues(alpha: 0.8),
                foregroundColor: colorScheme.onSurface,
              ),
            ),
          ),
        ),
        Positioned(
          right: 16,
          top: 0,
          bottom: 0,
          child: Center(
            child: IconButton(
              icon: const Icon(Icons.arrow_forward_ios_rounded),
              onPressed: _canGoNext ? _goToNextPage : null,
              style: IconButton.styleFrom(
                backgroundColor: colorScheme.surface.withValues(alpha: 0.8),
                foregroundColor: colorScheme.onSurface,
              ),
            ),
          ),
        ),
      ]);
    }

    return children;
  }
}

class SlideshowNavigation {
  final String direction;
  final int? index;
  final DateTime timestamp;

  SlideshowNavigation({required this.direction, this.index})
    : timestamp = DateTime.now();

  @override
  String toString() {
    return 'SlideshowNavigation{direction: $direction, index: $index, timestamp: $timestamp}';
  }
}
