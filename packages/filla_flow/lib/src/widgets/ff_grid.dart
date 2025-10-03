import 'package:flutter/material.dart';

enum FFGridType { wrap, fixed, auto }

class FFGrid extends StatelessWidget {
  final int desktopColumns;
  final int tabletColumns;
  final int mobileColumns;
  final double spacing;
  final double runSpacing;
  final FFGridType type;
  final double? childAspectRatio;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final List<Widget> children;

  const FFGrid({
    super.key,
    this.desktopColumns = 4,
    this.tabletColumns = 2,
    this.mobileColumns = 1,
    this.spacing = 16.0,
    this.runSpacing = 16.0,
    this.type = FFGridType.auto,
    this.childAspectRatio,
    this.shrinkWrap = false,
    this.physics,
    required this.children,
  });

  int _calculateColumns(double maxWidth) {
    if (maxWidth > 1200) return desktopColumns;
    if (maxWidth > 600) return tabletColumns;
    return mobileColumns;
  }

  double _calculateChildAspectRatio() {
    return childAspectRatio ?? (type == FFGridType.wrap ? 1.0 : 4 / 3);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = _calculateColumns(constraints.maxWidth);
        final aspectRatio = _calculateChildAspectRatio();

        switch (type) {
          case FFGridType.wrap:
            return _buildWrapGrid(columns);
          case FFGridType.fixed:
            return _buildFixedGrid(columns, aspectRatio);
          case FFGridType.auto:
            return _buildAutoGrid(columns, aspectRatio, constraints.maxWidth);
        }
      },
    );
  }

  Widget _buildWrapGrid(int columns) {
    return Wrap(
      spacing: spacing,
      runSpacing: runSpacing,
      children: children.map((child) {
        return ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: (1200 / columns) - spacing, // Máximo ancho razonable
          ),
          child: child,
        );
      }).toList(),
    );
  }

  Widget _buildFixedGrid(int columns, double aspectRatio) {
    return GridView.builder(
      shrinkWrap: shrinkWrap,
      physics:
          physics ?? (shrinkWrap ? const NeverScrollableScrollPhysics() : null),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        crossAxisSpacing: spacing,
        mainAxisSpacing: runSpacing,
        childAspectRatio: aspectRatio,
      ),
      itemCount: children.length,
      itemBuilder: (context, index) => children[index],
    );
  }

  Widget _buildAutoGrid(int columns, double aspectRatio, double maxWidth) {
    // Decide automáticamente basado en el contenido
    final hasVariableHeight = children.any((child) {
      // Heurística simple: si algún child es una Column sin Expanded, probablemente tenga altura variable
      return true; // Por simplicidad, asumimos altura variable para FFCard
    });

    if (hasVariableHeight) {
      return _buildWrapGrid(columns);
    } else {
      return _buildFixedGrid(columns, aspectRatio);
    }
  }
}
