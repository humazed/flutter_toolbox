import 'package:flutter/material.dart';

enum TabRoundedLineIndicatorSize {
  tiny,
  normal,
  full,
}

class TabRoundedLineIndicator extends Decoration {
  final BuildContext context;
  final double indicatorHeight;
  final Color? indicatorColor;
  final TabRoundedLineIndicatorSize indicatorSize;

  const TabRoundedLineIndicator(
    this.context, {
    this.indicatorColor,
    this.indicatorHeight = 4,
    this.indicatorSize = TabRoundedLineIndicatorSize.normal,
  });

  @override
  RoundedLinePainter createBoxPainter([VoidCallback? onChanged]) {
    return RoundedLinePainter(this, onChanged);
  }
}

class RoundedLinePainter extends BoxPainter {
  final TabRoundedLineIndicator decoration;

  RoundedLinePainter(this.decoration, VoidCallback? onChanged)
      : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);

    late Rect rect;
    if (decoration.indicatorSize == TabRoundedLineIndicatorSize.full) {
      rect = Offset(offset.dx,
              (configuration.size!.height - decoration.indicatorHeight)) &
          Size(configuration.size!.width, decoration.indicatorHeight);
    } else if (decoration.indicatorSize == TabRoundedLineIndicatorSize.normal) {
      rect = Offset(offset.dx + 6,
              (configuration.size!.height - decoration.indicatorHeight)) &
          Size(configuration.size!.width - 12, decoration.indicatorHeight);
    } else if (decoration.indicatorSize == TabRoundedLineIndicatorSize.tiny) {
      rect = Offset(offset.dx + configuration.size!.width / 2 - 8,
              (configuration.size!.height - decoration.indicatorHeight)) &
          Size(16, decoration.indicatorHeight);
    }

    final Paint paint = Paint();
    paint.color =
        decoration.indicatorColor ?? Theme.of(decoration.context).primaryColor;
    paint.style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        rect,
        topRight: const Radius.circular(8),
        topLeft: const Radius.circular(8),
      ),
      paint,
    );
  }
}
