import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum TabRoundedLineIndicatorSize {
  tiny,
  normal,
  full,
}

class TabRoundedLineIndicator extends Decoration {
  final BuildContext context;
  final double indicatorHeight;
  final Color indicatorColor;
  final TabRoundedLineIndicatorSize indicatorSize;

  TabRoundedLineIndicator(
    this.context, {
    this.indicatorColor,
    this.indicatorHeight = 4,
    this.indicatorSize = TabRoundedLineIndicatorSize.normal,
  });

  @override
  _RoundedLinePainter createBoxPainter([VoidCallback onChanged]) {
    return _RoundedLinePainter(this, onChanged);
  }
}

class _RoundedLinePainter extends BoxPainter {
  final TabRoundedLineIndicator decoration;

  _RoundedLinePainter(this.decoration, VoidCallback onChanged)
      : assert(decoration != null),
        super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration != null);
    assert(configuration.size != null);

    Rect rect;
    if (decoration.indicatorSize == TabRoundedLineIndicatorSize.full) {
      rect = Offset(offset.dx,
              (configuration.size.height - decoration.indicatorHeight ?? 3)) &
          Size(configuration.size.width, decoration.indicatorHeight ?? 3);
    } else if (decoration.indicatorSize == TabRoundedLineIndicatorSize.normal) {
      rect = Offset(offset.dx + 6,
              (configuration.size.height - decoration.indicatorHeight ?? 3)) &
          Size(configuration.size.width - 12, decoration.indicatorHeight ?? 3);
    } else if (decoration.indicatorSize == TabRoundedLineIndicatorSize.tiny) {
      rect = Offset(offset.dx + configuration.size.width / 2 - 8,
              (configuration.size.height - decoration.indicatorHeight ?? 3)) &
          Size(16, decoration.indicatorHeight ?? 3);
    }

    final Paint paint = Paint();
    paint.color =
        decoration.indicatorColor ?? Theme.of(decoration.context).primaryColor;
    paint.style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        rect,
        topRight: Radius.circular(8),
        topLeft: Radius.circular(8),
      ),
      paint,
    );
  }
}
