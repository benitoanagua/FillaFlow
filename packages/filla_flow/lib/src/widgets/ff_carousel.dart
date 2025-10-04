import 'dart:async';
import 'package:flutter/material.dart';
import '../types/ff_types.dart';

class FFCarousel extends StatefulWidget {
  final List<Widget> children;
  final int desktopColumns;
  final int mobileColumns;
  final CarouselGap gap;
  final Duration interval;
  final bool autoPlay;
  final bool showArrows;
  final bool showDots;
  final bool showCounter;
  final NavigationPosition navigationPosition;
  final ValueChanged<int>? onPageChanged;
  final ValueChanged<CarouselNavigation>? onNavigation;

  const FFCarousel({
    super.key,
    required this.children,
    this.desktopColumns = 3,
    this.mobileColumns = 1,
    this.gap = CarouselGap.medium,
    this.interval = const Duration(seconds: 5),
    this.autoPlay = true,
    this.showArrows = true,
    this.showDots = true,
    this.showCounter = false,
    this.navigationPosition = NavigationPosition.bottom,
    this.onPageChanged,
    this.onNavigation,
  });

  @override
  State<FFCarousel> createState() => _FFCarouselState();
}

class _FFCarouselState extends State<FFCarousel> {
  final PageController _pageController = PageController();
  late int _currentPage;
  int _visibleItems = 1;
  Timer? _autoPlayTimer;
  bool _isHovering = false;

  @override
  void initState() {
    super.initState();
    _currentPage = 0;
    _startAutoPlay();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _visibleItems = _calculateVisibleItems();
  }

  @override
  void dispose() {
    _autoPlayTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  int _calculateVisibleItems() {
    final mediaQuery = MediaQuery.of(context);
    return mediaQuery.size.width > 768
        ? widget.desktopColumns
        : widget.mobileColumns;
  }

  int get _pageCount => widget.children.isEmpty
      ? 0
      : (widget.children.length - _visibleItems + 1).clamp(
          1,
          widget.children.length,
        );

  double get _gapSize {
    return switch (widget.gap) {
      CarouselGap.none => 0,
      CarouselGap.small => 8,
      CarouselGap.medium => 16,
      CarouselGap.large => 24,
      CarouselGap.xlarge => 32,
    };
  }

  void _startAutoPlay() {
    if (!widget.autoPlay || _pageCount <= 1) return;

    _autoPlayTimer?.cancel();
    _autoPlayTimer = Timer.periodic(widget.interval, (_) {
      if (!_isHovering && mounted) {
        _goToNextPage();
      }
    });
  }

  void _stopAutoPlay() {
    _autoPlayTimer?.cancel();
  }

  void _goToNextPage() {
    if (_currentPage < _pageCount - 1) {
      _goToPage(_currentPage + 1);
    } else {
      _goToPage(0);
    }
  }

  void _goToPreviousPage() {
    if (_currentPage > 0) {
      _goToPage(_currentPage - 1);
    } else {
      _goToPage(_pageCount - 1);
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
      CarouselNavigation(direction: 'goto', index: page),
    );
  }

  Widget _buildCarouselItem(Widget child) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        child: child,
      ),
    );
  }

  Widget _buildNavigationArrows() {
    if (!widget.showArrows || _pageCount <= 1) return const SizedBox.shrink();

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isAtStart = _currentPage == 0;
    final isAtEnd = _currentPage == _pageCount - 1;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: isAtStart
              ? null
              : () {
                  _goToPreviousPage();
                  widget.onNavigation?.call(
                    CarouselNavigation(
                      direction: 'prev',
                      index: _currentPage - 1,
                    ),
                  );
                },
          style: IconButton.styleFrom(
            backgroundColor: colorScheme.surface,
            foregroundColor: colorScheme.onSurface,
          ),
          tooltip: 'Previous',
        ),
        const SizedBox(width: 16),
        IconButton(
          icon: const Icon(Icons.arrow_forward_ios_rounded),
          onPressed: isAtEnd
              ? null
              : () {
                  _goToNextPage();
                  widget.onNavigation?.call(
                    CarouselNavigation(
                      direction: 'next',
                      index: _currentPage + 1,
                    ),
                  );
                },
          style: IconButton.styleFrom(
            backgroundColor: colorScheme.surface,
            foregroundColor: colorScheme.onSurface,
          ),
          tooltip: 'Next',
        ),
      ],
    );
  }

  Widget _buildDotsIndicator() {
    if (!widget.showDots || _pageCount <= 1) return const SizedBox.shrink();

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_pageCount, (index) {
        return GestureDetector(
          onTap: () {
            _goToPage(index);
            widget.onNavigation?.call(
              CarouselNavigation(direction: 'goto', index: index),
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
    );
  }

  Widget _buildCounter() {
    if (!widget.showCounter || _pageCount <= 1) return const SizedBox.shrink();

    final theme = Theme.of(context);

    return Text(
      '${_currentPage + 1}/$_pageCount',
      style: theme.textTheme.bodyMedium?.copyWith(
        color: theme.colorScheme.onSurfaceVariant,
      ),
    );
  }

  Widget _buildNavigation() {
    if (_pageCount <= 1) return const SizedBox.shrink();

    final children = <Widget>[];

    if (widget.showArrows) {
      children.add(_buildNavigationArrows());
    }

    if (widget.showDots) {
      if (children.isNotEmpty) {
        children.add(const SizedBox(height: 16));
      }
      children.add(_buildDotsIndicator());
    }

    if (widget.showCounter) {
      if (children.isNotEmpty) {
        children.add(const SizedBox(height: 8));
      }
      children.add(_buildCounter());
    }

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(mainAxisSize: MainAxisSize.min, children: children),
    );
  }

  @override
  Widget build(BuildContext context) {
    _visibleItems = _calculateVisibleItems();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.navigationPosition == NavigationPosition.top)
          _buildNavigation(),

        // Flexible carousel content
        Flexible(
          fit: FlexFit.loose,
          child: MouseRegion(
            onEnter: (_) {
              setState(() => _isHovering = true);
              _stopAutoPlay();
            },
            onExit: (_) {
              setState(() => _isHovering = false);
              _startAutoPlay();
            },
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              itemCount: _pageCount,
              itemBuilder: (context, pageIndex) {
                // For traditional carousel behavior, show _visibleItems at a time
                // and slide one item at a time
                final startIndex = pageIndex;
                final endIndex = (startIndex + _visibleItems).clamp(
                  0,
                  widget.children.length,
                );

                final pageChildren = widget.children.sublist(
                  startIndex,
                  endIndex,
                );

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: _gapSize / 2),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: pageChildren.map((child) {
                      return Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: _gapSize / 2,
                          ),
                          child: _buildCarouselItem(child),
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
          ),
        ),

        if (widget.navigationPosition == NavigationPosition.bottom)
          _buildNavigation(),
        if (widget.navigationPosition == NavigationPosition.centered)
          _buildNavigation(),
      ],
    );
  }
}

class CarouselNavigation {
  final String direction;
  final int? index;
  final DateTime timestamp;

  CarouselNavigation({required this.direction, this.index})
    : timestamp = DateTime.now();

  @override
  String toString() {
    return 'CarouselNavigation{direction: $direction, index: $index, timestamp: $timestamp}';
  }
}
